import os
import flask
import traceback
import datetime as dt
import sqlalchemy as sa


import db


def add(formData, table, fileData=None, UPLOAD_FOLDER=None, cover=None, links=None):
    if formData is None:
        return 'NotFound: formData', 400

    obj = table()

    for col in table.__table__.columns:
        key = col.name

        if key not in formData: continue

        val = formData[key]
        if '' == val: continue
        setattr(obj, key, val)

    obj.created_by = flask.session['user']['id']
    obj.external_links = links
    obj.created_on = dt.datetime.now()

    db.session.add(obj)
    try:
        db.session.commit()

    except sa.exc.IntegrityError as e:
        traceback.print_exc()
        db.session.rollback()
        return str(e.__cause__), 406
    db.session.flush(obj)

    return "Created", 200 


def edit(formData, table, db_filter, contains_switch=False, files=None, cover=None, UPLOAD_FOLDER=None): # noqa
    if formData is None:
        return 'NotFound: formData', 400

    obj = db.session.query(table).filter(db_filter).first()
    # Check for popups and ticker
    if contains_switch is True:
        if 'popup' in formData:
            obj.popup = True
        else:
            obj.popup = False

        if 'ticker' in formData:
            obj.ticker = True
        else:
            obj.ticker = False
        if 'footer' in formData:
            obj.footer = True
        else:
            obj.footer = False

    for key, val in formData.items():
        setattr(obj, key, val)

    try:
        db.session.commit()
    except Exception:
        traceback.print_exc()
        db.session.rollback()

    return "Edited", 200


def delete(table, db_filter):
    obj = db.session.query(table).filter(db_filter)
    obj.delete()
    try:
        db.session.commit()
    except Exception:
        traceback.print_exc()
        db.session.rollback()
    return "Deleted Successfully", 410
