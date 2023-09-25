import flask
import datetime as dt

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/emp/dash')
def empdash():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.stages,
        db.hospital.Employees.designation,
        db.hospital.Employees.pk,
    ).order_by(
        db.hospital.Employees.publishedOn.desc()
    )

    return flask.render_template(
        '/employees/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.route('/emp')
def emplst():
    query = db.session.query(
        db.hospital.Employees.slug,
        db.hospital.Employees.title,
        db.hospital.Employees.cover,
        db.hospital.Employees.summary,
        db.hospital.Employees.publishedOn,
    ).filter(
        db.hospital.Employees.category == 'blog',
        db.hospital.Employees.slug.is_not(None),
        db.hospital.Employees.publishedOn <= dt.datetime.now(),
    ).order_by(
        db.hospital.Employees.Post.publishedOn.desc(),
    )

    departmentObj = db.session.query(
        db.hospital.Department.pk,
        db.hospital.Department.department_name
    )

    return flask.render_template(
        '/employees/list.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        query     = query,
        department = departmentObj
    )


@app.route('/emp/<slug>')
def empSlugRead(slug):
    obj = db.session.query(
        db.hospital.Employees.slug,
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.content,
        db.hospital.Employees.publishedOn,
    ).filter(
        db.hospital.Employees.slug == slug,
    ).first()

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/employees/post.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        row       = obj,
    )
