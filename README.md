# jds.rmd

[![CRAN_Status_Badge][r-pkg-badge]][cran-url]
[![R build status][gha-icon]][gha-url]


## Overview

The R package **jds.rmd** provides an R Markdown template for authoring
manuscripts intended for [Journal of Data Science][jds-url].

## Installation

### Option 1 (not yet)

You can install the released version from [CRAN][cran-url].

```R
install.packages("jds.rmd")
```

### Option 2

The latest version of the package can be installed by using **remotes**:

```R
if (! require(remotes)) install.packages("remotes")
remotes::install_github("wenjie2wang/jds.rmd", upgrade = "never")
```

## Getting Started

After installing the package, we may start writing a new manuscript from a
sample R markdown file created by `rmarkdown::draft()` and render it to PDF by
`rmarkdown::render()`as follows:

```R
## draft from a sample R markdown file
rmarkdown::draft("jds-sample.Rmd", template = "pdf_article",
                 package = "jds.rmd", edit = FALSE)
## produce pdf with the tex source kept for submission
rmarkdown::render("jds-sample.Rmd")
```

[r-pkg-badge]: https://www.r-pkg.org/badges/version/jds.rmd
[cran-url]: https://CRAN.R-project.org/package=jds.rmd
[gha-icon]: https://github.com/wenjie2wang/jds.rmd/workflows/R-CMD-check/badge.svg
[gha-url]: https://github.com/wenjie2wang/jds.rmd/actions
[jds-url]: https://jds-online.org
