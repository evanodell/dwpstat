

dwp_get_data_util <- function(query, body_query) {
  api_get <- httr::POST(
    url = query, body = body_query,
    config = httr::add_headers(APIKey = getOption("DWP.API.key")),
    encode = "json"
  )

  httr::status_code(api_get)

  if (httr::http_error(api_get)) {
    stop(
      paste0(
        "Stat-Xplore API request failed with status ",
        httr::status_code(api_get),
        if (httr::status_code(api_get) == 422) {
          ". Please check your parameters."
        } else if (httr::status_code(api_get) == 403) {
          ". Please check your API key."
        }
      ),
      call. = FALSE
    )
  }

  df <- httr::content(api_get)
}
