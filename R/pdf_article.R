##' PDF Article for Journal of Data Science
##'
##' Provides output format to render PDF article for submission to Journal of
##' Data Science.
##'
##' @param ... Optional named arguments passed to \code{bookdown::pdf_book()}
##'     and \code{rmarkdown::pdf_document()} other than \code{base_format}.
##' @param cls The LaTeX class name. The available choices are \code{jdsart} for
##'     the latest class developed by vtex, or \code{jds} for the deprecated
##'     class.
##'
##' @return The output format that can only be used with
##'     \code{bookdown::render_book()}.
##'
##' @example inst/examples/pdf_article.R
##'
##' @importFrom rmarkdown pdf_document pandoc_available
##' @importFrom bookdown pdf_book
##'
##' @export
pdf_article <- function(..., cls = c("jdsart", "jds"))
{
    out <- bookdown::pdf_book(..., base_format = jds_pdf_document, cls = cls)
    ## eliminate the side effect by post_processor run by render function
    ## have to run after latemk of the post_processor
    out_post_fun <- out$post_processor
    post_fun_list <- as.list(body(out_post_fun))
    where_return <- length(post_fun_list)
    post_fun_list <- c(post_fun_list, post_fun_list[where_return])
    post_fun_list[[where_return]] <- quote({
        .texinputs$reset(); .bstinputs$reset()
    })
    body(out$post_processor) <- as.call(post_fun_list)
    ## return
    out
}


jds_pdf_document <- function(...,
                             cls = c("jdsart", "jds"),
                             keep_tex = TRUE,
                             citation_package = "natbib",
                             md_extensions = NULL)
{
    ## reference: rticles::jss_article
    rmarkdown::pandoc_available("2.2", TRUE)
    ## which template tex to use
    cls <- match.arg(cls, choices = c("jdsart", "jds"))
    template_name <- sprintf("template-%s.cls.tex", cls)
    ## disable autolink for bare links
    if (! is.null(md_extensions) &&
        any(grepl("+autolink_bare_uris", md_extension, fixed = TRUE))) {
        warning("The option 'autolink_bare_uris' is enabled, ",
                "which may cause issues when email address is ",
                "specified in the YAML header.")
    } else {
        md_extensions <- c(md_extensions, "-autolink_bare_uris")
    }
    out <- pdf_document_format(
        format = "pdf_article",
        template = find_resource("pdf_article", template_name),
        keep_tex = keep_tex,
        citation_package = citation_package,
        md_extensions = md_extensions,
        ...
    )
    ## set TEXINPUTS and BIBINPUTS
    .texinputs$set()
    .bstinputs$set()
    ## return
    out
}
