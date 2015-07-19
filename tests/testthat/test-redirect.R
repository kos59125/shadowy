context("redirect")

test_that("redirect", {
   env <- new.env()
   context <- createContext(env)

   result <- redirectTo("http://www.example.com/")(context)

   expect_true(is.some(result))
   expect_equal(get.option(result)$response$status, 301L)
   expect_equal(get.option(result)$response$headers$"Location", "http://www.example.com/")
})
