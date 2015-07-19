context("body")

suppressPackageStartupMessages(library(magrittr))

test_that("setBody", {
   env <- new.env()
   context <- createContext(env)

   result <- setBody("foo")(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "foo")
})

test_that("setBodyLazy", {
   env <- new.env()
   context <- createContext(env)
   context$response$body <- "foo"

   ## Get expected values
   set.seed(1L)
   expected1 <- runif(1L)
   expected2 <- runif(1L)

   ## Reset seed.
   set.seed(1L)

   ## first call
   result <- setBodyLazy(quote(runif(1L)))(context)
   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, as.character(expected1))

   ## second call
   result <- setBodyLazy(quote(runif(1L)))(context)
   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, as.character(expected2))
})

test_that("emptyBody", {
   env <- new.env()
   context <- createContext(env)
   context$response$body <- "foo"

   result <- emptyBody()(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "")
})
