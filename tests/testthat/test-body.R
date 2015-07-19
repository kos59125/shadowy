context("body")

suppressPackageStartupMessages(library(magrittr))

test_that("setBody", {
   env <- new.env()
   context <- createContext(env)

   result <- setBody("foo")(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "foo")
})

test_that("editBody", {
   env <- new.env()
   context <- createContext(env)
   context$response$body <- "foo"

   result <- editBody(. %>% rep(2) %>% paste(collapse = " "))(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$body, "foo foo")
})

test_that("emptyBody", {
   env <- new.env()
   context <- createContext(env)
   context$response$body <- "foo"

   result <- emptyBody()(context)

   expect_true(is.some(result))
   expect_true(is.null(get.option(result)$response$body))
})
