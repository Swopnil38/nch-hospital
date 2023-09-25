let i18n = 'en-IN'

const i18nNumber = new Intl.NumberFormat(i18n, {
    minimumFractionDigits : 2,
})

const i18nNumberCompact = new Intl.NumberFormat(i18n, {
    notation : 'compact',
})

const i18nInt = new Intl.NumberFormat(i18n, {
    minimumFractionDigits : 0,
})

const i18nDate = new Intl.DateTimeFormat('en-US', {
    weekday : 'short',
    year    : 'numeric',
    month   : 'short',
    day     : '2-digit',
})

const i18nDateShort = new Intl.DateTimeFormat('en-US', {
    year    : 'numeric',
    month   : 'short',
    day     : '2-digit',
})
