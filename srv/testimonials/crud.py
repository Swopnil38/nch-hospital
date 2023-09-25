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


@app.route('/test/posts/add/editor')
def testimonialEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return flask.render_template(
        '/testimonials/post-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        obj        = {
            'name'    : '',
            'title'    : '',
            'stages'   : 'draft',
            'slug'     : '',
            'cover'    : '',
            'content'  : '',
            'summary'  : '',
        }
    )


@app.route('/test/posts/<int:pk>/editor')
def testinomialsEditorRead(pk=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    obj = db.session.query(
        db.hospital.Testimonnials.pk,

        db.hospital.Testimonnials.name,
        db.hospital.Testimonnials.title,
        db.hospital.Testimonnials.message,
        db.hospital.Testimonnials.cover,

    ).filter(
        db.hospital.Testimonnials.pk == pk
    ).first()

    return flask.render_template(
        '/testimonials/post-editor.djhtml',
        isAdmin    = isAdmin,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        pk         = pk,
        obj        = obj
    )


@app.route('/test/posts/<int:pk>')
def testimonialRead(pk):
    isAdmin = srv.auth.isValid(flask.request)

    query = db.session.query(
        db.hospital.Testimonnials.name,
        db.hospital.Testimonnials.title,
        db.hospital.Testimonnials.cover,
        db.hospital.Testimonnials.content,
        db.hospital.Testimonnials.publishedOn,
    ).filter(
        db.hospital.Testimonnials.pk == pk,
    ).first()

    return flask.render_template(
        '/testimonials/post.djhtml',
        isAdmin   = isAdmin,
        row      = query,
    )


@app.post('/api/test/posts/add')
def testimonialCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Testimonnials,
        user      = isAdmin,
    )


@app.patch('/api/test/posts/<int:pk>')
def testimonialUpdate(pk):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.update(
        formData  = formHandler(flask.request.form),
        pk        = pk,
        table     = db.hospital.Testimonnials,
        user      = isAdmin,
    )


@app.delete('/api/test/posts/<int:pk>')
def testimonialDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.delete(
        pk       = pk,
        table    = db.hospital.Testimonnials,
    )
