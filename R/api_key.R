
#' DWP API Key
#'
#' @description Assign or reassign API key for the Stat-Xplore API.
#'
#' @details By default, `dwpstat` will look for the environment variable
#'   `DWP_API_KEY` when the package is loaded. If found, the API key will
#'   be stored in the session option `DWP.API.key`. If you would like to
#'   reload the API key or would like to manually enter one in, this function
#'   may be used.
#'
#' @details You can sign up for an API key
#'   [here](https://stat-xplore.dwp.gov.uk).
#'
#' @param check_env If `TRUE`, will check the environment variable
#'   `DWP_API_KEY` first before asking for user input.
#'
#' @export
dwp_api_key <- function(check_env = FALSE) {
  if (check_env) {
    key <- Sys.getenv("DWP_API_KEY")
    if (key != "") {
      message("Updating DWP_API_KEY environment variable...")
      options("DWP.API.key" = key)
      return(invisible())
    } else {
      warning("Couldn't find environment variable 'DWP_API_KEY'")
    }
  }

  if (interactive()) {
    key <- readline("Please enter your API key and press enter: ")
  } else {
    cat("Please enter your API key and press enter: ")
    key <- readLines(con = "stdin", n = 1)
  }

  if (identical(key, "")) {
    stop("DWP API key entry failed", call. = FALSE)
  }

  message("Updating DWP_API_KEY environment variable...")
  options("DWP.API.key" = key)
  invisible()
}
