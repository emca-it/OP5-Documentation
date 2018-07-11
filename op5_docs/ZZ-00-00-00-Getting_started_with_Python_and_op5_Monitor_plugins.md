# Getting started with Python and OP5 Monitor plugins

## Intro

Python is by default installed on a OP5 Monitor system and is a easy to use programming language, therefore it's very good for writing plugins for OP5 Monitor, Naemon or Nagios.
This howto introduces some key concepts and shall be seen as an introduction to plugin/extension development in Python.

## Installation

Python comes pre-installed on most Linux distributions and on Mac OS X, so most of the time you don't have to do any extra configuration on these platforms.
For Windows users, it's recommended that you download the latest release of Python 2.7 from <http://www.python.org> and then it's just a matter of a simple application install.

If you don't want or can't install Python, there's also online interpreters for testing. [repl.it](http://repl.it) has an excellent [one](http://repl.it/languages/Python).

## First-steps

After the installation, launch the Python interpreter to tests that everything works. On Linux or Mac OS X , it's just a matter of opening a terminal and running the command "python". On Windows you will have to find the python.exe binary in your installation path.

Once you have the Python interpreter up and running, try the following piece of code:

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
print "Hello World"
```

Python has all kind of common logic built in and there's a lot to talk about here, but Python has some excellent [documenation](https://docs.python.org/2/) for almost everything.
I can also recommend [CodeAcademys Python course](http://www.codecademy.com/en/tracks/python) which is done in an online interpreter with intuitive examples and assignments.

Continue to the next step once you feel that you have basic knowledge in Python.

## Developing for OP5 Monitor with Python

Developing plugins for OP5 Monitor, Naemon or Nagios is straight forward. The different states (Ok, Warning, Critical, Unknown) are set depending on the exit codes (0,1,2,3) of the program and the output to stdout is used for displaying a status message and performance statistics.

### Development guidelines

At OP5 we really appreciate when developers follow the developer guidelines, the developer guidelines can be found over at [monitoring-plugins.com](https://www.monitoring-plugins.org/doc/guidelines.html). In short, having the following options makes the plugin easier to use:

- -H for hostname
- -h for short help
- --help for long help output
- -v for verbose mode and -vv for very verbose mode

### Exit codes, what you need to know

Exit codes are the backbone of the check plugins and are required to be used with OP5 Monitor.
One thing to know though is that the exit codes translates to different things if the object that is using the plugins is a host or service, for instance:

Exit Code

Service status

Host status

Description

0

OK

UP

Everything is working as it should

1

WARNING

-

Things are kind of working, might be some problems.

2

CRITICAL

DOWN

Things are not working.

3

UNKNOWN

-

Something went wrong with the supplied commands or the plugins isn't working as it should.

### Output, what you need to know

Output from OP5 Monitor, Naemon or Nagios plugins are used for displaying a status message and/or performance data which is used for performance or health statistics. See the following example of output:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
OK: I'm plugin output and I found one cat | cats=1;5;10;0;11
```

In the above example the pipe (|) char separates the status message from the performance data. The string "OK: I'm plugin output and I found one cat" will be the status message and the "cats=1;5;10;0;11" will generate the graphs,
where 1 = current number of cats, 5 = number of cats for warning threshold, 10 = number of cats for critical threshold, 0 & 11 is for min and max in the graph.

For more info see the [Development Guidelines](https://www.monitoring-plugins.org/doc/guidelines.html)([performance data](https://www.monitoring-plugins.org/doc/guidelines.html#AEN200), [status message](https://www.monitoring-plugins.org/doc/guidelines.html#AEN33)) over at Monitoring Plugins.

### Examples

#### First Example: Dead Simple Plugin

Read through this code, try to understand what it does. There's explanations below for reference. ([Download](images/11632752/11567123.py))

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
!/usr/bin/env python
state = "OK"
if state == "OK":
    print "We are OK."
    exit(0)
elif state == "WARNING":
    print "We are WARNING."
    exit(1)
elif state == "CRITICAL":
    print "We are CRITICAL."
    exit(2)
elif state == "UNKNOWN":
    print "We are UNKNOWN."
    exit(3)
else:
    print "Shouldn't be here."
    exit(127)
```

Lets go through the key concepts of this code:

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
state = "OK"
```

This is just a simple variable assignment, in this example the variable is assigned statically but this could and will in most cases be assigned with some logic.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
if state == "OK":
    print "We are OK."
    exit(0)
elif state == "WARNING":
    print "We are WARNING."
    exit(1)
elif state == "CRITICAL":
    print "We are CRITICAL."
    exit(2)
elif state == "UNKNOWN":
    print "We are UNKNOWN."
    exit(3)
else:
    print "Shouldn't be here."
    exit(127)
```

This is where the "magic" happens, we are now checking our state and depending on what state is we are exiting with the correct exit code. At the bottom of the if statement we have a else where we shouldn't end up, instead of 127 as a exit code we could probably use 3 here also, because it's kind of an unknown state.

#### Second Example: Dead Simple Plugin with Arguments

Here's a bit more advanced example with argument parsing, it looks kind of like the first example but with some user input. Go through the code and see if you understand what it does, explanations is found below the code. ([Download](images/11632752/11567122.py))

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
#!/usr/bin/env python
import argparse
parser = argparse.ArgumentParser(description="Dead Simple Plugin with arguments.")
parser.add_argument(
    "-s",
    help="State type, can be OK, WARNING, CRITICAL or UNKNOWN",
    required=True,
    choices=["OK", "WARNING", "CRITICAL", "UNKNOWN"])
parser.add_argument(
    "-w",
    help="Warning threshold",
    required=True,
    type=int)
parser.add_argument(
    "-c",
    help="Critical threshold",
    required=True,
    type=int)
args = parser.parse_args()
if args.s == "OK":
    print "We are OK. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(0)
elif args.s == "WARNING":
    print "We are WARNING. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(1)
elif args.s == "CRITICAL":
    print "We are CRITICAL. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(2)
elif args.s == "UNKNOWN":
    print "We are UNKNOWN. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(3)
else:
    print "Shouldn't be here."
    exit(127)
```

Lets go through the key concepts of this code:

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
import argparse
```

Python has a great system that allows you to import different modules to extend the applications functionality. *argparse* is one of those awesome modules which is used for parsing command line arguments. For more info on argparse, check out the [manuals](https://docs.python.org/2/howto/argparse.html).

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
parser = argparse.ArgumentParser(description="Dead Simple Plugin with arguments.")
```

Here we create a new argument parser instance which we will add logic to later on.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
parser.add_argument(
    "-s",
    help="State type, can be OK, WARNING, CRITICAL or UNKNOWN",
    required=True,
    choices=["OK", "WARNING", "CRITICAL", "UNKNOWN"])
parser.add_argument(
    "-w",
    help="Warning threshold",
    required=True,
    type=int)
parser.add_argument(
    "-c",
    help="Critical threshold",
    required=True,
    type=int)
```

This piece of code will add arguments to our parser, the add\_argument function takes a lot of arguments. Take a look at the docs mentioned above for more information.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
args = parser.parse_args()
```

To be able to use our arguments, we need to parse them. This nice function will do it for us. Afterwards arguments can be found using the variable args.option. So in other words args.s will be the string that we submitted to the -s switch.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
if args.s == "OK":
    print "We are OK. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(0)
elif args.s == "WARNING":
    print "We are WARNING. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(1)
elif args.s == "CRITICAL":
    print "We are CRITICAL. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(2)
elif args.s == "UNKNOWN":
    print "We are UNKNOWN. | somegraph=1;%s;%s;;" % (args.w, args.c)
    exit(3)
else:
    print "Shouldn't be here."
    exit(127)
```

As in the first example we will need some logic to determinate what todo with the input, this if handles the logic like a beast and we are also including performance data in the output. Yay!

#### Third example, using pynag to make development easier

Once you understand the basic principles of plugin development, moving on to using a class/lib for making the development process easier is preferred. There's alot of different libraries for this out there but here's an example using [pynag](http://pynag.org). ([Download](images/11632752/11567156.py))

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
#!/usr/bin/env python
# Built on boilerplate form pynag:
# https://github.com/pynag/pynag/wiki/Writing-Plugins-with-pynag.Plugins.PluginHelper
# Example usage:
# python pynag2.py -s WARNING --th metric=some-metrics,ok=0..5,warning=5..10,critical=10..inf
#Modules
from pynag.Plugins import PluginHelper, ok, warning, critical, unknown
helper = PluginHelper()
# Arguments
helper.parser.add_option("-s", help="Exit State", dest="state", default='OK')
helper.parse_arguments()
if helper.options.state == "OK":
    helper.status(ok)
elif helper.options.state == "WARNING":
    helper.status(warning)
elif helper.options.state == "CRITICAL":
    helper.status(critical)
elif helper.options.state == "UNKNOWN":
    helper.status(unknown)
else:
    print "No state specified, calculating from input metrics."
helper.add_metric(label='some-metrics',value=5)
helper.add_summary("Some status message.")
helper.check_all_metrics()
helper.exit()
```

Lets go through this code and what it does.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
helper = PluginHelper()
```

After importing the different modules in this library, start with creating a instance of our pluginhelper. This will be the core functionality we we will be working around.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
helper.parser.add_option("-s", help="Exit State", dest="state", default='OK')
helper.parse_arguments()
```

Pretty straight forward here, add some arguments for your plugin. This example will take a argument that defines the exit status of the plugin. Most of the arguments are already defined when using the PluginHelper().

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
if helper.options.state == "OK":
    helper.status(ok)
elif helper.options.state == "WARNING":
    helper.status(warning)
elif helper.options.state == "CRITICAL":
    helper.status(critical)
elif helper.options.state == "UNKNOWN":
    helper.status(unknown)
else:
    print "No state specified, calculating from input metrics."
```

Again, here's the "logic" for this plugin, but instead of running exit directly in the if, we are setting the exit state that will be used when helper.exit() runs.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
helper.add_metric(label='some-metrics',value=5)
helper.add_summary("Some status message.")
```

Pynag has some very neat functions for adding status messages and different metrics. using add\_metric() you can add different metrics and assign values to these. Also there's no need to specify extra arguments for thresholds per metric due to the nifty functions of --th switch that's implemented in pynag.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
helper.check_all_metrics()
helper.exit()
```

Before exiting, validate metrics.

### Roundup

That's about it for the plugin examples. As you can see mostly it's about using the correct arguments, printing the correct stuff to stdout and exiting in a correct way. Not that hard ones you understand the concepts.

### Now what?

After going through the above, you should be kind of set to start working with plugins. From now on there's only one way to learn and that's to develop, develop, rethink and refine. Don't forget to use the numerous tools and libraries that Python has for managing data. :-)

We would also like to mention that there's a lot of different libraries for developing plugins and working with configuration in OP5 Monitor, Naemon or Nagios. Check out the following sites for more info:

- <https://pypi.python.org/pypi/nagiosplugin/>
- <http://pynag.org>
