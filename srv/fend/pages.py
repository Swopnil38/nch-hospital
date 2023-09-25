import flask
import datetime as dt
import sqlalchemy as sa

from srv import app
import db.hospital


@app.route('/')
def home():
    return flask.render_template(
        '/fend/index.html'
    )

@app.post('/api/nch/notices')
def serviceslst():
    query = db.session.query(
        db.hospital.Notice.title,
        db.hospital.Notice.description
    ).order_by(
        db.hospital.Notice.pk.desc(),
    )

    return flask.render_template(
        '/fend/ajax-notice.html',
        query     = query,
    )

@app.post('/api/nch/services')
def noticelst():
    query = db.session.query(
        db.hospital.Content.slug,
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.summary,
        db.hospital.Content.publishedOn,
        db.hospital.Department.department_name,
    ).join(db.hospital.Department,
           db.hospital.Content.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Content.stages == 'publish',
        db.hospital.Content.slug.is_not(None),
        db.hospital.Content.publishedOn <= dt.datetime.now(),
    ).order_by(
        db.hospital.Content.publishedOn.desc(),
    ).limit(10)

    return flask.render_template(
        '/fend/ajax-coe.html',
        query     = query,
    )


@app.post('/api/nch/prices.popular', defaults={'key' : 'popular'})
@app.post('/api/nch/prices.plan', defaults={'key' : 'plan'})
def pricingSection(key):
    query = db.session.query(
        db.hospital.Packages.content,
        db.hospital.Packages.title,
        db.hospital.Packages.cover,
        db.hospital.Packages.prices,
    ).filter(
        db.hospital.Packages.stages == 'publish',
        db.hospital.Packages.category == key,
    ).order_by(
        db.hospital.Packages.publishedOn.desc()
    ).limit(6)

    return flask.render_template(
        '/fend/parts-pricing.djhtml',
        query     = query,
    )


@app.post('/api/nch/dept')
def DepartmentSection():
    query = db.session.query(
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.slug,
        db.hospital.Content.summary,
    ).filter(
        db.hospital.Content.stages == 'publish',
    ).order_by(
        db.hospital.Content.publishedOn.desc(),
    )

    return flask.render_template(
        '/fend/department/parts-dept.djhtml',
        query     = query,
    )


@app.post('/api/nch/specialdoct/<int:deptid>')
def specialDoctors(deptid):
    query = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.slug,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
    ).filter(
        db.hospital.Employees.department_id == deptid,
    ).order_by(
        db.hospital.Employees.display_order.asc(),
    )
    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = query
    )


@app.post('/api/nch/listbod')
def listBOD():
    query = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.slug,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        db.hospital.Employees.department_id,
        db.hospital.Department.department_name,
    ).join(db.hospital.Employees,
           db.hospital.Employees.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Department.department_name != 'admin',
        db.hospital.Employees.designation == 'Board of Director',
    ).order_by(
        db.hospital.Employees.publishedOn.desc(),
        db.hospital.Employees.stages == 'publish'
    )
    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = query
    )

@app.post('/api/nch/listsenior')
def listsenior():
    query = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.slug,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        db.hospital.Employees.department_id,
        db.hospital.Department.department_name,
    ).join(db.hospital.Employees,
           db.hospital.Employees.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Department.department_name != 'admin',
        db.hospital.Employees.designation == 'Senior Management Team',
    ).order_by(
        db.hospital.Employees.publishedOn.desc(),
        db.hospital.Employees.stages == 'publish'
    )
    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = query
    )

@app.post('/api/nch/listdoct')
def listseniormanagement():
    query = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.slug,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        db.hospital.Employees.department_id,
        db.hospital.Department.department_name,
    ).join(db.hospital.Employees,
           db.hospital.Employees.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Department.department_name != 'admin',
        db.hospital.Employees.designation == 'Doctor',
    ).order_by(
        db.hospital.Employees.publishedOn.desc(),
        db.hospital.Employees.stages == 'publish'
    )
    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = query
    )


@app.get('/services/<slug>')
def detailedDepartmentSection(slug):
    row = db.session.query(
        db.hospital.Content.title,
        db.hospital.Content.cover,
        db.hospital.Content.slug,
        db.hospital.Content.content,
        db.hospital.Content.links,
        db.hospital.Content.linkCaption,
        db.hospital.Content.linkHeader,
        db.hospital.Content.symptoms,
        db.hospital.Content.procedure,
        db.hospital.Content.tech,
        db.hospital.Content.treatments,
        db.hospital.Department.department_name,
        db.hospital.Department.pk,
    ).join(db.hospital.Department,
        db.hospital.Content.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Content.slug == str(slug),
    ).first()

    return flask.render_template(
        '/fend/department/department_description.djhtml',
        row     = row,
    )


@app.post('/api/pages/form/search')
def blogSearchRead():
    search = flask.request.form['input']

    obj = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.slug,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
    ).filter(sa.func.lower(db.hospital.Employees.name).like(sa.func.lower(f'%{search}%'))) # noqa

    if obj is None:
        return 'InValid: pk', 400

    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = obj
    )


@app.post('/api/pages/form/search/code')
def blogByTag():
    search = flask.request.form['data']
    print(search)

    subquery = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.slug,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        sa.func.unnest(db.hospital.Employees.tags).label('tag')
    ).subquery()

    obj = db.session.query(
        subquery.c.name,
        subquery.c.slug,
        subquery.c.cover,
        subquery.c.designation,
        subquery.c.display_order,
        sa.func.array_agg(subquery.c.tag).label('tags')
    ).filter(sa.func.lower(subquery.c.tag).ilike(f"%{search.lower()}%")).group_by(
        subquery.c.name,
        subquery.c.slug,
        subquery.c.cover,
        subquery.c.designation,
        subquery.c.display_order
    ).all()

    if obj is None:
        return 'InValid: pk', 400

    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = obj
    )


@app.route('/find-doctor-page')
def find():
    return flask.render_template(
        '/fend/find_doctor/find-doctor-page.html'
    )


@app.post('/api/pages/form/search')
def searchEmpFilter():
    search = flask.request.form['input']

    obj = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Employees.display_order,
        db.hospital.Employees.slug,
    ).filter(sa.func.lower(db.hospital.Employees.name).like(sa.func.lower(f'%{search}%'))) # noqa

    if obj is None:
        return 'InValid: pk', 400

    return flask.render_template(
        '/fend/find_doctor/ajax-emp.djhtml',
        query = obj
    )


@app.route('/doctor/<slug>')
def doctor_details(slug):
    data = db.session.query(
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Employees.content,
        db.hospital.Employees.mobile,
        db.hospital.Employees.email,
    ).join(db.hospital.Department,
           db.hospital.Employees.department_id == db.hospital.Department.pk
    ).filter(db.hospital.Employees.slug == str(slug)).first()
    return flask.render_template(
        '/fend/doctor/doctor-details.djhtml',
        data=data
    )


@app.post('/api/testimonials/list')
def getTestimonials():
    query = db.session.query(
        db.hospital.Testimonnials.name,
        db.hospital.Testimonnials.cover,
        db.hospital.Testimonnials.title,
        db.hospital.Testimonnials.message,
    ).limit(4)
    return flask.render_template(
        '/fend/parts-testimonials.djhtml',
        query=query
    )


@app.route('/blogs')
def blogs():
    return flask.render_template(
        '/fend/blogs/blog.html'
    )


@app.post('/api/blog/list/image')
def getBlogPostfenf():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.summary,
        db.hospital.Post.cover,
        db.hospital.Post.category,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category != 'event').limit(5)
    return flask.render_template(
        '/fend/blogs/parts-blog-image.djhtml',
        query=query
    )

@app.post('/api/blog/list/grid')
def getBlogPostfendnonImage():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.summary,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category != 'event').limit(3)
    return flask.render_template(
        '/fend/parts-testimonials.djhtml',
        query=query
    )


@app.post('/api/blog/list/image/home')
def getBlogPostHome():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.content,
        db.hospital.Post.cover,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category != 'event').limit(2)
    return flask.render_template(
        '/fend/blogs/parts-home-blog.djhtml',
        query=query
    )


@app.post('/api/blog/list/home')
def getBlogPostHomeList():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.content,
        db.hospital.Post.cover,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category != 'event').limit(3)
    return flask.render_template(
        '/fend/blogs/blog-list-home.djhtml',
        query=query
    )


@app.route('/blog/<slug>')
def blogSlugReadField(slug):
    obj = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.title,
        db.hospital.Post.cover,
        db.hospital.Post.content,
        db.hospital.Post.publishedOn,
    ).filter(
        db.hospital.Post.slug == slug,
    ).first()

    query = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.cover,
        db.hospital.Post.title,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category != 'event').limit(4)

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/fend/blogs/single-blog-page.djhtml',
        row       = obj,
        query = query
    )


@app.route('/notices')
def notices():
    return flask.render_template(
        '/fend/notice.html'
    )


@app.post('/api/notice/list/image')
def getBlognoticefenf():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.summary,
        db.hospital.Post.cover,
        db.hospital.Post.category,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category == 'event').limit(5)
    return flask.render_template(
        '/fend/blogs/parts-blog-image.djhtml',
        query=query
    )

@app.post('/api/notice/list/grid')
def getnoticefendnonImage():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.summary,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category == 'event').limit(3)
    return flask.render_template(
        '/fend/parts-testimonials.djhtml',
        query=query
    )


@app.post('/api/notice/list/image/home')
def getBlognoticeHome():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.content,
        db.hospital.Post.cover,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category == 'event').limit(2)
    return flask.render_template(
        '/fend/notice/parts-home-blog.djhtml',
        query=query
    )


@app.post('/api/notice/list/home')
def getBlognoticeHomeList():
    query = db.session.query(
        db.hospital.Post.title,
        db.hospital.Post.slug,
        db.hospital.Post.content,
        db.hospital.Post.cover,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category == 'event').limit(3)
    return flask.render_template(
        '/fend/notice/blog-list-home.djhtml',
        query=query
    )


@app.route('/notice/<slug>')
def noticeSlugReadField(slug):
    obj = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.title,
        db.hospital.Post.cover,
        db.hospital.Post.content,
        db.hospital.Post.publishedOn,
    ).filter(
        db.hospital.Post.slug == slug,
    ).first()

    query = db.session.query(
        db.hospital.Post.slug,
        db.hospital.Post.cover,
        db.hospital.Post.title,
        db.hospital.Post.publishedOn,
    ).filter(db.hospital.Post.category == 'event').limit(4)

    if obj is None:
        return flask.abort(404)

    return flask.render_template(
        '/fend/notice/single-blog-page.djhtml',
        row       = obj,
        query = query
    )



@app.route('/about')
def about():
    return flask.render_template(
        '/fend/about/about.html'
    )
@app.route('/services')
def services():
    return flask.render_template(
        '/fend/services/services.html'
    )

app.route('/notices')
def services():
    return flask.render_template(
        '/fend/notice.html'
    )

@app.route('/img-gallery')
def imggallery():
    return flask.render_template(
        'fend/gallery/gallery.html'
        )

@app.route('/video-gallery')
def videogallery():
    youtube_videos = get_youtube_videos()
    return flask.render_template(
        'fend/video-gallery/videogallery.html',
        youtube_videos=youtube_videos
        )


from flask import render_template
import requests
from srv import app

YOUTUBE_CHANNEL_ID = 'UCNL_v4qEfjibmghIUc_T-iw'
YOUTUBE_API_KEY = 'AIzaSyD1KjsL4ZEkDlHVQiWjbzuzF4zHUMYOhVY'



# Function to fetch YouTube videos
def get_youtube_videos():
    # Use the YouTube Data API to fetch videos from a public YouTube channel
    url = 'https://www.googleapis.com/youtube/v3/search'
    params = {
        'key': YOUTUBE_API_KEY,
        'channelId': YOUTUBE_CHANNEL_ID,
        'part': 'snippet'
    }

    response = requests.get(url, params=params)
    data = response.json()

    if 'items' in data:
        videos = [{
            'title': item['snippet']['title'],
            'video_id': item['id']['videoId'],
            'thumbnail': item['snippet']['thumbnails']['medium']['url']
        } for item in data['items']]
        return videos

    return []






@app.post('/emp/display')
def displayAdminEmployee():
    query = db.session.query(
        db.hospital.Employees.slug,
        db.hospital.Employees.name,
        db.hospital.Employees.cover,
        db.hospital.Employees.designation,
        db.hospital.Department.department_name,
    ).join(db.hospital.Employees,
           db.hospital.Employees.department_id == db.hospital.Department.pk
    ).filter(
        db.hospital.Department.department_name == 'admin',
        db.hospital.Employees.slug.is_not(None),
        db.hospital.Employees.publishedOn <= dt.datetime.now(),
    ).order_by(
        db.hospital.Employees.display_order,
    ).limit(10)
    return flask.render_template(
        '/fend/about/ajax-admin.html',
        query=query
    )

@app.route('/error')
def error():
    return flask.render_template(
        '/fend/error.html'
    )


@app.post('/api/nch/gallerys')
def listgallery():
    query = db.session.query(
        db.hospital.Gallery.id,
        db.hospital.Gallery.cover,
    ).order_by(
        db.hospital.Gallery.id.desc(),
    )

    return flask.render_template(
        '/gallery/gallerys.djhtml',
        query = query
    )


@app.post('/api/nch/gallery')
def ngallery():
    query = db.session.query(
        db.hospital.Gallery.id,
        db.hospital.Gallery.cover,
    ).order_by(
        db.hospital.Gallery.id.desc(),
    )

    return flask.render_template(
        '/gallery/ngallery.djhtml',
        query = query
    )
