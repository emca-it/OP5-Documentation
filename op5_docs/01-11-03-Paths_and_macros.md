# Paths and macros

## About

We hope the previous section made you eager to tweak an existing plugin or port some of your existing scripts to be OP5 plugins. We want our tool to amplify your existing monitoring specializations as you grow.

You probably also saw some variables and wondered, "is there an API, or at least a list?" Not only are there lists, but there is an entire naming system.

Earlier we [mentioned that Naemon maintains plugin compatibility with Nagios](https://kb.op5.com/x/lQprAQ). Nagios is famous for its set of variables for plugins, which are known as macros. Naemon's documentation includes both [the macro list](http://www.naemon.org/documentation/usersguide/macrolist.html) as well as [a great page for understanding how to think about them](http://www.naemon.org/documentation/usersguide/macros.html) and implement them.

To get you moving, we have provided just a few of the most important macros below. These are most important things to understand before you go to another page.

## Most important macros

### USER series

The '`$USER#$`' series of macros deal with paths to plugins. We configure these in the resource configuration file, '`/opt/monitor/etc/resource.cfg`':

- '`$USER1$`' is the path to the main plugins directory on the Monitor server. In OP5, this path is '`/opt/plugins`'. Anyone coming from Nagios will want to take note of this difference.
- '`$USER1$/custom`' is the default path to any custom plugins. This directory is not only for your in-house scripts, but any plugin that you do not want to be touched during upgrades.
- To learn more about '`$USER2$`' and '`$USER3$`', please read the resource configuration file.
- The notes in the resource configuration file mention that '`$USER1$`' through '`$USER10$`' are reserved. We would strongly advise strongly you not to change any of their values.
- If you want to create any new site-wide plugin macros (in contrast to host, service, or contact directives for templates), we have left '`$USER11$`' through '`$USER255$`' for your use.
- Nagios Core only allowed up to 32 USER macros; Naemon allows up to 255. The resource configuration file does not mention this increase.

### ARGument series

The '`$ARG#$`' series of macros deal with command-line arguments for commands made from plugins. This will be very useful for macro substitution, such as passing a service template's baseline critical percentage as the third argument value (i.e.: '`$ARG3$`') in an SNMP-centric plugin.
