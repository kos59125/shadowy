#' @include http.R
#' @include status.R
#' @include headers.R
NULL

#' Redirect
#' @param location
#'    a URL to go.
#' @rdname redirect
#' @export
redirectTo <- function(location) {
   MOVED_PERMANENTLY %>>% setHeader("Location", location)
}
