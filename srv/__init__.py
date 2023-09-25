import os
import flask

app = flask.Flask(__name__)

app.secret_key = 'e64ed80969ca77hfe49107d90b157948'

PATH_WD = os.getcwd()

import srv.fend

import srv.services
import srv.packages
import srv.department
import srv.testimonials
import srv.employees
import srv.futils
import srv.assets  # noqa:402
import srv.blog  # noqa:402
import srv.notices
import srv.gallery

import srv.crud.create  # noqa


@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return flask.render_template(
        '/fend/error.html',
        code = 404,
        txt = 'Page Not Found',
        msg = 'The page you’re looking for doesn’t exist'
    ), 404


@app.errorhandler(500)
def server_error(e):
    # note that we set the 404 status explicitly
    return flask.render_template(
        '/fend/error.html',
        code = 500,
        txt = 'Something Went Wrong',
        msg = 'Its Not you, Something inside is not working properly'
    ), 500


@app.route('/vendors/<path:filepath>')
def vendors(filepath):
    return flask.send_from_directory('../vendors', filepath)


@app.route('/assets/<path:filepath>')
def assets(filepath):
    return flask.send_from_directory('../assets', filepath)


@app.route('/media/<path:filepath>')
def media(filepath):
    return flask.send_from_directory('../media', filepath)
