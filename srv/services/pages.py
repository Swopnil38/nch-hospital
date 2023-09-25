import flask
import datetime as dt

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/services/dash')
def blogdash():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Content.title,
        db.hospital.Content.publishedOn,
        db.hospital.Content.stages,
        db.hospital.Content.pk,
    ).order_by(
        db.hospital.Content.publishedOn.desc()
    )

    return flask.render_template(
        '/services/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.post('/nch/services')
def bloglst():
    query = db.session.query(
        db.hospital.Content.slug,
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.summary,
        db.hospital.Content.publishedOn,
    ).filter(
        db.hospital.Content.stages == 'publish',
        db.hospital.Content.slug.is_not(None),
        db.hospital.Content.publishedOn <= dt.datetime.now(),
    ).order_by(
        db.hospital.Content.publishedOn.desc(),
    ).limit(10)

    return flask.render_template(
        '/fend/ajax-coe.html',
        isAdmin   = srv.auth.isValid(flask.request),
        query     = query,
    )


@app.route('/services/<slug>')
def blogSlugRead(slug):
    obj = db.session.query(
        db.hospital.Content.slug,
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.content,
        db.hospital.Content.publishedOn,
    ).filter(
        db.hospital.Content.Post.slug == slug,
    ).first()

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/services/post.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        row       = obj,
    )


@app.post('/fend/coe')
def coe():
    return flask.render_template(
        '/fend/ajax-coe.html'
    )