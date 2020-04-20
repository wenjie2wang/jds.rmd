## taken from windjammer::need.packages
need.packages <- function (pkgs, repos = getOption("repos"), ...)
{
    new.pkgs <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
    if (length(new.pkgs) > 0) {
        if (is.null(repos) || repos == "@CRAN@") {
            repos <- "https://cloud.r-project.org"
        }
        install.packages(pkgs = new.pkgs, repos = repos, ...)
    }
    sapply(pkgs, function(a) {
        suppressMessages(require(a, character.only = TRUE))
    })
    invisible()
}

## the current version of package needs rmarkdown and revealjs
need.packages(c("rmarkdown", "bookdown"))
