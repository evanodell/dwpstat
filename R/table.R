

#' Submit and receive table queries
#'
#' Table queries contain the actual data from the DWP database. Due to the
#' complexity of the API data being returned, and to preserve the flexibility
#' of the API query, the API return is not processed into a data frame but is
#' preserved as a list.
#'
#' @param database The ID of the database to query, as a single string.
#' @param measures A character vector of fields to return measures for. Also
#' accepts a string if one measure is being queried/
#' @param row A character vector of fields for the row dimension
#' @param column A character vector of fields for the column dimension
#' @param wafer A character vector of fields for the wafter dimension
#' @param ... For recode vector Not in use
#'
#' @return A list of six levels:
#'
#' \enumerate{
#' \item{`query`} The query submitted to the API, including the database
#' used, the measures requested, the dimensions (row, column, wafer), and the
#' record request.
#'
#' \item{`database`} Details on the database queried. Contains two vectors:
#' \itemize{
#'   \item{`id`} The ID of this dataset
#'   \item{`annotationKeys`} An array of keys to annotations for the dataset.
#' If there are annotations available, their descriptions will be in the
#' `annotationMap` object.
#'  }
#'
#' \item{`fields`} Details of the fields being queried.
#' \itemize{
#'   \item{`uri`} Field ID, or Open Data ID, as returned by [dwp_schema()].
#'   \item{`label`} The display name for given measure, as displayed in
#' [Stat-Xplore](https://stat-xplore.dwp.gov.uk/).
#'   \item{`items`} An array with the field values returned for each field:
#'   \itemize{
#'     \item{`type`} The field type. The `RecodeItem`, if applicable.
#'     \item{`labels`} Display name(s) for the given field item. If `recodes`
#'     are used, this will contain labels for each created field value.
#'     \item{`annotationKeys`} An array of keys to annotations for the dataset.
#'   If there are annotations available, their descriptions will be in the
#'   `annotationMap` object.
#'     \item{`uris`} Field ID, or Open Data ID, as returned by [dwp_schema()].
#'     }
#'   \item{`annotationKeys`} An array of keys to annotations for the
#'   dataset. If there are annotations available, their descriptions will be
#'   in the `annotationMap` object.
#' }
#'
#' \item{`measures`} An array containing all the measures (summation options)
#' returned for the query. For each measure, the API returns:
#' \itemize{
#'     \item{`uri`} Field ID, or Open Data ID, as returned by [dwp_schema()].
#'     \item{`label`} The display name for the given measure, as displayed in
#'   [Stat-Xplore](https://stat-xplore.dwp.gov.uk/).
#'   }
#'
#' \item{`cubes`} An array containing the API query results. There will be
#' one item in the array for each requested measure. Each item specifies a
#' measure, with the values for each cell in the cube for the given measure.
#'
#' \item{`annotationMap`} The annotations applicable to this query.
#' If there are annotations for the dataset or its fields,
#' the annotation keys and descriptions will be returned here.
#'
#' }
#'
#' @details Returns a list of 6 levels. The descriptions of what each level
#' contains are adapted from the
#' [API documentation](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API-Table.html)
#'
#
#'
#'
#'
#'
#'
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



dwp_get_data <- function(database, measures, row, column, wafer, ...) {
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
