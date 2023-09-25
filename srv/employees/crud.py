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

    tags = None
    tags_raw = formData.get('tags')
    if tags_raw is not None:
        tags = set(t for t in tags_raw.split())

    return {
        **formData,
        'tags'        : tags,
        'publishedOn' : dt.datetime.now()
    }


@app.route('/emp/posts/add/editor')
def empEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return flask.render_template(
        '/employees/post-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        obj        = {
            'name'    : '',
            'stages'   : 'draft',
            'tags'     : '',
            'slug'     : '',
            'cover'    : '',
            'content'  : '',
            'summary'  : '',
        }
    )


@app.route('/emp/posts/<int:pk>/editor')
def empEditorRead(pk=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    obj = db.session.query(
        db.hospital.Employees.pk,

        db.hospital.Employees.slug,
        db.hospital.Employees.name,
        db.hospital.Employees.content,

        db.hospital.Employees.tags,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        db.hospital.Employees.mobile,
        db.hospital.Employees.email,
        db.hospital.Employees.landline,
        db.hospital.Employees.cover,
        db.hospital.Employees.stages,
        db.hospital.Employees.department_id,
    ).filter(
        db.hospital.Employees.pk == pk
    ).first()

    departmentObj = db.session.query(
        db.hospital.Department.pk,
        db.hospital.Department.department_name
    )

    return flask.render_template(
        '/employees/post-editor.djhtml',
        isAdmin    = isAdmin,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        pk         = pk,
        obj        = obj,
        department = departmentObj
    )


@app.route('/emp/posts/<int:pk>')
def empRead(pk):
    isAdmin = srv.auth.isValid(flask.request)

    query = db.session.query(
        db.hospital.Employees.slug,
        db.hospital.Employees.title,
        db.hospital.Employees.cover,
        db.hospital.Employees.content,
        db.hospital.Employees.publishedOn,
    ).filter(
        db.hospital.Employees.pk == pk,
    ).first()

    return flask.render_template(
        '/employees/post.djhtml',
        isAdmin   = isAdmin,
        row      = query,
    )


@app.post('/api/emp/posts/add')
def empCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Employees,
        user      = isAdmin,
    )


@app.patch('/api/emp/posts/<int:pk>')
def empUpdate(pk):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.update(
        formData  = formHandler(flask.request.form),
        pk        = pk,
        table     = db.hospital.Employees,
        user      = isAdmin,
    )


@app.delete('/api/emp/posts/<int:pk>')
def empDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.delete(
        pk       = pk,
        table    = db.hospital.Employees,
    )
