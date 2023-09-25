import json
import flask
import traceback
import datetime as dt
import srv

import srv.crud.create as crud
import db
import db.hospital

from srv import app


@app.get('/dept/dash')
def showDept():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Department.department_name,
        db.hospital.Department.pk,
    ).order_by(
        db.hospital.Department.publishedOn.desc()
    )
    
    db.session.close()
    return flask.render_template(
        '/department/dash.html',
        query=query,
        headers=(c['name'] for c in query.column_descriptions),

    )


@app.route('/add/dept')
@app.route('/add/dept/<int:_id>')
def showSingleDept(_id=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()
    if _id:
        return flask.render_template(
            '/department/dept-form.html',
            deleteRoute='/api/menu/delete',
        )
    else:
        return flask.render_template(
            '/department/form.html',
            obj=None
        )


@app.post('/api/dept/add')
def addDept():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    data = flask.request.form
    obj = db.hospital.Department(
        **data
    )
    obj.created_on = dt.datetime.now()
    db.session.add(obj)
    db.session.commit()
    return flask.redirect(
        '/dept/dash'
    )


@app.delete('/api/dept/delete/<int:_id>')
def deleteDept(_id):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    response = crud.delete(db.hospital.Department, db.hospital.Department.pk == _id)
    return response


@app.route('/edit/dept/<int:id>')
def editDept(id):
    department = db.session.query(db.hospital.Department).filter_by(pk=id).first()
    return flask.render_template(
        '/department/edit.html',
        obj=department
    )

@app.post('/api/dept/edit/<int:id>')
def updateDept(id):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    department = db.session.query(db.hospital.Department).filter_by(pk=id).first()
    if department is None:
        return "Department not found"

    data = flask.request.form
    for key, value in data.items():
        setattr(department, key, value)
    department.created_on = dt.datetime.now()
    db.session.commit()
    return flask.redirect('/dept/dash')

from flask import jsonify

@app.route('/get_submenu_items_department', methods=['GET'])
def get_submenu_items():
    try:
        # Read all content table titles that have a category named Department
        query = db.session.query(db.hospital.Content.title).filter_by(category='Department').all()
        query2 = db.session.query(db.hospital.Content.title).filter_by(category='Services').all()
        # Convert the query result to a list of titles
        titles1 = [result[0] for result in query]
        titles2 = [result[0] for result in query2]
        
        # Modify the titles to add "Department-of-" before each title
        hrefs1 = ["/services/" + title.replace(" ", "-") for title in titles1]
        hrefs2 = ["/services/Services-of-" + title for title in titles2]
        
        # Create a list of dictionaries with title and href
        submenu_items1 = [{'title': title, 'href': href} for title, href in zip(titles1, hrefs1)]
        submenu_items2 = [{'title': title, 'href': href} for title, href in zip(titles2, hrefs2)]
        
        # Return the submenu items as JSON
        return jsonify(submenu_items1=submenu_items1, submenu_items2=submenu_items2)
    except Exception as e:
        error_message = str(e)
        # You can also log the error for debugging purposes
        print("Error:", error_message)
        # Return an error response with a meaningful error message
        return jsonify({'error': error_message}), 500 
