##' PDF Article for Journal of Data Science
##'
##' Provides output format to render PDF article for submission to Journal of
##' Data Science.
##'
##' @param ... FIXME: Other arguments.
##'
##' @example inst/examples/pdf_article.R
##'
##' @importFrom rmarkdown pdf_document pandoc_available
##' @importFrom bookdown pdf_book
##' @export
pdf_article <- function(...)
{
    ## FIXME: allow more options
    out <- bookdown::pdf_book(..., base_format = jds_pdf_document)

    ## eliminate the side effect by post_processor run by render function
    ## have to run after latemk of the post_processor
    out_post_fun <- out$post_processor
    post_fun_list <- as.list(body(out_post_fun))
    where_return <- length(post_fun_list)
    post_fun_list <- c(post_fun_list, post_fun_list[where_return])
    post_fun_list[[where_return]] <- quote(.texinputs$reset())
    body(out$post_processor) <- as.call(post_fun_list)

    ## return
    out
}

jds_pdf_document <- function(...,
                             keep_tex = TRUE,
                             citation_package = 'natbib')
{
    ## reference: rticles::jss_article
    rmarkdown::pandoc_available("2.2", TRUE)

    out <- pdf_document_format(
        "pdf_article",
        keep_tex = keep_tex,
        citation_package = citation_package,
        ...
    )

    ## set TEXINPUTS
    .texinputs$set()

    ## FIXME: get optional arguments
    dots_list <- list(...)

    ## return
    out
}
