context("test-rate-limit")
library(dwpstat)
skip_on_appveyor()
skip_on_cran()
skip_on_travis()


test_that("rate limit call works", {
  limit <- dwp_rate_limit()
  expect_length(limit, 3)
  expect_equal(nrow(limit), 1)
  expect_equal(names(limit), c("remaining", "reset", "limit"))
})
