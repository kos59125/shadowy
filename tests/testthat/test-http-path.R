context("http-path")

test_that("path success", {
   env <- new.env()
   env$PATH_INFO <- "/person"
   context <- createContext(env)

   result <- path("/person")(context)

   expect_true(is.some(result))
})

test_that("path fail", {
   env <- new.env()
   env$PATH_INFO <- "/person2"
   context <- createContext(env)

   result <- path("/person")(context)

   expect_true(is.none(result))
})

test_that("path.scan", {
   env <- new.env()
   env$PATH_INFO <- "/person/123/age"
   context <- createContext(env)

   f <- function(person_id) {
      some(person_id)
   }
   action <- path.scan("/person/{{person_id}}/age", f)
   result <- action(context)

   expect_true(is.some(result))
   expect_equal(get.option(result), "123")
})

test_that("path.scan", {
   env <- new.env()
   env$PATH_INFO <- "/person/age"
   context <- createContext(env)

   result <- NULL
   f <- function(person_id) {
      person_id
   }
   action <- path.scan("/person/{{person_id}}/age", f)
   result <- action(context)

   expect_true(is.none(result))
})

test_that("path.scan extra arguments", {
   env <- new.env()
   env$PATH_INFO <- "/person/123/age"
   context <- createContext(env)

   f <- function(person_id, foo) {
      some(foo)
   }
   action <- path.scan("/person/{{person_id}}/age", f, foo = 1)
   result <- action(context)

   expect_true(is.some(result))
   expect_equal(get.option(result), 1)
})
