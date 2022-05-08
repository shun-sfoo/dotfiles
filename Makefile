pwd = $(shell pwd)

.PHONY: env
env:
	ln -s $(pwd)/env/fonts.conf ~/test.conf
