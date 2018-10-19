context("test-table")
library(dwpstat)
skip_on_appveyor()
skip_on_cran()
skip_on_travis()


test_that("table query test", {
  z <- dwp_get_data(database = "str:database:PIP_Monthly",
                    measures = "str:count:PIP_Monthly:V_F_PIP_MONTHLY",
                    column = "str:field:PIP_Monthly:V_F_PIP_MONTHLY:SEX")

  expect_length(z, 6)
  expect_length(z$query, 4)
  expect_true(is.data.frame(z$fields))
  expect_true(is.matrix(z$cubes$`str:count:PIP_Monthly:V_F_PIP_MONTHLY`$values))


})
