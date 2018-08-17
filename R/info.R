

#' Info
#'
#' @return A Tibble
#' @export
#'
# @examples
#'
#'

dwp_info <- function() {

  query <-paste0(dwp_baseurl, "info")

  resp <- dwp_get_info_util(query)


}

