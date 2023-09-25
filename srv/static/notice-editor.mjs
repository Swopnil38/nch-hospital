/* globals tinymce */

import * as base from '/static/base.mjs'


const urlBase = '/api/notice'


function slugify(text) {
    return text.trim().normalize(
        'NFD',  // unicode normalization Form of a given string.
    ).replace(  // replace spaces with dash
        /\s+/g, '-',
    ).replace(  // Remove all non-word chars
        /[^\w-]+/g, '',
    ).replace(  // Replace multiple dash with single
        /--+/g, '-',
    ).slice(0, 100)
}





export function init(id, pk) {
    

    let eInput_title = document.getElementById('ed-title')
    let eInput_message = document.getElementById('ed-message')



    let eForm = document.getElementById(id)
    let searchParams = new URLSearchParams(location.search)
    let stage = searchParams.get('stage')

    if (null == pk) {
        eForm.addEventListener('submit', function (event) {
            event.preventDefault()
            event.stopPropagation()
            eForm.reportValidity()

            let formData = new FormData(eForm)
            formData.set('stage', 'draft')

            base.ajax({
                method   : 'POST',
                url      : `/api${urlBase}/add`,
                formData : formData,
                onPass   : function (xhr) {
                    let responseJSON = JSON.parse(xhr.responseText)
                    window.location.href = `${urlBase}/${responseJSON.pk}/editor#${stage}`
                },
            })

            console.log(url)
        })
        return
    }

    let api = `${urlBase}/${pk}`

    eForm.addEventListener('submit', function (event) {
        event.preventDefault()
        event.stopPropagation()
        eForm.reportValidity()
        console.log(api),
        base.ajax({
            method   : 'PATCH',
            url      : api,
            formData : new FormData(eForm),
            onPass   : function (xhr) {
                if (!confirm('Notice Updated! Do you want to go back ?')) return
                window.location.href = '/notice/dash'
            },
        })
    })

    let eButton_delete = eForm.querySelector('#btn-delete')
    eButton_delete.onclick = function (event) {
        if (!confirm('Delete Record Permanently ?')) return
        base.ajax({
            method : 'DELETE',
            url    : api,
            onPass : function (xhr) {
                window.location.href = '/notice/dash'
            },
        })
    }
}