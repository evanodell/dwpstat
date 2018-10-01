## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----schema-a------------------------------------------------------------
library(tibble)

a <- dwp_schema()

glimpse(a)

## ----schema-b------------------------------------------------------------
b <- dwp_schema("str:folder:fesa")

glimpse(b)

## ----schema-c------------------------------------------------------------
c <- dwp_schema("str:database:ESA_Caseload")

glimpse(c)

## ----schema-d------------------------------------------------------------
d <- dwp_schema("str:field:ESA_Caseload:V_F_ESA:CTDURTN")

glimpse(d)

## ----schema-e------------------------------------------------------------
e <- dwp_schema("str:valueset:ESA_Caseload:V_F_ESA:CTDURTN:C_ESA_DURATION")

glimpse(e)

## ------------------------------------------------------------------------
library(purrr)
pip <- dwp_get_data(database = "str:database:PIP_Monthly",
                  measures = "str:count:PIP_Monthly:V_F_PIP_MONTHLY",
                  column = "str:field:PIP_Monthly:V_F_PIP_MONTHLY:SEX",
                  row = "str:field:PIP_Monthly:F_PIP_DATE:DATE2")

pip2 <- as.data.frame(map(pip$cubes, "values"))

pip_names <- pip$fields$items

names(pip2) <- pip_names[[2]]$labels

pip2$date <- pip_names[[1]]$labels


