#!./venv/bin/python

import db
import sqlalchemy as sa


schema = 'cms'
db.meta.schema = schema

db.session.execute(sa.text(f'CREATE SCHEMA IF NOT EXISTS {schema}'))
db.session.execute(sa.text("COMMIT"))

import db.hospital  # noqa:E402


db.meta.create_all(bind=db.engine, checkfirst=True)
db.session.close()
