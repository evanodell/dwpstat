
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `dwpstat`

[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1421684.svg)](https://doi.org/10.5281/zenodo.1421684)
[![GitHub
tag](https://img.shields.io/github/tag/dr-uk/dwpstat.svg)](https://github.com/dr-uk/dwpstat)
[![Travis build
status](https://travis-ci.org/dr-uk/dwpstat.svg?branch=master)](https://travis-ci.org/dr-uk/dwpstat)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/dr-uk/dwpstat?branch=master&svg=true)](https://ci.appveyor.com/project/dr-uk/dwpstat)
![lifecycle](https://img.shields.io/badge/lifecycle-experimental-red.svg)
![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/dwpstat)

This package provides access to the [‘Stat-Xplore Open Data
API’](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API.html),
containing welfare statistics from the UK Government’s Department for
Work and Pensions (DWP).

The ‘Stat-Xplore Open Data API’ is a JSON REST API, with the same data
as on the [Stat-Xplore](https://stat-xplore.dwp.gov.uk/) online service.
All queries require the use of an API key. To set up an API key, use
`dwp_api_key()`. The API is free to use, but queries are rate limited.
To find the number of allowable queries per hour, and the number of
queries remaining in a given hour, use `dwp_rate_limit()`.

Full documentation of the API is available
[here](https://stat-xplore.dwp.gov.uk/webapi/online-help/Open-Data-API.html).

`dwpstat` returns metadata in
[`tibble`](https://cran.r-project.org/package=tibble) format, and data
(with the `dwp_get_data()` command) in a list format. The list format is
very messy, thanks to the way the API is built, and so `dwpstat` does
not convert this data into a
[`tibble`](https://cran.r-project.org/package=tibble) or similar.

## Future Work

This package remains in development. The specific functions are likely
to remain stable, but the data returned by the `dwp_get_data()` function
remains messy withs data labels stored in a seperate array from the
actual data, making it difficult to work with, particularly for users
unfamiliar with multi-dimensional arrays.

The actual data queried by `dwp_get_data()` is returned in one
multi-dimensional array, while the dimension names - row, columns,
wafers, etc - are returned in another array. `dwpstat` does not match
these two arrays together. I suspect there may be functionality like
this in [`purrr`](https://cran.r-project.org/package=purrr) but I
haven’t been successful in implementing a generic function to handle
all the possible array dimensions that can be queried.

Pull requests providing functionality to match the `field` array
(containing the names of rows, columns, etc) with the `cubes` array
(containing the actual data) are much appreciated, as in any advice on
developing a solution to this problem.

## Installation

You can install the development version of `dwpstat` from GitHub with:

    # install.packages("devtools")
    devtools::install_github("evanodell/dwpstat")

## Use

    library(dwpstat)
    x <- dwp_get_data(database = "str:database:ESA_Caseload",
                       measures = "str:count:ESA_Caseload:V_F_ESA",
                       column = c("str:field:ESA_Caseload:V_F_ESA:CCSEX",
                                  "str:field:ESA_Caseload:V_F_ESA:CTDURTN"),
                       row = "str:field:ESA_Caseload:V_F_ESA:ICDGP",
                       wafer = "str:field:ESA_Caseload:V_F_ESA:IB_MIG")
    
    class(x)
    [1] "list"
    
    names(x)
    [1] "query"         "database"      "measures"      "fields"        "cubes"         "annotationMap"

## Meta

Bug reports, feature requests and pull requests are all welcome.

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.

This project is not affiliated with or endorsed by the Department for
Work and Pensions.

Get citation information for `dwpstat` in R with `citation(package =
'dwpstat')`

Odell E (2018). *dwpstat: Access ‘Stat-Xplore’ data on the UK benefits
system*. doi: 10.5281/zenodo.1421684 (URL:
<http://doi.org/10.5281/zenodo.1421684>), R package version 0.1.0,
\<URL: <https://github.com/dr-uk/dwpstat>\>.

A BibTeX entry for LaTeX users is

``` 
  @Manual{,
    title = {{dwpstat}: Access 'Stat-Xplore' data on the UK benefits system},
    author = {Evan Odell},
    year = {2018},
    note = {R package version 0.1.0,
    doi = {10.5281/zenodo.1421684},
    url = {https://github.com/dr-uk/dwpstat},
  }
```

License:
[MIT](LICENSE.md)

[![DRUK\_logo](https://www.disabilityrightsuk.org/sites/default/files/logo.png)](https://www.disabilityrightsuk.org)
