.PHONY: vendor

vendor:
	cargo vendor-filterer > vendor-config.toml
	tar -cJf vendor.tar.xz vendor/
	rm -rf vendor/
