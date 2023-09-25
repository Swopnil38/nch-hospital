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


@app.route('/blog/posts/add/editor')
def blogEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return flask.render_template(
        '/blog/post-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        obj        = {
            'title'    : '',
            'category' : 'blog',
            'stages'   : 'draft',
            'tags'     : '',
            'slug'     : '',
            'cover'    : '',
            'content'  : '',
            'summary'  : '',
        }
    )


@app.route('/blog/posts/<int:pk>/editor')
def blogEditorRead(pk=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    obj = db.session.query(
        db.hospital.Post.pk,

        db.hospital.Post.slug,
        db.hospital.Post.title,
        db.hospital.Post.cover,
        db.hospital.Post.content,

        db.hospital.Post.isSticky,
        db.hospital.Post.tags,
        db.hospital.Post.summary,
        db.hospital.Post.category,
        db.hospital.Post.stages,
    ).filter(
        db.hospital.Post.pk == pk
    ).first()

    return flask.render_template(
        '/blog/post-editor.djhtml',
        isAdmin    = isAdmin,
        pageFor    = 'Post',
        categories = db.hospital.tPostCategory,
        stages     = db.hospital.tPostStages,
        pk         = pk,
        obj        = obj,
    )


@app.route('/blog/posts/<int:pk>')
def blogGet(pk):
    isAdmin = srv.auth.isValid(flask.request)

    query = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.title,
        db.hospital.Post.cover,
        db.hospital.Post.content,
        db.hospital.Post.publishedOn,
    ).filter(
        db.hospital.Post.pk == pk,
    ).first()

    return flask.render_template(
        '/blog/post.djhtml',
        isAdmin   = isAdmin,
        row      = query,
    )


@app.post('/api/blog/posts/add')
def blogCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Post,
        user      = isAdmin,
    )


@app.patch('/api/blog/posts/<int:pk>')
def blogUpdate(pk):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    return vendors.rest.update(
        formData  = formHandler(flask.request.form),
        pk        = pk,
        table     = db.hospital.Post,
        user      = isAdmin,
    )


@app.delete('/api/blog/posts/<int:pk>')
def blogDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.delete(
        pk       = pk,
        table    = db.hospital.Post,
    )
