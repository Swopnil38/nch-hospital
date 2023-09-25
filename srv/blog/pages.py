import flask
import datetime as dt

import db
import db.hospital

import srv.auth
from srv import app


@app.route('/blog/dash')
def blogdashboard():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.stages,
        db.hospital.Post.publishedOn,
        db.hospital.Post.pk,
    ).order_by(
        db.hospital.Post.publishedOn.desc()
    )

    return flask.render_template(
        '/blog/dash.djhtml',
        query   = query,
        headers = (c['name'] for c in query.column_descriptions),
        isAdmin = isAdmin,
    )


@app.route('/blog')
def bloglist():
    query = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.title,
        db.hospital.Post.cover,
        db.hospital.Post.summary,
        db.hospital.Post.publishedOn,
    ).filter(
        db.hospital.Post.category == 'blog',
        db.hospital.Post.stages == 'publish',
        db.hospital.Post.slug.is_not(None),
        db.hospital.Post.publishedOn <= dt.datetime.now(),
    ).order_by(
        db.hospital.Post.publishedOn.desc(),
    )

    return flask.render_template(
        '/blog/list.djhtml',
        isAdmin   = srv.auth.isValid(flask.request),
        query     = query,
    )


# @app.route('/index')
# def doct():
#     return flask.render_template(
#         '/fend/index.html'
#     )

    
@app.route('/appointment')
def appointment():
    return flask.render_template(
        '/fend/appointment.html'
    )


@app.route('/contact')
def contact():
    return flask.render_template(
        '/fend/contact.html'
    )

@app.route('/department')
def department():
    return flask.render_template(
        '/fend/department/department.html'
    )
@app.route('/doctors')
def doctors():
    return flask.render_template(
        '/fend/doctors/doctor.html'
    )

@app.route('/department_description')
def department_description():
    return flask.render_template(
        '/fend/department/department_description.html'
    )

@app.route('/blog-details')
def blog_Details():
    return flask.render_template(
        '/fend/blogs/single-blog-page.html'
    )




    

