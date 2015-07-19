#' @include http.R
#' @include option.R
NULL

#' Creates a Rook application.
#' @param action
#'    an http.source object.
#' @export
api <- function(action) {
   function(env) {
      tryCatch({
         context <- createContext(env)
         result <- action(context)
         if (is.some(result)) {
            get.option(result)$response
         } else {
            path <- env$PATH_INFO
            list(
               status = 404L,
               headers = list(CONTENT_TYPE = "text/plain"),
               body = sprintf("The requested path '%s' is not found.", path)
            )
         }
      }, error = function(e) {
         list(
            status = 500L,
            headers = list(CONTENT_TYPE = "text/plain"),
            body = sprintf("Internal Server Error: %s", e)
         )
      })
   }
}
