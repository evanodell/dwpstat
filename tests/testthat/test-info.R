context("test-info")
library(dwpstat)
skip_on_appveyor()
skip_on_cran()
skip_on_travis()

test_that("DWP info function", {

  expect_length(dwp_info(), 1)

})
