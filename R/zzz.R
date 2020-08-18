## when the package is loaded
.texinputs <- .bstbinputs <- NULL
.onLoad <- function(libname, pkgname) {
    .texinputs <<- texinputs()
    .bstinputs <<- bstinputs()

    invisible()
}
