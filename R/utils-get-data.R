

dwp_get_data_util <- function(query, body_query) {
  api_get <- httr::POST(url = query, body = body_query,
                        config = add_headers(APIKey = getOption("DWP.API.key")),
                        encode = "json")


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




