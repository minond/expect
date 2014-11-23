[![Build Status](https://travis-ci.org/minond/expect.svg)](https://travis-ci.org/minond/expect)

`expect` - a simple test method for bash scripts with valid TAP v13 output

##### install

clone this repo and run `make install` (you may need to sudo that)

##### example

here's an example test file. let's say you named it under `test/random_tests`:

```bash
expect "the file to exist" $(test -f Makefile)
expect "the file to not exist" $(test ! -f Makefile.win)
expect "this to exit with 0" $(exit 0)
expect "output to do something" $(echo hi)
```

##### running tests

to run the above example, just execute `expect test/random_tests`

##### output

default output is not TAP. to get tap output pass a `-o tap` argument when
running your tests: `expect test/random_tests -o tap`
