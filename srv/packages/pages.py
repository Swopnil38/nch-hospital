import flask
import datetime as dt

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/pkg/dash')
def packagedash():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Packages.title,
        db.hospital.Packages.publishedOn,
        db.hospital.Packages.stages,
        db.hospital.Packages.pk,
    ).order_by(
        db.hospital.Packages.publishedOn.desc()
    )

    return flask.render_template(
        '/packages/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.route('/pkg/<slug>')
def packageSlugRead(slug):
    obj = db.session.query(
        db.hospital.Packages.slug,
        db.hospital.Packages.title,
        db.hospital.Packages.cover,
        db.hospital.Packages.content,
        db.hospital.Packages.publishedOn,
    ).filter(
        db.hospital.Packages.Post.slug == slug,
    ).first()

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/services/post.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        row       = obj,
    )
