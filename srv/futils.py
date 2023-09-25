import os
import traceback

import werkzeug
import werkzeug.datastructures


class MissingFilesDataError(Exception):
    pass


def handler(filesData, key, fullpath=None, dirname=None) -> werkzeug.datastructures.FileStorage:  # noqa:E501
    if filesData is None:
        raise MissingFilesDataError('NotFound: filesData')

    f = filesData.get(key)

    if f is None:
        raise KeyError('NotFound: fileData is empty')

    if '' == f.filename:
        raise NameError('NoName: file payload has no name')

    if dirname is not None:
        if fullpath is None:
            fullpath = os.path.join(dirname, f.filename)

    if fullpath is not None:
        if os.path.exists(fullpath):
            raise FileExistsError
        f.save(fullpath)
        # print(os.stat(FILE).st_size)

    return f
