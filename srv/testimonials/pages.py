import flask
import datetime as dt

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/test/dash')
def testdash():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Testimonnials.name,
        db.hospital.Testimonnials.title,
        db.hospital.Testimonnials.publishedOn,
        db.hospital.Testimonnials.pk,
    ).order_by(
        db.hospital.Testimonnials.publishedOn.desc()
    )

    return flask.render_template(
        '/testimonials/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.route('/test/<slug>')
def testSlugRead(slug):
    obj = db.session.query(
        db.hospital.Testimonnials.name,
        db.hospital.Testimonnials.title,
        db.hospital.Testimonnials.cover,
        db.hospital.Testimonnials.content,
        db.hospital.Testimonnials.publishedOn,
    ).filter(
        db.hospital.Testimonnials.Post.slug == slug,
    ).first()

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/services/post.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        row       = obj,
    )
