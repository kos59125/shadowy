#' @include http.R
NULL

#' Set Header
#' @param key
#'    a response header key.
#' @param value
#'    the value.
#' @format http.source
#' @export
setHeader <- function(key, value) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$headers[key] <- value
      some(context)
   })
}

#' Content Type
#' @param mimeType
#'    the MIME-Type specified in the response header.
#' @param charset
#'    the character set specified in the response header.
#' @format http.source
#' @export
CONTENT_TYPE <- function(mimeType, charset) {
   contentType <- if (missing(charset)) {
      mimeType
   } else {
      sprintf("%s; charset=%s", mimeType, charset)
   }
   setHeader("Content-Type", contentType)
}
