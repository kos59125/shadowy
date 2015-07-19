#' Content Type
#' @export
CONTENT_TYPE <- function(mimeType, charset) {
   contentType <- if (missing(charset)) {
      mimeType
   } else {
      sprintf("%s; charset=%s", mimeType, charset)
   }
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$headers$CONTENT_TYPE <- contentType
      some(context)
   })
}
