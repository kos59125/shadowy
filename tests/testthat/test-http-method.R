context("http-method")

test_that("HTTP_METHOD known method", {
   env <- new.env()
   env$REQUEST_METHOD <- "POST"
   context <- createContext(env)

   result <- HTTP_METHOD(c("GET", "POST"))(context)

   expect_true(is.some(result))
   expect_identical(get.option(result), context)
})

test_that("HTTP_METHOD unknown method", {
   env <- new.env()
   env$REQUEST_METHOD <- "HEAD"
   context <- createContext(env)

   result <- HTTP_METHOD(c("GET", "POST"))(context)

   expect_true(is.none(result))
})

## GET
test_that("GET accepts GET", {
   env <- new.env()
   env$REQUEST_METHOD <- "GET"
   context <- createContext(env)

   result <- GET(context)

   expect_true(is.some(result))
   expect_identical(get.option(result), context)
})
test_that("GET rejects POST", {
   env <- new.env()
   env$REQUEST_METHOD <- "POST"
   context <- createContext(env)

   result <- GET(context)

   expect_true(is.none(result))
})
