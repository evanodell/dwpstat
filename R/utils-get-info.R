
dwp_get_info_util <- function(query) {
  api_get <- httr::GET(
    url = query,
    config = httr::add_headers(APIKey = getOption("DWP.API.key"))
  )

  if (httr::http_error(api_get)) {
    stop(
      paste0(
        "Stat-Xplore API request failed with status ",
        httr::status_code(api_get)
      ),
      call. = FALSE
    )
  }

  df <- httr::content(api_get)
}
