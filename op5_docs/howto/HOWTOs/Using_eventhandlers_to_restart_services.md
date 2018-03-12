# Using eventhandlers to restart services

## **General info**

This how-to describes the principle of using event handlers in op5 Monitor to restart services/processes/daemons that has stopped responding in a correct manner.

The principle is described using an example where we restart Microsoft Internet Information Service (IIS).
You can of course use event handlers to initiate any kind of action upon a state-change of a host or a service (like writing an entry to a log or power cycling an appliance-server).

Advanced:[Adding support for arguments](#Usingeventhandlerstorestartservices-Addingsupportforarguments)

## **How it all works**

Upon a state-change of a host or service an event handler can be executed. Every host and service object has three related advanced settings that control this behavior:
 `event_handler` – the command to call
 `event_handler_args` – the arguments to pass along to the command
 `event_handler_enabled` – on/off-switch for the event handler

The event handler that you have defined is executed whenever a host or service state change occurs.

A event handler is a command just like your other check-commands – a configuration object with a name and a command\_line that may be configured to handle arguments.
Typically the event handler is a reference to a script.

The script that is called should be able to perform different action depending on what kind of state-change that just occurred.
It’s a good idea to have some kind of logging performed by your event handler-script.

A typical action performed by an event handler-script is to call a NRPE (Nagios Remote Plugin Executor) command on a remote server.

The remote command can for example execute a local script which restarts a service or process.

## **The IIS example**

In this example we assume that we already have a service configured that test the availability of a website.
If this service goes critical we want to use an event handler to restart the IIS-service on the remote server that serves the website.

### **Important files, commands and adresses**

Windows-server-side-script:   `restartiis.bat` (not supplied in this white-paper)
Event handler script:               `restart_windows_service.sh`
nrpe command name:             `restart_iis`
Windows host:                         `192.168.1.8`

### The Windows-server-side

First we script and test the restart-action for the IIS service.

First create some kind of script that stop and starts the IIS-service (If “net stop” isn’t enough, use pskill from SysInternals).
Save your script to the following path and filename: `C:\Program Files\OP5\op5_NSClient++\scripts`
Edit `custom.ini` located in `C:\Program Files\OP5\op5_NSClient++`. Add a line similar to this one:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
[NRPE Handlers]
command[restart_iis]=C:\Program Files\OP5\op5_NSClient++\scripts\restartiis.bat
```

Restart the NSClient++ system service to reload the configuration.

Test your restart-action end-to-end from the command line interface at your op5 server (via ssh or directly at console):

    /opt/plugins/check_nrpe -H 192.168.1.8 -c restart_iis

If your test successfully restarted the IIS-service, you can now continue with the scripting and configuration at the op5 Monitor server-side.

### The op5 Monitor server-side

First create a script that your new event handler-command can refer to.
The script must be able to handle different state-types and have some kind of logging. An example follows:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
#!/bin/bash
#
# Event handler script for executing an NRPE command on a given host when a service
# is in CRITICAL and HARD state.
#
state=$1 # eg. "OK","CRITICAL,"WARNING","UNKNOWN"
statetype=$2 # eg. "SOFT","HARD"
host=$3 # hostaddress of where to execute nrpe command
command=$4 # nrpe command to execute
logfile=/opt/monitor/var/eventhandler.log # logfile to store executions by this eventhandler

# Date format: "2016-03-29 13:10 CEST"
date=`date +"%Y-%m-%d %H:%M %Z"`
case "$1" in
    CRITICAL)
        if [ "$statetype" = "HARD" ] ; then
            /bin/echo -en "$date | ${0##*/} Got state: <$state> and statetype: <$statetype> with command <$command> for execution on host <$host>\n" >> $logfile
            /opt/plugins/check_nrpe -H $host -c $command >> $logfile
        fi
;;
esac
exit 0
```

This simple example-script executes a NRPE-command at a remote server if it is called with a couple of arguments where the first one is CRITICAL and the second one is HARD.
It logs an informational line plus the output from the execution to a log file.

Now place this script in `/opt/plugins/custom/`.

Change the permissions to 755:

    chmod 755 /opt/plugins/restart_windows_service.sh

Use Configure in op5 Monitors and add a new “command” (Configure -\> Commands).
Configure your new command like this:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
restart_windows_service</td>
<td align="left">command_line:
$USER1$/custom/restart_windows_service.sh $SERVICESTATE$ $SERVICESTATETYPE$ $HOSTADDRESS$ restart_iis</td>
</tr>
</tbody>
</table>

When you have saved your new “command” you edit the host where you want to use your new event handler-command and select the service where you want to use it.
Click the Advanced-link and set the parameter "`event_handler"` to “`restart_windows_service`” and Save your configuration.

You should now have a working event handler.
 

As of version 7.1.6, event handlers are executed on all peers in a load balanced/high availability setup.
If you use peering and event handlers, make sure to implement logic in your scripts to prevent execution by more than one peer.

## **Adding support for arguments**

**
**

The above configuration can be modified to accept arguments (like which service that should be restarted). This is described below.

To make the above example more generalized you can add support for arguments, like which windows-service name to restart upon problems with a certain service.

Windows-service names are the short name for a service(Manage this computer -\> Services -\> Properties -\> “Service Name” (Not Display Name))

It’s important to understand that adding support for arguments involves modifying the whole transport of data between the op5 Monitor server and the target Windows server.

### **The configuration-changes**

#### **The Windows-server-side**

Add the following to custom.ini:

    allow_arguments=1

This makes NRPE able to process requests with arguments.

Make a copy of restartiis.bat to restartservice.bat and change it to process a supplied argument.

Change your previously configured command definition in `custom.INI` to:

    restart_service="C:\Program Files\OP5\op5_NSClient++scripts\restartservice.bat" $ARG1$

 

Please note that we add `$ARG1$` /and/ change the name of the command

 

Restart the NSClient++-service to load the changes.

### **The op5 Monitor server-side**

First we need to modify the event handler-script. An example follows.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
#!/bin/bash
#
# Event handler script for executing an NRPE command on a given host when a service
# is in CRITICAL and HARD state.
#
state=$1 # eg. "OK","CRITICAL,"WARNING","UNKNOWN"
statetype=$2 # eg. "SOFT","HARD"
host=$3 # hostaddress of where to execute nrpe command
command=$4 # nrpe command to execute
cmdarg=$5
logfile=/opt/monitor/var/eventhandler.log # logfile to store executions by this eventhandler

# Date format: "2016-03-29 13:10 CEST"
date=`date +"%Y-%m-%d %H:%M %Z"`
case "$1" in
    CRITICAL)
        if [ "$statetype" = "HARD" ] ; then
            /bin/echo -en "$date | ${0##*/} Got state: <$state> and statetype: <$statetype> with command <$command> and argument <$cmdarg> for execution on host <$host>\n" >> $logfile
            /opt/plugins/check_nrpe -H $host -c $command -a $cmdarg >> $logfile
        fi
;;
esac
exit 0
```

The following has been added to the event handler-script:

    cmdarg=$5

We have also changed line were we execute `check_nrpe`.

Now we need to edit our check\_command (Configure -\> Commands) and edit the command restart\_windows\_service.

The new command-line should now look like this:

    $USER1$/custom/restart_windows_service.sh $SERVICESTATE$ $SERVICESTATETYPE$ $HOSTADDRESS$ restart_service $ARG1$

Here we have added `$ARG1$` and changed which NRPE-command we call.

Finally we need to change which arguments that are supplied by the `event_handler_args` in the service-definition (Configure -\> select host -\> Services for host -\> select service -\> Advanced):

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">event_handler_args:
Spooler</td>
</tr>
</tbody>
</table>

You should now have a working configuration we’re you can supply as an eventhandler-argument, which windows-service name to restart upon problems.

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

 

