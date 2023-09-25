#!./venv/bin/python

import os
import sqlalchemy as sa
import sqlalchemy.ext.declarative
import sqlalchemy.dialects.postgresql

import db


tPostCategory = (
    'event',
    'blog'
)

PkgType = (
    'popular',
    'plan'
)

tPostStages = (
    'draft',
    'publish'
)


class CommonWithUser:
    publishedOn   = sa.Column(sa.DateTime(timezone=True))


class File(db.Base, CommonWithUser):
    __tablename__  = 'files'
    __table_args__ = {
        'schema'   : 'cms',
        'comment'  : 'file tracker',
    }

    pk        = sa.Column(sa.Integer, autoincrement=True, primary_key=True)  # noqa:E501

    name           = sa.Column(sa.String())
    size           = sa.Column(sa.Integer)
    mime           = sa.Column(sa.String())

    path           = sa.Column(sa.String(256), nullable=False)

    # https://dba.stackexchange.com/questions/115271/what-is-the-optimal-data-type-for-an-md5-field
    md5sum         = sa.Column(sqlalchemy.dialects.postgresql.UUID, index=True, unique=True)  # noqa:501
    via            = sa.Column(sa.String(128))
    inode          = sa.Column(sa.Integer())

    # multiple url/routes can serve same file pointed by path
    route          = sa.Column(sa.String(256), unique=True)
    tags           = sa.Column(sa.ARRAY(sa.String(15)), default=[])

    description    = sa.Column(sa.String(128))


class Department(db.Base, CommonWithUser):
    __tablename__ = "department"
    __table_args__ = {"schema": "cms"}

    pk      = sa.Column(sa.Integer(), primary_key=True)
    department_name    = sa.Column(sa.String())


class Notice(db.Base):
    __tablename__ = "notice"
    __table_args__ = {"schema": "cms"}

    pk = sa.Column(sa.Integer(), primary_key=True)
    title = sa.Column(sa.String())
    description = sa.Column(sa.String())
    
class Gallery(db.Base):
    __tablename__ = "gallery"
    __table_args__ = {"schema": "cms"}

    
    id = sa.Column(sa.Integer(), primary_key=True)
    cover = sa.Column(sa.String())

class Content(db.Base, CommonWithUser):
    __tablename__ = "content"
    __table_args__ = {"schema": "cms"}

    pk        = sa.Column(sa.Integer, autoincrement=True, primary_key=True)  # noqa:E501

    slug          = sa.Column(sa.String(100), unique=True)
    title         = sa.Column(sa.String(128))
    content       = sa.Column(sa.Text())
    summary       = sa.Column(sa.String(250))
    tags          = sa.Column(sa.ARRAY(sa.String(15)), default=[])
    links         = sa.Column(sa.String(128))
    linkHeader    = sa.Column(sa.String(128))
    linkCaption   = sa.Column(sa.String(128))

    cover          = sa.Column(sa.String(128))
    symptoms       = sa.Column(sa.Text())
    procedure      = sa.Column(sa.Text())
    treatments     = sa.Column(sa.Text())
    tech           = sa.Column(sa.Text())

    edit          = sa.Column(sa.String(2))
    action        = sa.Column(sa.String(2))
    category      = sa.Column(sa.String(16))
    stages        = sa.Column(sa.String(16))
    subCategory   = sa.Column(sa.String(16))
    department_id  = sa.Column(sa.ForeignKey(Department.pk, ondelete='CASCADE')) # noqa


class Packages(db.Base, CommonWithUser):
    __tablename__ = "packages"
    __table_args__ = {"schema": "cms"}

    pk        = sa.Column(sa.Integer, autoincrement=True, primary_key=True)  # noqa:E501

    slug          = sa.Column(sa.String(100), unique=True)
    title         = sa.Column(sa.String(128))
    content       = sa.Column(sa.Text())
    prices        = sa.Column(sa.Integer())
    category      = sa.Column(sa.String(32))
    cover         = sa.Column(sa.String(128))

    edit          = sa.Column(sa.String(2))
    action        = sa.Column(sa.String(2))
    stages        = sa.Column(sa.String(16))


class Employees(db.Base, CommonWithUser):
    __tablename__ = "employees"
    __table_args__ = {"schema": "cms"}

    pk    = sa.Column(sa.Integer(), primary_key=True)
    name           = sa.Column(sa.String())
    email          = sa.Column(sa.String())
    slug           = sa.Column(sa.String(100), unique=True)
    mobile         = sa.Column(sa.BigInteger())
    landline       = sa.Column(sa.String())
    designation    = sa.Column(sa.String())

    cover          = sa.Column(sa.String(128))

    stages         = sa.Column(sa.String(16))
    edit           = sa.Column(sa.String(8))
    display_order  = sa.Column(sa.Float())

    content        = sa.Column(sa.Text())
    tags           = sa.Column(sa.ARRAY(sa.String(15)), default=[])
    department_id  = sa.Column(sa.ForeignKey(Department.pk, ondelete='CASCADE')) # noqa


class Testimonnials(db.Base, CommonWithUser):
    __tablename__ = "testinmonials"
    __table_args__ = {"schema": "cms"}

    pk = sa.Column(sa.Integer(), primary_key=True)
    name    = sa.Column(sa.String())
    title   = sa.Column(sa.String())
    date    = sa.Column(sa.DateTime(timezone=True))
    cover   = sa.Column(sa.String())
    message = sa.Column(sa.String())
    phone   = sa.Column(sa.BigInteger())
    email   = sa.Column(sa.String())


class Post(db.Base):
    __tablename__  = 'posts'
    __table_args__ = {
        'schema'  : 'cms',
        'comment' : 'blog posts',
    }

    pk        = sa.Column(sa.Integer, autoincrement=True, primary_key=True)  # noqa:E501

    slug           = sa.Column(sa.String(100), unique=True)
    title          = sa.Column(sa.String(128))
    content        = sa.Column(sa.Text())
    summary        = sa.Column(sa.String(250))

    cover          = sa.Column(sa.String(128))

    isSticky       = sa.Column(sa.Boolean(), default=False)
    publishedOn    = sa.Column(sa.DateTime(timezone=True))
    tags           = sa.Column(sa.ARRAY(sa.String(15)), default=[])
    category       = sa.Column(sa.String(16))
    stages         = sa.Column(sa.String(16))
    subCategory    = sa.Column(sa.String(16))
