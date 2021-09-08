if (interactive() && requireNamespace("rmarkdown", quietly = TRUE)) {
    ## draft from a sample R markdown file
    jds::draft("jds-sample.Rmd")
    ## produce pdf with the tex source kept for submission
    rmarkdown::render("jds-sample.Rmd")
}
