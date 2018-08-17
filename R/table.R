#' Submit and receive table queries
#'
#' @param database The database
#' @param measures The measure to use
#' @param row Row fields
#' @param column Column fields
#' @param wafer Wafer fields
#'
#' @return A tibble
#' @export
#'
#' @examples \dontrun{
#'
#' x <- dwp_get_data(database = "str:database:ESA_Caseload",
#'                   measures = "str:count:ESA_Caseload:V_F_ESA",
#'                   row = "str:field:ESA_Caseload:V_F_ESA:ICDGP",
#'                   column = c("str:field:ESA_Caseload:V_F_ESA:CCSEX",
#'                              "str:field:ESA_Caseload:V_F_ESA:CTDURTN"),
#'                   wafer = "str:field:ESA_Caseload:V_F_ESA:IB_MIG")
#'
#'
#' }



dwp_get_data <- function(database, measures, row, column, wafer) {
  dimensions <- list(# List of dimensions becuase doing this below doesn't work
    row,
    column,
    wafer
  )

  json_df = data.frame(
    database = I(database),
    measures = I(list(measures)),
    dimensions = I(list(dimensions))
  )

  body_query <- as.character(jsonlite::toJSON(json_df, auto_unbox = FALSE))

  body_query <- gsub("^\\[", "", body_query)

  #body_query <- gsub("\\[+$", "", body_query)

  body_query <- gsub('.{1}$', '', body_query)

  query <- paste0(dwp_baseurl, "table/")

  resp <- dwp_get_data_util(query, body_query)

  #resp$cubes

}
