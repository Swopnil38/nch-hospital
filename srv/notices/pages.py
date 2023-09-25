# import flask
# import datetime as dt

# import db
# import db.hospital

# import srv.auth
# from srv import app


# @app.route('/notice/dash')
# def noticedash():
#     print('testdash')
#     isAdmin = srv.auth.isValid(flask.request)
#     if isAdmin is False:
#         return srv.auth.respondInValid()

#     query = db.session.query(
#         db.hospital.Notice.title,
#         db.hospital.Notice.description,
#         db.hospital.Notice.pk,
#     ).order_by(
#         db.hospital.Notice.pk.desc()
#     )
    
    
#     db.session.close()

#     return flask.render_template(
#         '/notices/dash.djhtml',
#         query   = query,
#         headers = (c['name'] for c in query.column_descriptions),
#         isAdmin = isAdmin,
#     )


# @app.route('/test/<slug>')
# def testSlugReads(slug):
#     obj = db.session.query(
#         db.hospital.Testimonnials.name,
#         db.hospital.Testimonnials.title,
#         db.hospital.Testimonnials.cover,
#         db.hospital.Testimonnials.content,
#         db.hospital.Testimonnials.publishedOn,
#     ).filter(
#         db.hospital.Testimonnials.Post.slug == slug,
#     ).first()

#     if obj is None:
#         return flask.abort(404)

#     return flask.render_template(
#         '/services/post.djhtml',
#         isAdmin   = srv.auth.isValid(flask.request),
#         row       = obj,
#     )
