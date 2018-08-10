#' Rate Limits
#'
#' Identify rate limits, remaining requests and request limit reset point.
#'
#' @return
#' @export
#'
#' @examples
#'
#'



dwp_rate_limit <- function() {
  query <- paste0(dwp_baseurl, "rate_limit")

  resp <- httr::GET(url = query, config = add_headers(APIKey = getOption("DWP.API.key")))

  if (httr::http_error(resp)) {
    stop(
      paste0(
        "Stat-Xplore API rate limit request failed with status ",
        httr::status_code(resp)
      ),
      call. = FALSE
    )
  }

  rate_limit <- data.frame(
    limit = resp$headers$`x-ratelimit`,
    remaining = resp$headers$`x-ratelimit-remaining`,
    resets_at = as.POSIXct(as.numeric(resp$headers$`x-ratelimit-reset`) / 1000,
      origin = "1970-01-01"
    )
  )
}
