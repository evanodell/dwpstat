#' Submit and receive table queries
#'
#' @param database
#' @param measures
#' @param row
#' @param column
#' @param wafer
#'
#' @return
#' @export
#'
#' @examples



dwp_get_data <- function(database, measures, row, column, wafer) {
  # need to get a json-style body query out of this bad boy somehow

  #body_query <- ## Something something


  json_df = data.frame(
    database = I(database),
    body_query = I(list(measures))
    dimensions = I(list(row, column, wafer))
  )

  body_query <- jsonlite::toJSON(json_df)


  query <- paste0(dwp_baseurl, "table/")

  resp <- dwp_get_data_util(query, body_query)

}
