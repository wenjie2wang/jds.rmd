if (interactive() && requireNamespace("rmarkdown")) {
    ## draft from a sample R markdown file
    rmarkdown::draft("jds-sample.Rmd", template = "pdf_article",
                     package = "jds.rmd", edit = FALSE)
    ## produce pdf with the tex source kept for submission
    rmarkdown::render("jds-sample.Rmd")
}
