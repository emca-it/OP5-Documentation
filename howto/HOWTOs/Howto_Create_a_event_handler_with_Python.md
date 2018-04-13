# Howto: Create a event handler with Python

## Introduction

Event handlers are applications that can be used to restart crashed services, change device configuration or similar, based on the result of service checks in *op5 Monitor*.
In this how-to we will look at creating a custom event handler in Python.
If you're not familiar with Python, check out our check plugin tutorial for more information.

## How does event handlers work?

Every time a service change state, OP5 Monitor will run the event handler that's associated with that service or host.Just like check plugins, an event handler is a external program or script executed by the scheduler. It's given some arguments and then performs some logic.

The event handler is defined as a command and can use the built in *Naemon* or [*Nagios macros*](http://nagios.sourceforge.net/docs/3_0/macrolist.html).

## Example

 In this example we create a Python script that will increase the memory of a virtual machine in VMWare, if the service monitoring memory usage changes to a critical state.

###  Step 1, Create the event handler

First off, we need to create the event handler. In steps, it will do the following:

1. Take arguments of the current state, kind of state (hard or soft), name and check attempt.
2. If it's a softstate, the current attempt is the first and it's a critical alert.
    1.  Increase memory using an API.

The above would look somehow like this in Python: ([Download](attachments/11633113/11567179.py))

``` {.py data-syntaxhighlighter-params="brush: py; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: true; theme: Confluence"}
#!/usr/bin/env python

import argparse

parser = argparse.ArgumentParser(description="This event handler will increase the memory of a ESX guest when triggered.")

parser.add_argument("--service-state", help='The service state, use $SERVICESTATE$', required=True)
parser.add_argument("--service-state-type", help='The type of the state, use $SERVICESTATETYPE$', required=True)
parser.add_argument("--service-attempt", help='Current attempt number, $SERVICEATTEMPT$', required=True, type=int)
parser.add_argument("--host-name", help='The host name, use $HOSTNAME$', required=True)

args = parser.parse_args()

def increaseEsxGuestMemory(aHost, memoryAmount):
    #Do some stuff to increase memory here.
    notifySysAdmin("Nils Nilsson", "We just increased some memory on %s." % (aHost))
    return 0

def notifySysAdmin(aAdmin, aMessage):
    #Notify sysadmin here.
    print "To: %s; %s" % (aAdmin, aMessage)
    return 0

if args.service_attempt == 1 and args.service_state == "CRITICAL" and args.service_state_type == "SOFT":
    increaseEsxGuestMemory(args.host_name, "512 mb")
```

Once we have created our event handler, it should be placed in /opt/plugins/custom/.

### Step 2, create the command and associate with service in OP5 Monitor

In OP5 Monitor, go to Configure -\> Commands and make sure that "Add New" is selected.

command\_name: increase-memory
command\_line: \$USER3\$/custom/increase-memory.py --service-state \$SERVICESTATE\$ --service-state-type \$SERVICESTATETYPE\$ --service-attempt \$SERVICEATTEMPT\$ --host-name \$HOSTNAME\$

Press Save, and then open up the service wich you want to use to notify the ticket system.

Click Advanced to expand advanced properties

Change event\_handler to increase-memory

Press Save

And lastly, save your changes in the configuration export dialog.

### Step 3

Now you can watch the tickets role in to the ticket system!

## Explanation of the event handler code

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
import argparse

parser = argparse.ArgumentParser(description="This event handler will increase the memory of a ESX guest when triggered.")
parser.add_argument("--service-state", help='The service state, use $SERVICESTATE$', required=True)
parser.add_argument("--service-state-type", help='The type of the state, use $SERVICESTATETYPE$', required=True)
parser.add_argument("--service-attempt", help='Current attempt number, $SERVICEATTEMPT$', required=True)
parser.add_argument("--host-name", help='The host name, use $HOSTNAME$', required=True)

args = parser.parse_args()
```

As always, try to utilize argparse when using arguments. It makes things alot easier. In short we are importing the argparse module and adding the arguments we need.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
def increaseEsxGuestMemory(aHost, memoryAmount):
    #Do some stuff to increase memory here.
    notifySysAdmin("Nils Nilsson", "We just increased some memory on %s." % (aHost))
    return 0

def notifySysAdmin(aAdmin, aMessage):
    #Notify sysadmin here.
    print "To: %s; %s" % (aAdmin, aMessage)
    return 0
```

This is a example function for upgrading memory, but for now and while we are testing, it just prints to stdout.

``` {.py data-syntaxhighlighter-params="brush: py; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: py; gutter: false; theme: Confluence"}
if args.service_attempt == 1 and args.service_state == "CRITICAL" and args.service_state_type == "SOFT":
    increaseEsxGuestMemory(args.host_name, "512 mb")
```

This is the place where we decide what to do, depending on if it's a hard or soft state and what type of error we recieve.
