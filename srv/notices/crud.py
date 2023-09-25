import json
import flask
import traceback
import datetime as dt
import srv

import srv.crud.create as crud
import db
import db.hospital

from srv import app


@app.get('/notice/dash')
def showNotice():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Notice.pk,
        db.hospital.Notice.title,
        db.hospital.Notice.description,
    ).order_by(
        db.hospital.Notice.pk.desc()
    )
    # close datbase session
    db.session.close()
    return flask.render_template(
        '/notices/dash.html',
        query=query,
        headers=(c['name'] for c in query.column_descriptions),

    )


@app.post('/api/notice/add')
def addNotice():
    
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    data = flask.request.form

    obj = db.hospital.Notice(
        **data
    )
    obj.created_on = dt.datetime.now()
    db.session.add(obj)
    db.session.commit()
                
    return flask.redirect(
        '/notice/dash'
    )


@app.delete('/api/notice/delete/<int:_id>')
def deleteNotice(_id):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    response = crud.delete(db.hospital.Notice, db.hospital.Notice.pk == _id)
    return response


@app.route('/edit/notice/<int:id>')
def editNotice(id):
    try:
        department = db.session.query(db.hospital.Notice).filter_by(pk=id).first()
    except:
        traceback.print_exc()
        return "Notice not found"
    return flask.render_template(
        '/notices/edit.html',
        obj=department
    )

@app.post('/api/notice/edit/<int:id>')
def updateNotice(id):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    department = db.session.query(db.hospital.Notice).filter_by(pk=id).first()
    if department is None:
        return "Notice not found"

    data = flask.request.form
    for key, value in data.items():
        setattr(department, key, value)
    db.session.commit()
    return flask.redirect('/notice/dash')


@app.route('/add/notice')
@app.route('/add/notice/<int:_id>')
def showSingleNotice(_id=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()
    if _id:
        return flask.render_template(
            '/notices/dept-form.html',
            deleteRoute='/api/menu/delete',
        )
    else:
        return flask.render_template(
            '/notices/form.html',
            obj=None
        )
        
 