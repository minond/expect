.PHONY: all test lint

all: lint test

clean:
	rm -r build

test:
	./expect test/pass_fail_test --output tap
	bash test/tap_13_test

lint:
	shellcheck expect

install:
	cp $(shell pwd)/expect /usr/local/bin/expect

deps:
	sudo apt-get install bc
