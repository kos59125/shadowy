#' Set URL path
#' @rdname path
#' @export
path <- function(path) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      if (context$request$PATH_INFO == path) {
         some(context)
      } else {
         none
      }
   })
}

#' Set URL path
#' @rdname path
#' @export
path.scan <- function(path, f, ...) {
   extraArgs <- list(...)
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      pattern <- paste0("^", gsub("\\{\\{([A-Za-z0-9._]+)\\}\\}", "(?<\\1>[^/]+)?", path), "$")
      path <- context$request$PATH_INFO
      match <- regexpr(pattern, path, perl = TRUE)
      if (match == 1L) {
         start <- attr(match, "capture.start")
         capture <- substring(path, start, start + attr(match, "capture.length") - 1L)
         capture.names <- attr(match, "capture.names")
         names(capture) <- capture.names
         capture <- as.list(capture)
         do.call(f, append(capture, extraArgs))
      } else {
         none
      }
   })
}
