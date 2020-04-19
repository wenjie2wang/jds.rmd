objects := $(wildcard R/*.R) DESCRIPTION
version := $(shell grep "Version" DESCRIPTION | awk '{print $$NF}')
pkg := $(shell grep "Package" DESCRIPTION | awk '{print $$NF}')
tar := $(pkg)_$(version).tar.gz
# tinytest := $(wildcard inst/tinytest/*.R)
checkLog := $(pkg).Rcheck/00check.log
rmd := $(wildcard vignettes/*.Rmd)
# vignettes := $(patsubst %.Rmd,%.html,$(rmd))


.PHONY: check
check: $(checkLog)

.PHONY: build
build: $(tar)

.PHONY: install
install:
	@printf "Checking if required packages are installed...\n"
	@Rscript misc/pre-build.R
	@printf "The required packages are all installed.\n\n"
	R CMD build .
	R CMD INSTALL $(tar)

# .PHONY: preview
# preview: $(vignettes)

.PHONY: pkgdown
pkgdown:
	@Rscript -e "options(pkgdown.internet = FALSE);\
	pkgdown::build_site();"


.PHONY: rs-connect
rs-connect:
	@Rscript misc/rs-connect.R

.PHONY: publish-docs
publish-docs:
	@scp -r docs/* hpclogin:~/ShinyApps/$(pkg)/

$(tar): $(objects)
	@Rscript -e "library(methods);" \
	-e "devtools::document();";
	@$(MAKE) updateTimestamp
	R CMD build .

$(checkLog): $(tar) # $(tinytest)
	R CMD check $(tar)

# vignettes/%.html: vignettes/%.Rmd
#	Rscript -e "library(methods); rmarkdown::render('$?')"

## update copyright year in HEADER, R script and date in DESCRIPTION
.PHONY: updateTimestamp
updateTimestamp:
	@bash misc/update_timestamp.sh

## make tags
.PHONY: TAGS
TAGS:
	Rscript -e "utils::rtags(path = 'R', ofile = 'TAGS')"
# gtags

.PHONY: clean
clean:
	@$(RM) -rf *~ */*~ *.Rhistroy *.tar.gz src/*.so src/*.o *.Rcheck/ .\#*
