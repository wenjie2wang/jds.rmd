## when the package is loaded
.texinputs <- NULL
.onLoad <- function(libname, pkgname) {
    .texinputs <<- texinputs()

    invisible()
}
