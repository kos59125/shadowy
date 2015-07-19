#' Option
#'
#' Encapsulates the given value as an option value.
#' \code{some} indicates the object has a value, and \code{none} does it has no value.
#'
#' @rdname option
#' @export
some <- function(x) {
   structure(list(x), class = "option")
}
#' @rdname option
#' @export
none <- structure(list(), class = "option")
#' @rdname option
#' @export
is.option <- function(x) {
   inherits(x, "option")
}
#' @rdname option
#' @export
is.some <- function(x) {
   is.option(x) && length(as.list(x)) > 0L
}
#' @rdname option
#' @export
is.none <- function(x) {
   is.option(x) && length(as.list(x)) == 0L
}

#' @rdname option
#' @export
as.option <- function(x) {
   if (missing(x)) {
      none
   } else {
      some(x)
   }
}

#' Get Value
#'
#' Gets the internal value of the specified option value.
#' @param \code{x}
#'    an option value.
#' @return
#'    The internal value.
#' @export
get.option <- function(x) {
   stopifnot(is.some(x))
   x[[1L]]
}

#' Bind Function
#'
#' Applies the specified function to the first option value if the value is some.
#' @param \code{x}
#'    an option value.
#' @return
#'    The internal value.
#' @export
bind.option <- function(x, f) {
   if (is.some(x)) {
      f(x[[1L]])
   } else {
      none
   }
}

#' Print
#'
#' Implementation of \code{print} function for option class.
#' @param \code{option}
#'    an option value.
#' @aliases print
#' @export
print.option <- function(x) {
   if (is.some(x)) {
      cat("some", fill=TRUE)
      print(x[[1L]])
   } else {
      cat("none", fill=TRUE)
   }
   invisible(x)
}
