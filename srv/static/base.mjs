export const i18n = 'en-IN'

export const i18nNumber = new Intl.NumberFormat(i18n, {
    minimumFractionDigits : 2,
})

export const i18nNumberCompact = new Intl.NumberFormat(i18n, {
    notation : 'compact',
})

export const i18nInt = new Intl.NumberFormat(i18n, {
    minimumFractionDigits : 0,
})

export const i18nDate = new Intl.DateTimeFormat(i18n, {
    weekday : 'short',
    year    : 'numeric',
    month   : 'short',
    day     : '2-digit',
})

export const localeMonth = {
    en : [
        '', 'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
    ],
}


export function ajax({xhr, method='GET', url, onFail=true, onPass, payload, params, formData}={}) {
    xhr = xhr || new XMLHttpRequest()

    xhr.onload = function (progressEvent) {
        // if (401 == xhr.status || 403 == xhr.status) return
        if (200 > xhr.status || 300 <= xhr.status) {
            if (null === onFail) return
            if ('function' == typeof onFail) {
                if (undefined === onFail(xhr)) {
                    return
                }
            }
            if (xhr.status == 400) {
                alert(`${url}\n\n${xhr.status} ${xhr.statusText} : Image Size must not exceed 4mb`)
            }else if (xhr.status == 406) {
                alert(`${url}\n\n${xhr.status} ${xhr.statusText} : Duplicate Image. Creating link`)
            }else{
                alert(`${url}\n\n${xhr.status} ${xhr.statusText} : ${xhr.responseText}`)
            }
            return
        }

        if ('function' == typeof onPass) {
            onPass(xhr)
        }
    }

    xhr.onerror = function (args) {
        alert('net::ERR_CONNECTION_REFUSED\nSever Down')
    }

    xhr.open(method, url, true)  // a3 : async = true
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')

    if (null != payload) {
        xhr.send(payload)
        return
    }

    if (null != params) {
        xhr.setRequestHeader('content-type', 'application/json');
        xhr.send(JSON.stringify(params))
        return
    }

    if (null != formData) {
        xhr.send(formData)
        return
    }

    xhr.send()
}
