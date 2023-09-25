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


@app.route('/services/posts/add/editor')
def postEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return flask.render_template(
        '/services/post-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        obj        = {
            'title'    : '',
            'category' : '',
            'stages'   : 'draft',
            'tags'     : '',
            'slug'     : '',
            'cover'    : '',
            'content'  : '',
            'summary'  : '',
        }
    )


@app.route('/services/posts/<int:pk>/editor')
def postEditorRead(pk=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    obj = db.session.query(
        db.hospital.Content.pk,

        db.hospital.Content.slug,
        db.hospital.Content.title,
        db.hospital.Content.content,
        db.hospital.Content.summary,
        db.hospital.Content.tags,
        
        db.hospital.Content.links,
        db.hospital.Content.linkCaption,
        db.hospital.Content.linkHeader,

        db.hospital.Content.symptoms,
        db.hospital.Content.procedure,
        db.hospital.Content.treatments,
        
        db.hospital.Content.cover,

        db.hospital.Content.tags,
        db.hospital.Content.category,
        db.hospital.Content.stages,
        db.hospital.Content.department_id,
    ).filter(
        db.hospital.Content.pk == pk
    ).first()
    
  
    
    
    departmentObj = db.session.query(
        db.hospital.Department.pk,
        db.hospital.Department.department_name
    )

    return flask.render_template(
        '/services/post-editor.djhtml',
        isAdmin    = isAdmin,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        pk         = pk,
        obj        = obj,
        department = departmentObj
    )


@app.route('/services/posts/<int:pk>')
def blogRead(pk):
    isAdmin = srv.auth.isValid(flask.request)

    query = db.session.query(
        db.hospital.Content.slug,
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.content,
        db.hospital.Content.publishedOn,
    ).filter(
        db.hospital.Content.pk == pk,
    ).first()

    return flask.render_template(
        '/services/post.djhtml',
        isAdmin   = isAdmin,
        row      = query,
    )


@app.post('/api/services/posts/add')
def postCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()
    
    

    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Content,
        #Print all the data
        
        user      = isAdmin,
    )

from flask import request, jsonify

@app.patch('/api/services/posts/<int:pk>')
def postUpdate(pk):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()
    

    category = request.form.get('category')
    

        # Retrieve the Content object from the database using db.session
   
    content = db.session.query(db.hospital.Content).filter_by(pk=pk).first()

    if content:
        # Update the 'category' field
        content.category = category

        # Commit the changes to the database using db.session
        db.session.commit()
        content = db.session.query(db.hospital.Content).filter_by(pk=pk).first()
        print(content.category)
    else:
        return jsonify({'error': 'Post not found'}), 404

    

    
    return vendors.rest.update(
        formData  = formHandler(flask.request.form),
        pk        = pk,
        table     = db.hospital.Content,
        user      = isAdmin,
    )


@app.delete('/api/services/posts/<int:pk>')
def postDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.delete(
        pk       = pk,
        table    = db.hospital.Content,
    )


