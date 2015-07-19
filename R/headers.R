#' @include http.R
NULL

#' Content Type
#' @param mimeType
#'    the MIME-Type specified in the response header.
#' @param charset
#'    the character set specified in the response header.
#' @export
CONTENT_TYPE <- function(mimeType, charset) {
   contentType <- if (missing(charset)) {
      mimeType
   } else {
      sprintf("%s; charset=%s", mimeType, charset)
   }
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$headers$"Content-Type" <- contentType
      some(context)
   })
}
