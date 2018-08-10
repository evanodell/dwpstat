


.onLoad <- function(libname, pkgname) {
  if (is.null(getOption("DWP.API.key"))) {
    key <- Sys.getenv("DWP_API_KEY")
    if (key != "") options("DWP.API.key" = key)
  }

  invisible()
}
