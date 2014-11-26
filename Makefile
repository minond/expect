.PHONY: all test lint

all: lint test

clean:
	rm -r build

test:
	bash test/output.sh

lint:
	shellcheck expect

install: dependecies
	cp $(shell pwd)/expect /usr/local/bin/expect

dependecies:
	sudo apt-get install bc
