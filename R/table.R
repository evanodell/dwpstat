
#' Submit and receive table queries
#'
#' Table queries contain the actual data from the DWP database. Due to the
#' complexity of the API data being returned, and to preserve the flexibility
#' of the API query, the API return is not processed into a data frame but is
#' preserved as a list.
#'
#' @param database The ID of the database to query, as a single string.
#' Must be specified.
#' @param measures A character vector of fields to return measures for. Also
#' accepts a string if one measure is being queried. Must be specified.
#' @param column A character vector of fields for the column dimension. Also
#' accepts a string if one measure is being queried. Must be specified.
#' @param row A character vector of fields for the row dimension. Also
#' accepts a string if one measure is being queried. Defaults to `NULL`.
#' @param wafer A character vector of fields for the wafter dimension. Also
#' accepts a string if one measure is being queried. Defaults to `NULL`.
#' @param ... For recode vector. Not in use.
#'
#' @return A list of six levels:
#'
#' 1. `query`The query submitted to the API, including the database
#' used, the measures requested, the dimensions (row, column, wafer), and the
#' record request.
#'
#' 1. `database` Details on the database queried. Contains two vectors:
#'    - `id` The ID of this dataset
#'    - `annotationKeys` An array of keys to annotations for the dataset.
#'    If there are annotations available, their descriptions will be in the
#'    `annotationMap` object.
#'
#'
#' 1. `fields`Details of the fields being queried.
#'
#'    - `uri` Field ID, or Open Data ID, as returned by [dwp_schema()].
#'    - `label` The display name for given measure, as displayed in
#'    [Stat-Xplore](https://stat-xplore.dwp.gov.uk/).
#'    - `items` An array with the field values returned for each field:
#'        - `type` The field type. The `RecodeItem`, if applicable.
#'        - `labels` Display name(s) for the given field item. If `recodes`
#'        are used, this will contain labels for each created field value.
#'        - `annotationKeys` An array of keys to annotations for the dataset.
#'        If there are annotations available, their descriptions will be in the
#'        `annotationMap` object.
#'        - `uris` Field ID, or Open Data ID, as returned by [dwp_schema()].
#'
#'    - `annotationKeys` An array of keys to annotations for the
#'    dataset. If there are annotations available, their descriptions will be
#'    in the `annotationMap` object.
#'
#'
#' 1. `measures` An array containing all the measures (summation options)
#' returned for the query. For each measure, the API returns:
#'        - `uri` Field ID, or Open Data ID, as returned by [dwp_schema()].
#'        - `label` The display name for the given measure, as displayed in
#'        [Stat-Xplore](https://stat-xplore.dwp.gov.uk/).
#'
#'
#' 1. `cubes` An array containing the API query results. There will be
#' one item in the array for each requested measure. Each item specifies a
#' measure, with the values for each cell in the cube for the given measure.
#'
#' 1. `annotationMap` The annotations applicable to this query.
#' If there are annotations for the dataset or its fields,
#' the annotation keys and descriptions will be returned here.
#'
#' @details Returns a list of 6 levels. The descriptions of what each level
#' contains are adapted from the
#' [API documentation]
#' (https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API-Table.html).
#'
#' @export
#'
#' @examples \dontrun{
#' # A complex query
#' x <- dwp_get_data(database = "str:database:ESA_Caseload",
#'                   measures = "str:count:ESA_Caseload:V_F_ESA",
#'                   column = c("str:field:ESA_Caseload:V_F_ESA:CCSEX",
#'                              "str:field:ESA_Caseload:V_F_ESA:CTDURTN"),
#'                   row = "str:field:ESA_Caseload:V_F_ESA:ICDGP",
#'                   wafer = "str:field:ESA_Caseload:V_F_ESA:IB_MIG")
#'
#' # A more straightforward query returning the number of PIP recipients in
#' # the most recent month, split by sex
#' z <- dwp_get_data(database = "str:database:PIP_Monthly",
#'                     measures = "str:count:PIP_Monthly:V_F_PIP_MONTHLY",
#'                     column = "str:field:PIP_Monthly:V_F_PIP_MONTHLY:SEX")
#' }

dwp_get_data <- function(database, measures, column,
                         row = NULL, wafer = NULL, ...) {
  if (any(c(missing(database), missing(measures), missing(column)))) {
    passed <- names(as.list(match.call())[-1])
    stop(paste(
      "missing values for",
      paste(setdiff(c("database", "measures", "column"), passed),
        collapse = ", "
      )
    ), call. = FALSE)
  }

  dimensions <- list( # List of dimensions because doing this below doesn't work
    row,
    column,
    wafer
  )

  dimensions <- Filter(Negate(is.null), dimensions) # Remove NULL levels

  json_df <- data.frame(
    database = I(database),
    measures = I(list(measures)),
    dimensions = I(list(dimensions))
  )

  body_query <- as.character(jsonlite::toJSON(json_df, auto_unbox = FALSE))

  body_query <- gsub("^\\[", "", body_query)

  body_query <- gsub(",\\{\\}", "", body_query)

  body_query <- gsub(".{1}$", "", body_query)

  query <- paste0(dwp_baseurl, "table/")

  resp <- dwp_get_data_util(query, body_query)

  resp
}
