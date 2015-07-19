#' HTTP Context
#'
#' @param env
#'    an environment object that has request information.
#' @param status
#'    default HTTP status code.
#' @param headers
#'    default HTTP response header list.
#' @param body
#'    default response body.
#' @param x
#'    a value.
#' @rdname http.context
#' @export
createContext <- function(env, status = 200L, headers = list(), body = "") {
   structure(
      ## default status is NOT_FOUND.
      list(request = env, response = list(status = status, headers = headers, body = body)),
      class = "http.context"
   )
}

#' @rdname http.context
#' @export
is.http.context <- function(x) {
   inherits(x, "http.context")
}

#' HTTP Source
#'
#' @param f
#'    a function.
#' @param x
#'    a value.
#' @rdname http.source
#' @export
as.http.source <- function(f) {
   stopifnot(is.function(f))
   structure(f, class = "http.source")
}
#' @rdname http.source
#' @export
is.http.source <- function(x) {
   inherits(x, "http.source")
}

#' Bind Source
#'
#' @param first
#'    the first function to call.
#' @param second
#'    the second function to call.
#' @rdname bind
#' @export
`%>>%` <- function(first, second) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      bind.option(first(context), second)
   })
}
#' @rdname bind
#' @export
`%|>>%` <- function(first, second) {
   as.http.source(function(context) {
      result <- first(context)
      if (is.some(result)) {
         second(get.option(result))(context)
      } else {
         none
      }
   })
}

#' Select Source
#'
#' @param ...
#'    list of http.source.
#' @rdname route
#' @export
route <- function(...) {
   sourceList <- list(...)
   for (i in seq_along(sourceList)) {
      if (!is.http.source(sourceList[[i]])) {
         stop("Not http.source: ", i)
      }
   }
   as.http.source(function(x) {
      for (f in sourceList) {
         y <- f(x)
         if (is.some(y)) {
            return(y)
         }
      }
      none
   })
}
