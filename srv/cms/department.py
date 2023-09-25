import flask
import datetime as dt

import srv
import srv.crud.create as crud
import db
import db.hospital

from srv import app


@app.get('/dept')
def showDept():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Department.pk,
        db.hospital.Department.department_name
    ).order_by(
        db.hospital.Content.publishedOn.desc()
    )
    return flask.render_template(
        '/department/add-dept.html',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),

    )


@app.route('/add/dept')
@app.route('/add/dept/<int:_id>')
def showSingleDept(_id=None):
    if _id:
        return flask.render_template(
            '/department/dept-form.html',
            deleteRoute = '/api/menu/delete',
        )
    else:
        return flask.render_template(
            '/department/dept-form.html',
            obj=None
        )


@app.post('/api/dept/add')
def addDept():
    data = flask.request.form
    obj = db.hospital.Department(
        **data
    )
    if 'rec_status' in data:
        obj.rec_status = 'a'
    else:
        obj.rec_status = 'd'

    obj.created_on = dt.datetime.now()
    db.session.add(obj)
    db.session.commit()
    return flask.redirect(
        '/dept/dash'
    )


@app.delete('/api/dept/delete/<int:_id>')
def deleteDept(_id):
    response = crud.delete(db.hospital.Department, db.hospital.Department.department_id==_id)
    return response


@app.route('/doctor')
def doct():
    response = crud.delete(db.hospital.Department, db.hospital.Department.department_id==_id)
    return flask.render_template(
        '/templates/fend/index.html'
    )
