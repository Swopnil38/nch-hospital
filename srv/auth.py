import flask

from srv import app


app.jinja_env.globals.update(isAdmin=False)


keys = {
    'Basic YWRtaW46bHVuYUBhZG1pbg=='     : 'admin',
    'Basic ZWRpdG9yOmFydGljbGVAcG9zdA==' : 'editor',
    'Basic bWF5dWs6bWF5dWtAbGJj'         : 'mayuk',
}


def isValid(request):
    '''
    returns False  : if Authorization header is not correct
    returns False  : if unauthorized
    returns <user> : if authorized
    '''
    print('X-Forwarded-For', request.headers.get('X-Forwarded-For'))

    auth = request.headers.get('Authorization')
    if auth is None:
        return False

    uname = keys.get(auth)
    if uname is not None:
        return uname

    return False



def respondInValid(): # noqa 
    response = flask.make_response('Unauthorized', 401)
    response.headers['WWW-Authenticate'] = 'Basic realm="Unauthorized"'
    return response


@app.route('/logout')
def logout():
    return respondInValid()
