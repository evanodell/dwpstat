
#' dwp: Access 'Stat-Xplore' data on the UK benefits system
#'
#' The Stat-Xplore Open Data API is a JSON REST API, with the same data as
#' on the [Stat-Xplore](https://stat-xplore.dwp.gov.uk/) online service. All
#' queries require the use of an API key. To set up an API key,
#' use [dwp_api_key()]. The API is free to use, but queries are rate limited.
#' To find the number of allowable queries per hour, and the number of
#' queries remaining, use [dwp_rate_limit()].
#'
#' Full documentation of the API is available
#' [here](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API.html).
#'
#'
#' @docType package
#' @name dwp
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom tibble as_tibble enframe
#' @importFrom httr http_type GET http_error status_code add_headers content
#' @importFrom purrr map
#' @aliases NULL dwp-package
NULL

.onLoad <- function(libname, pkgname) {
  if (is.null(getOption("DWP.API.key"))) {
    key <- Sys.getenv("DWP_API_KEY")
    if (key != "") options("DWP.API.key" = key)
  }

  invisible()
}
