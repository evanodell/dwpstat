
dwp_get_data_util <- function(query) {

  api_get <- httr::GET(url = query, config = add_headers(APIKey=getOption("DWP.API.key")))

      if (httr::http_error(api_get)) {
        stop(
          paste0(
            "Stat-Xplore API request failed with status ",
            httr::status_code(api_get)
          ),
          call. = FALSE
        )
      }

}
