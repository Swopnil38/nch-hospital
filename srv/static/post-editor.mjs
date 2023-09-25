/* globals tinymce */

import * as base from '/static/base.mjs'


const urlBase = '/blog/posts'


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


function images_upload_handler(blobInfo, progress) {
    // allows you to specify custom upload handler function
    // it will replace auto upload functionality of =images_upload_url
    // https://www.tiny.cloud/docs/tinymce/6/file-image-upload/#images_upload_handler
    // https://www.tiny.cloud/docs/tinymce/6/upload-images/#images_upload_handler

    return new Promise(function (resolve, reject) {
        let xhr = new XMLHttpRequest()
        xhr.withCredentials = false
        xhr.upload.onprogress = function (e) {
            progress(e.loaded / e.total * 100)
        }

        let file = blobInfo.blob()

        let name = prompt('name (32 char)', file.name)
        if (null == name) throw new Error('invalid name')

        let mime = file.type.split('/')[1]
        let path = prompt('path (128 char)', `blog/${(new Date()).valueOf()}.${mime}`)
        if (null == path) throw new Error('invalid path')

        let formData = new FormData()
        formData.append('asset', file, name)
        formData.set('path', path)
        formData.set('via', window.location.pathname + window.location.search)

        // eslint-disable-next-line func-style
        let afterUpload = function (xhr) {
            if (201 != xhr.status && 406 != xhr.status) {
                reject({
                    message : `HTTP Error: ${xhr.status} ${xhr.statusText}`,
                    remove  : true,
                })
                return true
            }
            resolve(JSON.parse(xhr.responseText).route)
        }

        base.ajax({
            xhr      : xhr,
            method   : 'POST',
            url      : '/api/assets/uploads/add',
            formData : formData,
            onPass   : afterUpload,
            onFail   : afterUpload,
        })
    })
}


function coverAction() {
    let eImg_cover = document.getElementById('ed-cover-preview')
    let eInput_cover = document.getElementById('ed-cover')

    eInput_cover.onchange = function (event) {
        eImg_cover.src = eInput_cover.value || '/media/img/1600x900.webp'
    }

    eImg_cover.parentNode.onclick = function (event) {
        file_picker_callback(function (src) {
            eInput_cover.value = src
            eInput_cover.dispatchEvent(new Event('change'))
        }, null, { filetype : 'image' })
    }

    document.getElementById('ed-cover-reset').onclick = function (event) {
        eInput_cover.value = eInput_cover.defaultValue
        eInput_cover.dispatchEvent(new Event('change'))
    }

    document.getElementById('ed-cover-remove').onclick = function (event) {
        eInput_cover.value = ''
        eInput_cover.dispatchEvent(new Event('change'))
    }
}


function file_picker_callback(callback, value, meta) {
    // add file-picker button to image/media insert dialog
    // https://www.tiny.cloud/docs/tinymce/6/file-image-upload/#file_picker_callback

    let eInput = document.createElement('input')
    eInput.type = 'file'

    if ('image' == meta.filetype) {
        eInput.setAttribute('accept', 'image/*')
    }

    eInput.onchange = function (event) {
        let file = eInput.files[0]
        if (undefined === file) return

        let name = prompt('name (32 char)', file.name)
        if (null == name) throw new Error('invalid name')

        let mime = file.type.split('/')[1]
        let path = prompt('path (128 char)', `blog/${(new Date()).valueOf()}.${mime}`)
        if (null == path) throw new Error('invalid path')

        let formData = new FormData()
        formData.set('asset', file, name)
        formData.set('path', path)
        formData.set('via', window.location.pathname + window.location.search)

        // eslint-disable-next-line func-style
        let afterUpload = function (xhr) {
            if (201 != xhr.status && 406 != xhr.status) return true
            let responseJSON = JSON.parse(xhr.responseText)
            callback(responseJSON.route, {
                text  : file.name,  // for anchor link text
                title : file.name,  // for anchor link hover
            })
        }

        base.ajax({
            method   : 'POST',
            url      : '/api/assets/uploads/add',
            formData : formData,
            onPass   : afterUpload,
            onFail   : afterUpload,
        })
    }

    eInput.click()
}


export function init(id, pk) {
    coverAction()

    let eInput_title = document.getElementById('ed-title')
    let eInput_slug = document.getElementById('ed-slug')
    eInput_title.onkeyup = function (event) {
        eInput_slug.value = slugify(eInput_title.value)
    }

    let eDetails = document.getElementById('ed-summary-details')
    let eButton_gen = document.getElementById('ed-btn-gen-summary')
    let eTextarea = document.getElementById('ed-summary')

    tinymce.init({
        // https://www.tiny.cloud/docs/tinymce/6/full-featured-open-source-demo/
        selector                   : '#ed-content',
        custom_undo_redo_levels    : 10,
        promotion                  : false,
        relative_urls              : false,
        height                     : 500,
        file_picker_callback       : file_picker_callback,
        images_upload_handler      : images_upload_handler,
        images_reuse_filename      : true,
        toolbar                    : 'alignleft aligncenter alignright alignjustify | bullist numlist blocks | forecolor backcolor | emoticons | link image media | fullscreen',
        visualblocks_default_state : true,
        plugins                    : [
            'autolink',       // https://www.tiny.cloud/docs/tinymce/6/autolink/ auto creates hyperlinks to valid URL
            'code',           // https://www.tiny.cloud/docs/tinymce/6/code/ edit your contents HTML source
            'emoticons',      // https://www.tiny.cloud/docs/tinymce/6/emoticons/
            'fullscreen',     // https://www.tiny.cloud/docs/tinymce/6/fullscreen/
            'link',           // https://www.tiny.cloud/docs/tinymce/6/link/ create hyperlink
            'lists',          // https://www.tiny.cloud/docs/tinymce/6/lists/
            'preview',        // https://www.tiny.cloud/docs/tinymce/6/preview/
            'searchreplace',  // https://www.tiny.cloud/docs/tinymce/6/searchreplace/
            'image',          // https://www.tiny.cloud/docs/tinymce/6/image/
            'media',          // https://www.tiny.cloud/docs/tinymce/6/media/
            'wordcount',      // https://www.tiny.cloud/docs/tinymce/6/wordcount/
            'table',          // https://www.tiny.cloud/docs/tinymce/6/table/
            'visualblocks',   // https://www.tiny.cloud/docs/tinymce/6/visualblocks/
        ],
    }).then(function (a) {
        let tiny = a[0]
        eButton_gen.onclick = function (event) {
            eTextarea.value = tiny.getContent({ format: 'text' }).slice(0, 200)
            eDetails.open = true
        }
    })

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
        })
        return
    }

    let api = `/api${urlBase}/${pk}`

    eForm.addEventListener('submit', function (event) {
        event.preventDefault()
        event.stopPropagation()
        eForm.reportValidity()

        base.ajax({
            method   : 'PATCH',
            url      : api,
            formData : new FormData(eForm),
            onPass   : function (xhr) {
                if (!confirm('Post Updated! Do you want to go back ?')) return
                window.location.href = '/blog/dash'
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
                window.location.href = '/blog/dash'
            },
        })
    }
}