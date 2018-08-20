


#' Schema data
#'
#' Schema data is the detail on the datasets and folders available
#' at the root level of Stat-Xplore. More details on the `schema` endpoint is
#' available in the
#' [API documentation](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API-Schema.html)
#'
#' @param id
#'
#'
#' @return A tibble.
#' @export
#'
# @examples
#'

dwp_schema <- function(id = NULL) {
  if (is.null(id)) {
    id_query <- id
  } else {
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
