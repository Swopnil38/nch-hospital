import os
import re
import uuid
import hashlib
import traceback
import subprocess
import datetime as dt

import flask
import psycopg2.errors
import sqlalchemy
import sqlalchemy.orm

import db
import db.hospital
import sqlalchemy.exc

import vendors

import srv.auth
import srv.futils

from srv import app


def isDuplicate(e, f, name):
    if isinstance(e.__cause__, psycopg2.errors.UniqueViolation):
        constrant_name = 'ix_{schema}_files_md5sum'.format(
            schema = e.orig.diag.schema_name
        )

        if constrant_name == e.orig.diag.constraint_name:
            md5sum = e.orig.diag.message_detail[14:50]
            obj = db.session.query(
                db.hospital.File.pk,
                db.hospital.File.route,
            ).filter(
                db.hospital.File.md5sum == md5sum,
            ).first()

            # Hardlink for the duplicate file
            ts = str(uuid.uuid4().hex)
            PATH_img = os.path.abspath('.'+obj.route)
            ext = re.findall('\.[^\.]+$', PATH_img)
            PATH_link = re.sub('\/([^\/]+)\.\w+$', f'/{ts}{ext[0]}', PATH_img)
            os.system(f'ln {PATH_img} {PATH_link}')

            inode = subprocess.check_output(
                    [f"stat -c '%i' {PATH_img}"],
                    shell=True
                )

            routeLink = re.sub('\/([^\/]+)\.\w+$', f'/{ts}{ext[0]}', obj.route)

            obj1 = db.hospital.File(
                name      = name,
                size      = f.tell(),
                mime      = f.mimetype,

                via       = PATH_img,
                path      = PATH_link,

                route     = routeLink,
                inode     = int(inode),

                publishedOn = dt.datetime.now()
            )

            Session = sqlalchemy.orm.sessionmaker(bind=db.engine)
            session = Session()
            session.add(obj1)

            session.commit()
            return flask.jsonify({
                **obj._asdict(),
                'ref' : True,
                'msg' : e.__cause__.diag.message_detail,
            }), 406

    traceback.print_exc()

    # HTTP status 409 Conflict
    # request could not be processed because of conflict in the
    # current state of the resource

    return str(e.__cause__), 409


import os

@app.post('/api/assets/uploads/add')
def uploadCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    try:
        f = srv.futils.handler(flask.request.files, 'asset')
    except Exception as e:
        traceback.print_exc()
        return e.__repr__(), 400

    formData = flask.request.form
    if formData is None:
        return 'NotFound: formData', 400

    name = formData.get('name', f.filename)
    path = formData.get('path', name).strip('/')

    URL  = os.path.join('/media', 'uploads')  # pyright:ignore[reportGeneralTypeIssues]  # noqa:501
    NEWFULLPATH = os.path.abspath('.' + URL) + '/'

    fullpath = os.path.join(NEWFULLPATH, path)
    if os.path.exists(fullpath):
        return 'FileExistsError: file exists on given path', 400

    blob = f.read()
    
    print("-----------------TILL POINT ! -----------------------------")
    
    obj = db.hospital.File(
        name      = name,
        size      = f.tell(),
        mime      = f.mimetype,
        path      = os.path.join(NEWFULLPATH, path),
        route     = os.path.join('/media/uploads', path),
        md5sum    = hashlib.md5(blob).hexdigest(),
        publishedOn = dt.datetime.now()
    )
    
    
    print("-----------------TILL POINT !!!!! -----------------------------")

    Session = sqlalchemy.orm.sessionmaker(bind=db.engine)
    session = Session()
    session.add(obj)

    try:
        session.flush()
    except sqlalchemy.exc.DataError as e:
        traceback.print_exc()
        session.rollback()
        return str(e.__cause__), 400
    except sqlalchemy.exc.IntegrityError as e:
        session.rollback()
        return isDuplicate(e, f, name)

    try:
        os.makedirs(os.path.dirname(fullpath), exist_ok=True)
        f.seek(0)  # stream has been read to take out md5sum
        f.save(fullpath)

        # Get inode using os.stat
        inode = os.stat(fullpath).st_ino
        obj.inode = int(inode)
    except PermissionError as e:
        traceback.print_exc()
        session.rollback()
        return e.__repr__(), 403
    session.commit()

    return flask.jsonify(
        pk    = obj.pk,
        route = obj.route,
        ref   = False,
        msg   = 'File Uploaded'
    ), 201


@app.delete('/api/assets/uploads/delete')
@app.delete('/api/assets/uploads/delete/<int:pk>')
def deleteDiv(pk=None):
    if pk is not None:
        obj = db.session.query(
            db.hospital.File.pk,
            db.hospital.File.route
        ).filter(
            db.hospital.File.pk == pk
        ).first()

        PATH_ab = os.path.abspath('.')
        PATH_del = PATH_ab + obj.route
        os.remove(PATH_del)
        vendors.rest.delete(
            pk       = obj.pk,
            table    = db.hospital.File,
        )
        return "Deleted", 200

    route = flask.request.args.get('q')
    obj = db.session.query(
        db.hospital.File.pk,
        db.hospital.File.route
    ).filter(
        db.hospital.File.route == route
    ).first()

    PATH_ab = os.path.abspath('.')
    PATH_del = PATH_ab + obj.route
    os.remove(PATH_del)
    vendors.rest.delete(
        pk       = obj.pk,
        table    = db.hospital.File,
    )
    return "Deleted", 200


@app.route('/api/assets/uploads/tiny/<int:pk>')
def hardlink(pk=None):
    route = flask.request.args.get('q')
    ts = str(uuid.uuid4().hex)

    PATH_img = os.path.abspath('.' + route)

    ext = re.findall('\.[^\.]+$', PATH_img)

    URL  = os.path.join('/media/uploads', 'gallery')  # pyright:ignore[reportGeneralTypeIssues]  # noqa:501
    NEWFULLPATH = os.path.abspath('.') + URL + '/'

    fullpath = NEWFULLPATH + f'{pk}/{ts}{ext[0]}'

    if os.path.exists(fullpath):
        return 'FileExistsError: file exists on given path', 400

    try:
        os.makedirs(os.path.dirname(fullpath), exist_ok=True)
        os.system(f'ln {PATH_img} {fullpath}')
        routeLink = re.sub('\/[^\/]+\/[^\/]+\/.+', f'{pk}/{ts}{ext[0]}', route)
        PATH_new = os.path.join(URL, routeLink)
        print(PATH_new)

    except PermissionError as e:
        traceback.print_exc()
        return e.__repr__(), 403

    return flask.jsonify(data= PATH_new)


@app.post('/api/assets/uploads/scroll/${pk}')
def scrollable(pk):
    draw   = flask.request.json['draw']
    start  = flask.request.json['start']
    length = flask.request.json['length']

    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.File.pk,

        db.hospital.File.name,
        db.hospital.File.size,
        db.hospital.File.mime,

        db.hospital.File.route,
        db.hospital.File.path,

        # db.hospital.File.updatedOn,
        # db.hospital.File.updatedBy,
        # db.hospital.File.createdOn,
        # db.hospital.File.createdBy,
    ).filter(
        db.hospital.File.pk == pk
    ).offset(start).limit(length).all()

    return {
        'headers' : tuple(c['name'] for c in query.column_descriptions),
        'data'    : query,
    }