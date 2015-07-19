#' Response Body
#' @param \code{value}
#'    a value.
#' @rdname body
#' @export
setBody <- function(value) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$body <- as.character(value)
      some(context)
   })
}

#' @param \code{expr}
#'    a quote object. The value is evaluated at each request.
#' @rdname body
#' @export
setBodyLazy <- function(expr) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$body <- as.character(eval(expr))
      some(context)
   })
}

#' @rdname body
#' @export
emptyBody <- function() {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$body <- ""
      some(context)
   })
}
