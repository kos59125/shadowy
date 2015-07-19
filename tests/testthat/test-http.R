context("http")

test_that("%>>%", {
   env <- new.env()
   context <- createContext(env)

   f <- function(context) {
      context$response$body <- "x"
      some(context)
   }
   g <- function(context) {
      context$response$body <- paste0(context$response$body, "y")
      some(context)
   }

   result <- (f %>>% g)(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "xy")
})

test_that("%|>>%", {
   env <- new.env()
   env$PATH_INFO <- "/"
   context <- createContext(env)

   f <- function(context) {
      some("foo")
   }
   g <- function(x) {
      path("/") %>>% setBody(x)
   }

   result <- (f %|>>% g)(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "foo")
})

test_that("route success", {
   env <- new.env()
   env$PATH_INFO <- "/"
   context <- createContext(env)

   f <- as.http.source(function(x) {
      some(NA)
   })
   result <- route(f)(context)

   expect_true(is.some(result))
})

test_that("route fail", {
   env <- new.env()
   env$PATH_INFO <- "/"
   context <- createContext(env)

   f <- as.http.source(function(x) {
      none
   })
   result <- route(f)(context)

   expect_true(is.none(result))
})

test_that("route fail empty", {
   env <- new.env()
   env$PATH_INFO <- "/"
   context <- createContext(env)

   result <- route()(context)

   expect_true(is.none(result))
})
