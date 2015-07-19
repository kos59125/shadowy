#' HTTP Status
#'
#' @param status
#'    an HTTP status code.
#' @rdname status
#' @export
#' @seealso status-informational
#' @seealso status-success
#' @seealso status-redirection
#' @seealso status-client-error
#' @seealso status-server-error
setHttpStatus <- function(status) {
   as.http.source(function(context) {
      stopifnot(is.http.context(context))
      context$response$status <- status
      some(context)
   })
}

############################################################
## HTTP status codes
## http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
############################################################

#' Informational
#' @rdname status-informational
#' @export
CONTINUE <- setHttpStatus(100L)
#' @rdname status-informational
#' @export
SWITCHING_PROTOCOLS <- setHttpStatus(101L)

#' Success
#' @rdname status-success
#' @export
OK <- setHttpStatus(200L)
#' @rdname status-success
#' @export
CREATED <- setHttpStatus(201L)
#' @rdname status-success
#' @export
ACCEPTED <- setHttpStatus(202L)
#' @rdname status-success
#' @export
NON_AUTHORITATIVE_INFORMATION <- setHttpStatus(203L)
#' @rdname status-success
#' @export
NO_CONTENT <- setHttpStatus(204L)
#' @rdname status-success
#' @export
RESET_CONTENT <- setHttpStatus(205L)
#' @rdname status-success
#' @export
PARTIAL_CONTENT <- setHttpStatus(206L)

#' Redirection
#' @rdname status-redirection
#' @export
MULTIPLE_CHOICES <- setHttpStatus(300L)
#' @rdname status-redirection
#' @export
MOVED_PERMANENTLY <- setHttpStatus(301L)
#' @rdname status-redirection
#' @export
FOUND <- setHttpStatus(302L)
#' @rdname status-redirection
#' @export
SEE_OTHER <- setHttpStatus(303L)
#' @rdname status-redirection
#' @export
NOT_MODIFIED <- setHttpStatus(304L)
#' @rdname status-redirection
#' @export
USE_PROXY <- setHttpStatus(305L)
#' @rdname status-redirection
#' @export
TEMPORARY_REDIRECT <- setHttpStatus(307L)

#' Client Error
#' @rdname status-client-error
#' @export
BAD_REQUEST <- setHttpStatus(400L)
#' @rdname status-client-error
#' @export
UNAUTHORIZED <- setHttpStatus(401L)
#' @rdname status-client-error
#' @export
PAYMENT_REQUIRED <- setHttpStatus(402L)
#' @rdname status-client-error
#' @export
FORBIDDEN <- setHttpStatus(403L)
#' @rdname status-client-error
#' @export
NOT_FOUND <- setHttpStatus(404L)
#' @rdname status-client-error
#' @export
METHOD_NOT_ALLOWED <- setHttpStatus(405L)
#' @rdname status-client-error
#' @export
NOT_ACCEPTABLE <- setHttpStatus(406L)
#' @rdname status-client-error
#' @export
PROXY_AUTHENTICATION_REQUIRED <- setHttpStatus(407L)
#' @rdname status-client-error
#' @export
REQUEST_TIMEOUT <- setHttpStatus(408L)
#' @rdname status-client-error
#' @export
CONFLICT <- setHttpStatus(409L)
#' @rdname status-client-error
#' @export
GONE <- setHttpStatus(410L)
#' @rdname status-client-error
#' @export
LENGTH_REQUIRED <- setHttpStatus(411L)
#' @rdname status-client-error
#' @export
PRECONDITION_FAILED <- setHttpStatus(412L)
#' @rdname status-client-error
#' @export
REQUEST_ENTITY_TOO_LARGE <- setHttpStatus(413L)
#' @rdname status-client-error
#' @export
REQUEST_URI_TOO_LONG <- setHttpStatus(414L)
#' @rdname status-client-error
#' @export
UNSUPPORTED_MEDIA_TIME <- setHttpStatus(415L)
#' @rdname status-client-error
#' @export
REQUESTED_RANGE_NOT_SATISFIABLE <- setHttpStatus(416L)
#' @rdname status-client-error
#' @export
EXPECTATION_FAILED <- setHttpStatus(417L)

#' Server Error
#' @rdname status-server-error
#' @export
INTERNAL_SERVER_ERROR <- setHttpStatus(500L)
#' @rdname status-server-error
#' @export
NOT_IMPLEMENTED <- setHttpStatus(501L)
#' @rdname status-server-error
#' @export
BAD_GATEWAY <- setHttpStatus(502L)
#' @rdname status-server-error
#' @export
SERVICE_UNAVAILABLE <- setHttpStatus(503L)
#' @rdname status-server-error
#' @export
GATEWAY_TIMEOUT <- setHttpStatus(504L)
#' @rdname status-server-error
#' @export
HTTP_VERSION_NOT_SUPPORTED <- setHttpStatus(505L)
