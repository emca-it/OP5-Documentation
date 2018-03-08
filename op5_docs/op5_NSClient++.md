# op5 NSClient++

# About

[NSClient++](http://nsclient.org/) is the agent we  for monitoring hosts that run Microsoft Windows. It integrates very well with recent Windows Servers versions, copying its commands into the Registry and simplifying authentication. It also has versions for Linux, but OP5 has not tested against such implementations.

OP5 used to provide a modified version of NSClient++. Starting with version 0.4.x and moving into the 0.5.x series, the main NSClient++ release has a cleaner integration with OP5 Monitor as well as the operating system. We strongly recommend [downloading the latest stable release directly](https://nsclient.org/download/) from our friends there.

**Table of Contents**

-   [About](#op5NSClient++-About)
-   [Lead plugins for NSClient++ communication](#op5NSClient++-LeadpluginsforNSClient++communication)
    -   [check\_nt](#op5NSClient++-check_nt)
    -   [check\_nrpe](#op5NSClient++-check_nrpe)
-   [Configuration files](#op5NSClient++-Configurationfiles)
    -   [Modern approach (v0.5.x)](#op5NSClient++-Modernapproach(v0.5.x))
    -   [Deprecated approach (v0.3.x and older)](#op5NSClient++-Deprecatedapproach(v0.3.xandolder))
    -   [Adding a custom script or plugin to NSClient++](#op5NSClient++-AddingacustomscriptorplugintoNSClient++)

 

# Lead plugins for NSClient++ communication

## check\_nt

This is an increasingly deprecated plugin. In the past OP5 used it for all basic tests, such as CPU, memory, and disks. It can even check Windows services and performances counters.

Nevertheless this plugin has stopped receiving any new development. Thus it does not work as well with more recent versions of Windows Server, in particular 2012 R2 and onward. OP5 strongly recommends using 'check\_nrpe' for any custom scripts or other new work.

## check\_nrpe

This is the same plugin used with the NRPE agent. This makes it very easy to use the same check command for any host server, be it on Windows, Unix, or Linux. We already described how to configure such commands.

Please keep in mind that the 'check\_nrpe' plugin and the NRPE agent are not the same thing. The plugin sits on the OP5 Monitor to make remote calls, while the Unix and Linux agent sits on hosts to listen for those calls. Thus you can use the same check command syntax against a Windows host as a Linux host, because the configuration file on the host will determine how the host will listen and respond.

# Configuration files

NSClient++ operation used to be configured in a set of plaintext files. These are still located in the installation directory, typically "C:\\Program Files\\op5\\nsclient++\\". You can still edit these files, but your edits are not guaranteed to work. Instead you will need Registry write permissions.

## Modern approach (v0.5.x)

Michael Medin, the head of the NSClient++ project, has provided [very good documentation for writing configuration files](https://docs.nsclient.org/settings/). OP5 provides [an in-depth presentation](https://kb.op5.com/x/kAEjAQ) in our Knowledge Base.

## Deprecated approach (v0.3.x and older)

Much of this has been deprecated since version 0.4 and changed again with version 0.5. Please consider this section historical for version 0.3.x. Please also refer to [our more in-depth material from our Knowledge Article](https://kb.op5.com/x/Pw4jAQ) about the older configuration methods.

|:--|
|File

Description|NSC.ini

This is the standard configuration file. This contains the default settings for NSClient++
 This file might be overwritten during an update of NSClient++|op5.ini

This is a op5 specific configuration file. Here are the changes made by op5 entered.
 This file might be overwritten during an update of NSClient++|custom.ini

This is where you shall place your own configuration.
 It will never be overwritten during any update of NSClient++.|

 The default configuration provided is fully functional, but there are some options that likely need to change.

Changing the configuration

To change the configuration open the custom.ini file using your favorite text-editor (e.g. WordPad). This file is empty but take a look at NSC.ini to view all settings. Read the NSC.ini file carefully to get a complete understanding of all configuration options. Lines starting with ; (semicolon) are comments or disabled commands.
 Before the changes will take effect, the op5NSClient++ service must be restarted.
 Options most likely in need for configuration are described bellow, section by section.

subsection

argument

default value

description

`[Settings]`

`allowed_hosts=`

This option lists all servers that are allowed to talk to the agent. Enter the IP-address of the op5 Monitor server or servers if used in a load balanced configuration. If this option is left blank anybody will be able to communicate with the agent.

`[log]`

`debug=`

0 (zero)

Set debug to 1 to enable debugging. This is normally not necessary, as the logs can get large. However this can be very useful when troubleshooting.

`[NSClient]`

`port=`

1248

This is the port where NSClient++ will listen for request for 'check\_nt' or formatted for older NSClient++ versions. If any other application is already using the default port, it might be necessary to change this value.

`[NRPE]`

`port=`

5666

This is the port used for requests formatted for 'check\_nrpe'. OP5 recommends using the default value: otherwise, 'check\_nrpe' check commands on the OP5 Monitor will need to written with a variable and value for the revised port.

Reminder

If you change this value, you also need to make changes in the check\_command used on the OP5 Monitor.

`allow_arguments=`

0 (zero)

Set this to 1 to enable the possibility to include arguments in NRPE requests.

Allowing OP5 Monitor to pass arguments (\$ARG2\$, etc.) could be considered a security risk. Only enable this if the host is not a read-only environment, then set the expected warning and critical values in the custom command syntax.

Note that '1' is the most typical value, even though it is not default. This allows dynamic arguments from the OP5 side. Just make sure to set the 'allowed\_hosts' option described above if you allow arguments.

`[NRPE Handlers]`

NRPE handlers provide a way to execute any custom plugin or check command on the monitored Windows server. This section is where you configure all the commands that should be available.

## Adding a custom script or plugin to NSClient++

`command[my_custom]=c:\mycustomdir\my_prog.exe`

Or the simplified syntax:

`my_custom=c:\mycustomdir\my_prog.exe`

