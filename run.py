#!./venv/bin/python

import srv


if __name__ == '__main__':
    srv.app.run('0.0.0.0', debug=True)
