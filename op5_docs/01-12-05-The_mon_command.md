# The mon command

## About

The mon command is a very powerful command. Primarily, this is the command that is used to manually stop and start the monitor system processes, and to set up a distributed or a load balanced environment.

Handle this command with care! It has the power to both create and destroy your whole OP5 installation.

**Do not use this command unless specifically instructed by OP5 Support or the Documentation itself.**

## The commands

``` {style="margin-left: 30.0px;"}
mon
```

Simply running the command without any arguments will present a small syntax help text, and a list of available sub commands. Most sub commands are categorized, meaning that mon has to be run with at least two arguments to trigger the sub command. A few sub commands are non-categorized, requiring only a single argument being passed to mon to trigger the sub command.

### start

``` {style="margin-left: 60.0px;"}
mon start
```

This command will start the monitor and merlind system processes.

### stop

``` {style="margin-left: 60.0px;"}
mon stop
```

This command will stop the monitor and merlind system processes.

### restart

``` {style="margin-left: 60.0px;"}
mon restart
```

This command will restart the monitor and merlind system processes.

### ecmd

#### search

``` {style="margin-left: 90.0px;"}
mon ecmd search <regex>
```

Prints 'templates' for all available commands matching \<regex\>.
 The search is case insensitive.

#### submit

``` {style="margin-left: 90.0px;"}
mon ecmd submit [options] command <parameters>
```

Submits a command to the monitoring engine using the supplied values.
 Available options:

``` {style="margin-left: 90.0px;"}
--pipe-path=</path/to/nagios.cmd>
```

**Example:**
 An example command to add a new service comment for the service PING on the host foo would look something like this:

``` {style="margin-left: 90.0px;"}
mon ecmd submit add_svc_comment service='foo;PING' persistent=1 author='John Doe' comment='the comment'
```

Note how services are written. You can also use positional arguments, in which case the arguments have to be in the correct order for the command's syntactic template. The above example would then look thus:

``` {style="margin-left: 90.0px;"}
mon ecmd submit add_svc_comment 'foo;PING' 1 'John Doe' 'the comment'
```

### log

#### show

``` {style="margin-left: 90.0px;"}
mon log show
```

Runs the showlog helper program. Arguments passed to this command will be sent to the showlog helper.
 For more information, a help text can be found by running the command like this:

``` {style="margin-left: 90.0px;"}
mon log show --help
```

### node

#### add

``` {style="margin-left: 90.0px;"}
mon node add <name> --type=[peer|poller|master] [var1=value] [varN=value]
```

Adds a node with the designated type and variables.

#### ctrl

``` {style="margin-left: 90.0px;"}
mon node ctrl <name1> <name2> [--self] [all|--type=<peer|poller|master>] -- <command>
```

Execute \<command\> on the remote node(s) named.

Optional arguments:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>--self</p>
<p>Run the command on the local system also.</p></td>
<td align="left">--all
Run the command on all configured nodes.</td>
</tr>
</tbody>
</table>

The first unrecognized argument marks the start of the command to be executed, but using double dashes is recommended. Use single-quotes to execute commands with shell variables, output redirection or scriptlets, like so:

``` {style="margin-left: 90.0px;"}
mon node ctrl -- '(for x in 1 2 3; do echo $x; done) > /tmp/foo'
```

``` {style="margin-left: 90.0px;"}
mon node ctrl -- cat /tmp/foo
```

#### list

``` {style="margin-left: 90.0px;"}
mon node list [--type=poller,peer,master]
```

Lists all nodes of the (optionally) specified type

#### remove

``` {style="margin-left: 90.0px;"}
mon node remove <name1> [name2] [nameN]
```

Removes one or more nodes from the merlin configuration.

#### show

``` {style="margin-left: 90.0px;"}
mon node show [--type=poller,peer,master]
```

Display all variables for all nodes, or for one node in a fashion suitable for being used as eval \$(mon node show nodename) from shell scripts and scriptlets.

#### status

``` {style="margin-left: 90.0px;"}
mon node status
```

Show status of all nodes configured in the running Merlin daemon.
 Red text points to problem areas, such as high latency or the node being inactive, not handling any checks, or not sending regular enough program\_status updates.

### oconf

#### changed

``` {style="margin-left: 90.0px;"}
mon oconf changed
```

Print the last modification time among all object configuration files.

#### files

``` {style="margin-left: 90.0px;"}
mon oconf files
```

Print a list of the naemon object configuration files in alphabetical order.

#### hash

``` {style="margin-left: 90.0px;"}
mon oconf hash
```

Print an sha1 hash of the running configuration.

#### hglist

``` {style="margin-left: 90.0px;"}
mon oconf hglist
```

Print a sorted list of all configured hostgroups.

#### nodesplit

``` {style="margin-left: 90.0px;"}
mon oconf nodesplit
```

Same as 'split', but use merlin's config to split config into configuration files suitable for poller consumption

#### push

``` {style="margin-left: 90.0px;"}
mon oconf push
```

Splits configuration based on merlin's peer and poller configuration and send object configuration to all peers and pollers, restarting those that receive a configuration update. ssh keys need to be set up for this to be usable without admin supervision.
 This command uses 'nodesplit' as its backend.

#### split

``` {style="margin-left: 90.0px;"}
mon oconf split <outfile:hostgroup1,hostgroup2,hostgroupN>
```

Write config for hostgroup1,hostgroup2 and hostgroupN into outfile.

### sshkey

#### fetch

``` {style="margin-left: 90.0px;"}
mon sshkey fetch
```

Fetches all the SSH keys from peers and pollers.

The fetch command is not recommended – run the push command instead.

#### push

``` {style="margin-left: 90.0px;"}
mon sshkey push
```

Pushes the local SSH keys to all peers and pollers.

### sysconf

#### ramdisk

``` {style="margin-left: 90.0px;"}
mon sysconf ramdisk
```

To enable the ramdisk setup:

``` {style="margin-left: 90.0px;"}
mon sysconf ramdisk enable
```

A ramdisk can be enabled for storing spools for performance data and checkresults.

As of Monitor 6, enabling the ramdisk is no longer recommended. To disable the ramdisk if already enabled, see the separate article [Reverting a ramdisk enabled setup back to the default non-ramdisk layout](https://kb.op5.com/display/HOWTOs/Reverting+a+ramdisk+enabled+setup+back+to+the+default+non-ramdisk+layout).

### check

#### spool

``` {style="margin-left: 90.0px;"}
mon check spool [--maxage=<seconds>] [--warning=X] [--critical=X] <path> [--delete]
```

Checks a certain spool directory for files (and files only) that are older than 'maxage'. It's intended to prevent buildup of checkresult files and unprocessed performance-data files in the various spool directories used by OP5 Monitor.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>--delete</p>
<p>Remove files that are too old.</p></td>
<td align="left"><p>--maxage</p>
<p>Is given in seconds and defaults to 300 (5 minutes).</p></td>
</tr>
</tbody>
</table>

Only one directory at a time may be checked.

#### cores

``` {style="margin-left: 90.0px;"}
mon check cores --warning=X --critical=X [--dir=]
```

Checks for memory dumps resulting from segmentation violation from core parts of OP5 Monitor. Detected core-files are moved to /tmp/mon-cores in order to keep working directories clean.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>--warning</p>
<p>Default is 0</p></td>
<td align="left"><p>--critical</p>
<p>Default is 1 (any corefile results in a critical alert)</p></td>
</tr>
</tbody>
</table>

#### distribution

```
mon check distribution [--no-perfdata]
```

Checks to make sure distribution works ok.

Note that it's not expected to work properly the first couple of minutes after a new machine has been brought online or taken offline

#### exectime

``` {style="margin-left: 90.0px;"}
mon check exectime [host|service] --warning=<min,max,avg> --critical=<min,max,avg>
```

Checks execution time of active checks.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>[host|service]</p>
<p>Select host or service execution time.</p></td>
<td align="left"><p>--warning</p>
<p>Set the warning threshold for min,max and average execution time, in seconds</p></td>
</tr>
</tbody>
</table>

#### latency

``` {style="margin-left: 90.0px;"}
mon check latency [host|service] --warning=<min,max,avg> --critical=<min,max,avg>
```

Checks latency time of active checks.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>[host|service]</p>
<p>Select host or service latency time.</p></td>
<td align="left"><p>--warning</p>
Set the warning threshold for min,max and average execution time, in seconds</td>
</tr>
</tbody>
</table>

#### orphans

``` {style="margin-left: 90.0px;"}
mon check orphans
```

Checks for checks that haven't been run in too long a time.
