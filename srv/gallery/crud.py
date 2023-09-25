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
        'part': 'snippet',
        'maxResults': 10  # Number of videos to fetch
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

@app.route('/gallerys')
def index():
    youtube_videos = get_youtube_videos()
    return render_template('fend/gallery/gallery.html', youtube_videos=youtube_videos)



import datetime as dt

import flask

import db
import db.hospital

import srv.auth
import vendors.rest
import srv.futils



def formHandler(formData):
    if formData is None:
        return None

    return {
        **formData
    }


@app.route('/gallery/posts/add/editor')
def galleryEditor():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()
    
    query = db.session.query(
        db.hospital.Gallery.id,
        db.hospital.Gallery.cover,
    ).order_by(
        db.hospital.Gallery.id.desc()
    )

    return flask.render_template(
        '/gallery/gallery-editor.djhtml',
        isAdmin    = isAdmin,
        pk         = None,
        pageFor    = 'Post',
        stages     = db.hospital.tPostStages,
        obj        = query
    )


@app.post('/api/gallery/posts/add')
def galleryCreate():
    isAdmin = srv.auth.isValid(flask.request)
    if isAdmin is False:
        return srv.auth.respondInValid()

    
    
    return vendors.rest.create(
        formData  = formHandler(flask.request.form),
        table     = db.hospital.Gallery,
        user      = isAdmin,
    )

@app.delete('/api/gallery/posts/delete/<int:pk>')
def galleryDelete(pk):
    if srv.auth.isValid(flask.request) is False:
        return srv.auth.respondInValid()

    return vendors.rest.specialdelete(
        pk       = pk,
        table    = db.hospital.Gallery,
    )




