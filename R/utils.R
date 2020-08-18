### some utils taken from rmarkdown
find_resource <- function(template, file = 'template.tex') {
    res <- system.file(
        "rmarkdown", "templates", template, "resources",
        file, package = "jds.rmd"
    )
    if (res == "") {
        stop("Couldn't find template file ", template, "/resources/",
             file, call. = FALSE)
    }
    res
}

## Helper function to create a custom format derived from pdf_document that
## includes a custom LaTeX template
pdf_document_format <-
    function(format,
             template = find_resource(format, 'template.tex'),
             ...)
{
    fmt <- rmarkdown::pdf_document(..., template = template)
    fmt$inherits <- "pdf_document"
    fmt
}

### some internal utils written for jds
texinputs <- function() {
    res_dir <- system.file(
        "rmarkdown", "templates", "pdf_article", "resources",
        package = "jds.rmd"
    )
    ## set environment variable TEXINPUTS to include style files
    ## without copy them to the working directory
    old_texinputs <- Sys.getenv("TEXINPUTS")
    old_texinputs_vec <- do.call(
        c, strsplit(old_texinputs, split = ":", fixed = TRUE)
    )
    add_texinputs <- paste0(res_dir, ":")
    ## helper functions
    set <- function() {
        if (! res_dir %in% old_texinputs_vec) {
            Sys.setenv(TEXINPUTS = paste0(add_texinputs, old_texinputs))
        }
        invisible()
    }
    reset <- function() {
        Sys.setenv(TEXINPUTS = old_texinputs)
        invisible()
    }
    ## return
    list(
        set = set,
        reset = reset
    )
}

bstinputs <- function() {
    res_dir <- system.file(
        "rmarkdown", "templates", "pdf_article", "resources",
        package = "jds.rmd"
    )
    ## set environment variable TEXINPUTS to include style files
    ## without copy them to the working directory
    old_bstinputs <- Sys.getenv("BSTINPUTS")
    old_bstinputs_vec <- do.call(
        c, strsplit(old_bstinputs, split = ":", fixed = TRUE)
    )
    add_bstinputs <- paste0(res_dir, ":")
    ## helper functions
    set <- function() {
        if (! res_dir %in% old_bstinputs_vec) {
            Sys.setenv(BSTINPUTS = paste0(add_bstinputs, old_bstinputs))
        }
        invisible()
    }
    reset <- function() {
        Sys.setenv(BSTINPUTS = old_bstinputs)
        invisible()
    }
    ## return
    list(
        set = set,
        reset = reset
    )
}
