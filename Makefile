.PHONY: vendor document

vendor:
	$(MAKE) -C src/rust vendor

document:
	Rscript -e "rextendr::document()"

install: document
	Rscript -e "devtools::install()"

test:
	Rscript -e "devtools::test()"

