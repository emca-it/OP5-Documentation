# How to write your own plugin to OP5 Monitor or Nagios

## Introduction

op5 Monitor is shipped with many plugins that cover most monitoring needs. But what to do if one of your corporate applications can not be monitored straight out of the box? Often you can find a plugin at [www.monitoring-plugins.org](https://www.monitoring-plugins.org/) or [www.nagiosexchange.org](http://www.nagiosexchange.org/ "Nagios exchange"), and since OP5 Monitor, Naemon and Nagios uses the same plugin format you can often simply download a plugin, put it in the correct directory and start using it.

However, if you can not find a suitable plugin anywhere you might have to write your own plugin. This article aims to describe the format and walk you through writing a simple plugin. It is intended for the OP5 system administrator who wants to extend the capabilities of an OP5 System and leave the boss impressed with how precise data can be extracted.

## Prerequisites

- Scripting/Programming knowledge
- Root-privileges  on the host system running OP5 Monitor

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

## Accessing and editing files

In order to develop plugins of your own, you will need shell access and sometimes the possibility to transfers files to and from the OP5 server.

If you do not already have this, software that can provide this for Windows is [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/) for terminal access via SSH and [WinSCP](http://winscp.net/) for file transfers via SFTP (SSH). If you use a Macintosh or UNIX/Linux desktop you can use the commands ssh or scp from a local terminal window.

You will need to use a text editor to write your plugin. On the OP5 server there are two popular editors that you could use for this purpose: vim and jed.

vim is a very capable mode based editor that has a high usability threshold, whilst jed is also a capable text editor that is friendlier to first time users. If you do not know what you want to use, it is a good idea to start with jed. If you want to use jed, you need to have a terminal with light text and dark background to see the text.

## Paths and check\_commands

Most of the plugins are installed by default in /opt/plugins/ which is also what \$USER1\$ expands to when you define check\_commands. There is a subdirectory called /opt/plugins/custom/ that is intended for site specific plugins, such as downloaded plugins or plugins that has been written specifically for the site. This directory is hence \$USER1\$/custom/ when you define check\_commands.

## The plugin interface

A plugin is a small executable that takes optional command line parameters as input and

- Performs a test
- Reports a diagnostic message to stdout (will be shown in the web gui)
- Returns an exit code of 0, 1, 2 or 3 for OK, Warning, Critical or Unknown

### Example

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
monitor!root:~# /opt/plugins/check_tcp -H 193.201.96.136 -p 80
TCP OK - 0.043 second response time on port 80|time=0.042824s;0.000000;0.000000;0.000000;10.000000
monitor!root:~# echo $?
0
monitor!root:~# /opt/plugins/check_tcp -H 193.201.96.136 -p 143
Connection refused
monitor!root:~# echo $?
2
```

In this example we first execute check\_tcp to test that port 80/tcp on 193.201.96.136 responds which it does, hence the exit code of 0. Then we check port 143/tcp on the same host and that port is not open, hence the result is Critical – exit code 2.

Also note that the output is actually divided by a | sign. The text on the left hand side of | will be shown in the web interface, whilst the text on the right hand side will only be stored as performance data – amongst others for the graph button you can find to the right of some services name.

## Creating a Hello world plugin

Create a file called "helloworld" and open it with a text editor like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom
touch helloworld
chmod 755 helloworld
jed helloword
```

When you have jed running you’ll find that the menus can be accessed with arrow keys and enter after pressing F10 to activate them.

Type in the following example plugin:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: true; theme: Confluence"}
#!/bin/sh

echo "WARNING: Hello world"
exit 1
```

Choose Exit from the File menu or press \^C\^X and then type yes to save it.

Now try running it from the terminal:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
monitor!root:/opt/plugins/custom# ./helloworld
WARNING: Hello world
monitor!root:/opt/plugins/custom# echo $?
1
monitor!root:/opt/plugins/custom#
```

### Configuring monitor to use the plugin

Go to Configure in the web gui, and choose Check Commands

Scroll to the bottom of the page to add a new command. Call it something that makes it stand out from the other commands – to make it easier in the future. For instance:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
check_local_helloworld</td>
<td align="left">command_line:
 $USER1$/custom/helloworld</td>
</tr>
</tbody>
</table>

Then select Apply changes and save configuration.

Now you can add this command as a service for your hosts.

## Writing a useful plugin

By now you probably have a very basic hello world plugin running. This is hardly useful though, so we shall look at creating a more complex and useful one. We’ll stick to bash, because of the simplicity, but in theory we could use any programming language.

We will create a plugin that checks that the storage path specified in /etc/op5backup.conf exists, to make sure that op5-backup is configured properly for local operation – this test will not necessarily succeed if you put your op5-backup files on an FTP account.

Start by creating the script and editing it:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
cd /opt/plugins/custom
touch check_op5-backup
chmod 755 check_op5-backup
jed check_op5-backup
```

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: true; theme: Confluence"}
#!/bin/bash

# Create a function to print the storagepath and remove other than the path to the backup directory
storagepath() {
    grep ^storagepath /etc/op5-backup/main.conf | tail -1 | sed 's/storagepath="//g' | sed 's/"//g'
}

# Put the storage path in an environmental variable
STORAGEPATH=`storagepath`

# Test if the storagepath exists and is a directory
if [ ! -d "$STORAGEPATH" ]; then
    # Print a warning message for the web gui
    echo "op5-backup is not properly configured for local operation"
    # Exit with status Warning (exit code 1)
    exit 1

else
    # If the script reaches this point then the test passed
    # Print an OK message
    echo $STORAGEPATH exists
    # Exit with status OK
    exit 0

fi
```

Now add a check\_command like this using the OP5 Monitor web gui:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
check_op5-backup</td>
<td align="left">command_line:
 $USER1$/custom/check_op5-backup</td>
</tr>
</tbody>
</table>

Enter the service configuration for your monitor server, and add a service with check\_op5-backup as the check\_command.

Save configuration and try it out!

## Other examples

Since many people find examples an easy way of learning, the following links provides an example of a really simple plugin written in both Perl and C. The plugin takes one argument, a filename, and returns OK if the file exists and CRITICAL if it does not. They also include timeout-handling.

In order to use the perl example you only need the copy the file into the /opt/plugins directory of the monitor-server. In order to compile the C-version, you need to rebuild the plugins-package from source. The source can be found at the [Monitoring-plugins website](https://www.monitoring-plugins.org/).

- [Perl Example](#)
- [C example](#)

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)
