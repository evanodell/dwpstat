dwp_info <- function() {

  query <-paste0(dwp_baseurl, "rate_limit")


  resp <- dwp_get_data_util(query)

  rate_limit  = data.frame(
    limit = resp$headers$`x-ratelimit`,
    remaining = resp$headers$`x-ratelimit-remaining`,
    resets_at = as.POSIXct(as.numeric(resp$headers$`x-ratelimit-reset`)/1000,
                           origin = "1970-01-01")

  )

}

