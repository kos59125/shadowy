context("headers")

test_that("set content-type with charset", {
   env <- new.env()
   context <- createContext(env)

   result <- CONTENT_TYPE("text/plain", "utf-8")(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$headers$CONTENT_TYPE, "text/plain; charset=utf-8")
})

test_that("set content-type without charset", {
   env <- new.env()
   context <- createContext(env)

   result <- CONTENT_TYPE("application/json")(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$headers$CONTENT_TYPE, "application/json")
})
