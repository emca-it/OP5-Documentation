# Using Command Line Tools

## About

Handlers and bindings are managed by a tool called 'traped' (TRAPper EDitor) which is located in /opt/trapper/bin. It takes a command as its first argument, then additional arguments optionally.
Command line syntax:

## Commands

#### traped list modules

``` {style="margin-left: 90.0px;"}
traped list modules
```

Prints a list of all modules

#### traped list handlers

``` {style="margin-left: 60.0px;"}
traped list handlers
```

Prints a list of all handlers

#### traoed list matches

``` {style="margin-left: 60.0px;"}
traped list matches
```

Prints a list of matches in a form: \<trap\_oid\> \<handler\_name\>

#### traped create module

``` {style="margin-left: 60.0px;"}
traped create module <name>
```

Creates an empty module \<name\>
 Example:

``` {style="margin-left: 60.0px;"}
traped create module test
```

#### traped create handler

``` {style="margin-left: 60.0px;"}
traped create handler <name>
```

Creates an empty handler \<name\>
 Example:

``` {style="margin-left: 60.0px;"}
traped create handler test
```

#### traped read

``` {style="margin-left: 60.0px;"}
traped read <name>
```

Prints handler/module \<name\> to stdout
 Example:

``` {style="margin-left: 60.0px;"}
traped read test > test.lua
```

#### traped update

``` {style="margin-left: 60.0px;"}
traped update <name>
```

Updates handler/module \<name\> with a script passed via stdin
 Example:

``` {style="margin-left: 60.0px;"}
traped update test < test.lua
```

#### traped detele

``` {style="margin-left: 60.0px;"}
traped delete <name>
```

Deletes handler/module \<name\>

#### traped bind

``` {style="margin-left: 60.0px;"}
traped bind { <oid> | "<pattern>" | fallback } <name>
```

Binds handler \<name\> to trap \<oid\>,
 or to all traps with oids that match \<pattern\>, or to all traps that were not processed by any other handler
 Examples:

``` {style="margin-left: 60.0px;"}
traped bind .1.2.3.4.5 test
```

``` {style="margin-left: 60.0px;"}
traped bind ".1.2.3*" test
```

``` {style="margin-left: 60.0px;"}
traped bind fallback test
```

Note1: \* in a pattern means "a substring of any length consisting of any symbols"
Note2: you **must** enclose pattern in quotes

#### traped unbind

``` {style="margin-left: 60.0px;"}
traped unbind { <oid> | "<pattern>" | fallback } <name>
```

Unbinds handler \<name\>, essentially reverting the same bind command

#### traped move

``` {style="margin-left: 60.0px;"}
traped move up|down { <oid> | "<pattern>" | fallback } <name>
```

``` {style="margin-left: 60.0px;"}
Move match between trap and handler higher in the list, so that it can be processed sooner example:
```

``` {style="margin-left: 60.0px;"}
traped list matches  .1.2.3* test1 .1.2.3.4.5 test2
```

In case a trap with oid .1.2.3.4.5 comes - test1 will be processed first, then test2

``` {style="margin-left: 60.0px;"}
traped move up .1.2.3.4.5 test
```

``` {style="margin-left: 60.0px;"}
traped list matches  .1.2.3.4.5 test2 .1.2.3* test1
```

In case a trap with oid .1.2.3.4.5 comes - test2 will be processed first, then test1
