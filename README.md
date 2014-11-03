expect
======

`expect` - a simple test method for bash scripts with valid TAP v13 output

example:

```bash
#!/bin/bash

source expect

expect $(test -f Makefile) to pass
expect $(test -f Makefile.win) to fail

expect $(exit 1) to fail
expect $(exit 0) to pass

expect "echo run this command" to pass
expect "this will not work because this is not a command" to fail
```

outputs:

```text
1..6
ok 1
ok 2
ok 3
ok 4
ok 5 - $(echo run this command)
ok 6 - $(this will not work because this is not a command)
```
