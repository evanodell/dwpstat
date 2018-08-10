#' Title
#'
#' @return
#' @export
#'
#' @examples
#'
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

  df <- tibble(
    id = as.character(x$value %>% map("id")),
    label = as.character(x$value %>% map("label")),
    location = as.character(x$value %>% map("location")),
    type = as.character(x$value %>% map("type"))
  )

  df

}
