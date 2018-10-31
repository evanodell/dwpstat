
#' API Schema
#'
#' Schema data is metadata on the datasets and folders available
#' at the root level of Stat-Xplore. More details on the `schema` endpoint is
#' available in the
#' [API documentation](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API-Schema.html)
#'
#' @details `dwp_schema` can be used iteratively to get folders and databases
#' at each level.
#'
#' @details The function will work with or without `"str:"` at
#' the start of each ID string. `id="str:database:ESA_Caseload"` and
#' `id="database:ESA_Caseload"` will return the same data, but a query like
#' `id="r:database:ESA_Caseload"` will fail.
#'
#' @param id If `NULL`, returns all folders and databases available at the
#' root level of the API. If the `id` of a folder, database, etc, returns
#' all folders, databases, and variables at the level below.
#' `id` is case sensitive. Defaults to `NULL`.
#'
#' @return A tibble with the relevant
#' @export
#'
#' @examples \dontrun{
#' #Get all available folders
#' a <- dwp_schema()
#'
#' # Get all databases in the ESA folder
#' b <- dwp_schema("str:folder:fesa")
#'
#' # Get all variables in the ESA caseload database
#' c <- dwp_schema("str:database:ESA_Caseload")
#'
#' # Given their ID, you can use `dwp_schema` to return the names of levels
#' # in group and field variables
#' d <- dwp_schema("str:field:ESA_Caseload:V_F_ESA:CTDURTN")
#'
#' # Returns a tibble of levels for the duration options for ESA caseloads
#' e <- dwp_schema("str:valueset:ESA_Caseload:V_F_ESA:CTDURTN:C_ESA_DURATION")
#' }

dwp_schema <- function(id = NULL) {
  if (is.null(id)) {
    id_query <- id
  } else {
    id <- trimws(id)
    if (substr(id, 1, 4) != "str:") {
      id_query <- paste0("/str:", id)
    } else {
      id_query <- paste0("/", id)
    }
  }

  query <- paste0(dwp_baseurl, "schema", id_query)

  resp <- dwp_get_info_util(query)

  x <- tibble::enframe(resp$children)

  df <- tibble::tibble(
    id = as.character(purrr::map(x$value, "id")),
    label = as.character(purrr::map(x$value, "label")),
    location = as.character(purrr::map(x$value, "location")),
    type = as.character(purrr::map(x$value, "type"))
  )

  df
}
