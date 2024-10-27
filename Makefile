.PHONY: vendor document covr

vendor:
	$(MAKE) -C src/rust vendor

document:
	NOT_CRAN="true" Rscript -e "rextendr::document()"

install: document
	NOT_CRAN="true" Rscript -e "devtools::install()"

test:
	NOT_CRAN="true" Rscript -e "devtools::test()"

covr:
	NOT_CRAN="true" Rscript -e "covr::report()"
