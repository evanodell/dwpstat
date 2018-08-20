#' Rate Limits
#'
#' Identify rate limits, remaining requests and request limit reset point. This
#' function does not accept any parameters
#'
#' @return A tibble with one row and three columns:
#' 1. `remaining` The number of queries remaining from the limit
#' 1. `reset` The date and time the rate limit resets, in POSIXct class
#' 1. `limit` The maximum number of queries allowed within a given time span
#'
#'
#' @export

dwp_rate_limit <- function() {
  query <- paste0(dwp_baseurl, "rate_limit")

  df <- tibble::as_tibble(dwp_get_info_util(query))

  df$reset <- as.POSIXct(df$reset / 1000, origin = "1970-01-01")

  df
}
