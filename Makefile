all: test

test: expect
	shellcheck expect

install:
	ln -s $(shell pwd)/expect /usr/local/bin/expect
