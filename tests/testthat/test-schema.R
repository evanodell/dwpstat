context("test-schema")
library(dwpstat)
skip_on_appveyor()
skip_on_cran()
skip_on_travis()

test_that("dwp_schema works", {
  a <- dwp_schema()
  expect_length(a, 4)
  # expect_equal(nrow(a), 23)
  expect_equal(names(a)[[1]], "id")
  expect_equal(names(a), c("id", "label", "location", "type"))
  expect_true("str:folder:fesawca" %in% a$id)
  expect_true("Benefit Cap" %in% a$label)

  b1 <- dwp_schema(id="str:database:ESA_Caseload")
  b2 <- dwp_schema(id="database:ESA_Caseload")

  expect_equal(b2, b1)

  expect_error(dwp_schema(id="r:database:ESA_Caseload"),
               "Stat-Xplore API request failed with status 400")

})
