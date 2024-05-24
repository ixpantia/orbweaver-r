.PHONY: vendor document

vendor:
	$(MAKE) -C src/rust vendor

document: vendor
	Rscript -e "rextendr::document()"
