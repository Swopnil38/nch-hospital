import datetime as dt

import flask

import db
import db.hospital

import srv.auth
import vendors.rest
import srv.futils

from srv import app


def formHandler(formData):
    if formData is None:
        return None

    return {
        **formData,
        'publishedOn' : dt.datetime.now()
    }


@app.route('/pkg/posts/add/editor')
def packageEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return flask.render_template(
        '/packages/post-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        pkgType    = db.hospital.PkgType,
        obj        = {
            'title'    : '',
            'category' : 'blog',
            'stages'   : 'draft',
            'slug'     : '',
            'cover'    : '',
            'content'  : '',
            'summary'  : '',
        }
    )


@app.route('/pkg/posts/<int:pk>/editor')
def PackageEditorRead(pk=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    obj = db.session.query(
        db.hospital.Packages.pk,

        db.hospital.Packages.slug,
        db.hospital.Packages.title,
        db.hospital.Packages.content,
        db.hospital.Packages.cover,

        db.hospital.Packages.stages,
        db.hospital.Packages.category,
    ).filter(
        db.hospital.Packages.pk == pk
    ).first()

    departmentObj = db.session.query(
        db.hospital.Department.pk,
        db.hospital.Department.department_name
    )

    return flask.render_template(
        '/packages/post-editor.djhtml',
        isAdmin    = isAdmin,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        pkgType    = db.hospital.PkgType,
        pk         = pk,
        obj        = obj,
        department = departmentObj
    )


@app.route('/pkg/posts/<int:pk>')
def packageRead(pk):
    isAdmin = srv.auth.isValid(flask.request)

    query = db.session.query(
        db.hospital.Packages.slug,
        db.hospital.Packages.title,
        db.hospital.Packages.cover,
        db.hospital.Packages.content,
        db.hospital.Packages.publishedOn,
    ).filter(
        db.hospital.Packages.pk == pk,
    ).first()

    return flask.render_template(
        '/packages/post.djhtml',
        isAdmin   = isAdmin,
        row      = query,
    )


@app.post('/api/pkg/posts/add')
def packageCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Packages,
        user      = isAdmin,
    )


@app.patch('/api/pkg/posts/<int:pk>')
def packageUpdate(pk):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.update(
        formData  = formHandler(flask.request.form),
        pk        = pk,
        table     = db.hospital.Packages,
        user      = isAdmin,
    )


@app.delete('/api/pkg/posts/<int:pk>')
def packageDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.delete(
        pk       = pk,
        table    = db.hospital.Packages,
    )
