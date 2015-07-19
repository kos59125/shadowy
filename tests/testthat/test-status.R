context("status")

test_that("setHttpStatus", {
   env <- new.env()
   context <- createContext(env)

   result <- setHttpStatus(999L)(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$status, 999L)
})

test_that("NOT_FOUND", {
   env <- new.env()
   context <- createContext(env)

   result <- NOT_FOUND(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$status, 404L)
})
