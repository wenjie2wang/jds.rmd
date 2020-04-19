# jds.rmd

[![CRAN_Status_Badge][r-pkg-badge]][cran-url]

## Overview

**jds.rmd** is an R package providing templates in R Markdown for authoring
manuscripts for submission to Journal of Data Science (JDS).


## Installation

### Option 1 (not yet)

You can install the released version from [CRAN][cran-url].

```R
install.packages("jds.rmd")
```

### Option 2

The latest version of the package can be installed it by using **remotes** (or
**devtools**):

```R
if (! require(remotes)) install.packages("remotes")
remotes::install_gitlab("wenjie2wang/jds.rmd")
```

### Option 3

It is also possible to install the package by the following bash commands.

```bash
git clone git@gitlab.com:wenjie2wang/jds.rmd.git
make -C jds.rmd install
```

## Getting Started

After we have installed the package, we may start writing a new manuscript from
a sample R markdown file created by `rmarkdown::draft()` and render it to PDF by
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
