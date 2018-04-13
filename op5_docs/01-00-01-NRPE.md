# NRPE

# About

NRPE, the Nagios Remote Plugin Executor, is a [Unix and Linux client for executing plugins on remote hosts](https://exchange.nagios.org/directory/Addons/Monitoring-Agents/NRPE--2D-Nagios-Remote-Plugin-Executor/details). As part of Naemon's backward compatibility with Nagios plugins, OP5 works with NRPE.

NRPE is used in combination with a set of local plugins. While there are only a few plugins shipped with the OP5 NRPE packages, you can use any of the plugins located on the OP5 Monitor server. The default plugin directory in OP5 Monitor is: `'/opt/plugins'.`

# Caveat

OP5 recommends using SNMPv3 for monitoring Linux systems instead of NRPE. SNMPv3 provides better authentication and encryption, as NRPE provides very little. SNMPv3 is compatible with existing plugins and is [easy to configure](https://kb.op5.com/display/HOWTOs/Configure+a+Linux+server+for+SNMP+monitoring). We provide the following as a thorough presentation of a fallback approach.

# Installing NRPE

Download and install NRPE using the package repository for your operating system, such as:

-   -   RPM packages for Linux distributions based on Red Hat Enterprise (such as RHEL and CentOS);
    -   DEB packages for Linux distributions based on Debian and its family of derivatives that use 'dpkg';
    -   portable source code for local compiling.

# Configuring NRPE

Before we can use the NRPE agent for monitoring with OP5 Monitor, we need to configure the agent. This configuration file is located in '`/etc/nrpe.conf'.`

### NRPE main configuration file settings

**Setting**

**Default**

**Description**

server\_port

5666

The port where NRPE should listen

allowed\_hosts

127.0.0.1

Add the IP of your OP5 Monitor server on this line.
Separate multiple addresses with commas, but avoid using whitespace. Example:

    allowed_hosts=1.2.3.4,1.2.3.5 

nrpe\_user

nobody

The user that executes the NRPE daemon

nrpe\_group

nobody

The group that executes the NRPE daemon

debug

0 (zero)

Set this value to 1 if you need to debug the NRPE.

command\_timeout

60 (sixty)

The default time out for a check command. Increments are in seconds.

dont\_blame\_nrpe

0 (zero)

Set this value to 1 so you can send arguments to NRPE from OP5.

# NRPE Commands

NRPE comes with a few predefined commands. Those commands are located in:

`/etc/nrpe.d/op5_commands.cfg`

You may add your own commands and you should do that in your own file in:

`/etc/nrpe.d/`

You must set the '`.cfg`' extension (suffix) on configuration files. Otherwise it will not be loaded into NRPE when the daemon restarts.

### NRPE command formatting and definitions

NRPE commands have the following syntax:

`command[foo]=/opt/foo --args`

There are two sides to NRPE command definitions, with a single equal-sign (`'='`) as their separator:

|:--|
|**Syntax segment
**

**Description**|`command[foo]`

The string between the square brackets (in this case, '`foo`') will be the name of this command. Typically this gets passed as the first argument to the 'check\_nrpe' plugin.
 Do not use whitespace in command names.|`/opt/foo --args`

The command-line syntax you want to execute. The executable needs to be available on the local host. This also applies to any plugins you may wish to call remotely.|

### Adding commands to NRPE

The following steps will add a command that looks for a process named 'smsd' using the plugin 'check\_procs', which is installed by default with NRPE:

-   1.  Log into the host as root where you have NRPE installed NRPE;
    2.  Create a new configuration file in the directory '/etc/nrpe.d/';
    3.  Edit the new file to add a command definition: 
        -   `command[proc_smsd]=/opt/plugins/check_procs -w 1: -c 2:2 -C sms`d

    4.  Save the file and restart NRPE: 

        -   `service nrpe restart`

# Plugins used with NRPE

The only plugin used with NRPE is 'check\_nrpe'. To use the plugin with [the command defined earlier,](#NRPE-nrpe-cmds) use the following syntax in your service definition:

`/opt/plugins/check_nrpe -H $HOSTADDRESS$ -C proc_smsd`

