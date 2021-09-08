##' Creat A Draft of JDS Article
##'
##' Create a JDS article draft using the specified LaTeX class file.  This
##' function is a simplified version of `rmarkdown::draft()` for creating a JDS
##' article draft only.
##'
##' @param file A character string for the file name of the draft.  Different
##'     with \code{rmarkdown::draft()}, the suffix \code{".Rmd"} will not be
##'     added if it is not specified.
##' @inheritParams pdf_article
##'
##' @return The file name of the new document (invisibly).
##'
##' @example inst/examples/pdf_article.R
##'
##' @export
draft <- function(file, cls = c("jdsart", "jds"))
{
    template_path <- system.file("rmarkdown", "templates", "pdf_article",
                                 package = "jds.rmd")
    template_yaml <- file.path(template_path, "template.yaml")
    if (file.exists(file))
        stop("The file '", file, "' already exists.")
    cls <- match.arg(cls, c("jdsart", "jds"))
    sk_dir <- if (cls == "jdsart") {
                  "skeleton"
              } else {
                  "skeleton-jds.cls"
              }
    skeleton_files <- list.files(file.path(template_path, sk_dir),
                                 full.names = TRUE)
    to <- dirname(file)
    for (f in skeleton_files) {
        if (file.exists(file.path(to, basename(f))))
            stop("The file '", basename(f), "' already exists")
        file.copy(from = f, to = to, overwrite = FALSE, recursive = TRUE)
    }
    file.rename(file.path(dirname(file), "skeleton.Rmd"), file)
    invisible(file)
}
