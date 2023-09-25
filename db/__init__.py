import os

import sqlalchemy as sa
import sqlalchemy.orm

password = 'root'

engine = sa.create_engine(
    url          = f'postgresql://postgres:{password}@localhost:5432/hospital',
    echo         = bool(os.getenv('DEBUG')),  # argopt has'nt been used
    connect_args = {
        'options' : '-c timezone=Asia/Kathmandu',
    }
)

meta = sa.MetaData(schema=None)

Session = sqlalchemy.orm.scoped_session(sqlalchemy.orm.sessionmaker(bind=engine))
session = Session()


class Base(sqlalchemy.orm.DeclarativeBase):
    metadata = meta
    pass