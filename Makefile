.PHONY: all test lint

all: lint test

clean:
	rm -r build

test:
	bash test/pass_fail_test
	bash test/tap_13_test

lint:
	shellcheck expect

install:
	ln -s $(shell pwd)/expect /usr/local/bin/expect

deps:
	sudo apt-get install bc
