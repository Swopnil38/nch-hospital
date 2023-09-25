import flask

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/assets/uploads/dash')
def uploadDash():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.File.pk,

        db.hospital.File.name,
        db.hospital.File.size,
        db.hospital.File.mime,

        db.hospital.File.route,
    )

    return flask.render_template(
        '/assets/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.route('/assets/uploads/gallery')
@app.route('/assets/uploads/gallery/<recent>')
def getgalleryRoutes(recent=None):
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    if recent is None:
        query = db.session.query(
            db.hospital.File.pk,

            db.hospital.File.name,
            db.hospital.File.size,
            db.hospital.File.mime,

            db.hospital.File.route,
            db.hospitalFile.path,

        ).filter(
            db.hospitalFile.pk.is_not(None),
        ).limit(30)

        return {
            'headers' : tuple(c['name'] for c in query.column_descriptions),
            'data'    : query,
        }

    query = db.session.query(
        db.hospitalFile.pk,

        db.hospitalFile.name,
        db.hospital.File.size,
        db.hospital.File.mime,

        db.hospital.File.route,
        db.hospital.File.path
    ).order_by(
        db.hospital.File.publishedOn.desc()
    ).limit(15)
    print('hello', [c for c in query])
    return {
        'headers' : tuple(c['name'] for c in query.column_descriptions),
        'data'    : query,
    }


@app.route('/assets/uploads/gallery/search/<param>')
def searchParam(param=None):
    query = db.session.query(
        db.hospital.File.pk,

        db.hospital.File.name,
        db.hospital.File.size,
        db.hospital.File.mime,

        db.hospital.File.route,
        db.hospital.File.path,
    ).filter(
        db.hospital.File.name.like(f'%{str(param)}%')
    )

    return {
        'headers' : tuple(c['name'] for c in query.column_descriptions),
        'data'    : query,
    }
