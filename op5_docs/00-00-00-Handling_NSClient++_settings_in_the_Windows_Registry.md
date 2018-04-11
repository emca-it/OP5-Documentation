# Handling NSClient++ settings in the Windows Registry

Version

This article was written for version 0.4.4 of NSClient++. Versions 0.3.x and earlier of NSClient++ did not rely on the Windows Registry as heavily, so these notes would not apply. These instructions should work on later versions unless otherwise noted.

-   [About the document](#HandlingNSClient++settingsintheWindowsRegistry-Aboutthedocument)
-   [Changed settings location](#HandlingNSClient++settingsintheWindowsRegistry-Changedsettingslocation)
-   [Getting started](#HandlingNSClient++settingsintheWindowsRegistry-Gettingstarted)
-   [Allowed hosts](#HandlingNSClient++settingsintheWindowsRegistry-AllowedhostsAllowed_hosts)
-   [Logging](#HandlingNSClient++settingsintheWindowsRegistry-Logging)
    -   [Changing log file](#HandlingNSClient++settingsintheWindowsRegistry-Changinglogfile)
    -   [Turning on debug mode](#HandlingNSClient++settingsintheWindowsRegistry-Turningondebugmode)
    -   [Log file size](#HandlingNSClient++settingsintheWindowsRegistry-Logfilesize)
-   [Modules](#HandlingNSClient++settingsintheWindowsRegistry-Modules)
-   [External scripts](#HandlingNSClient++settingsintheWindowsRegistry-Externalscripts)
-   [Restarting the NSClient++ service](#HandlingNSClient++settingsintheWindowsRegistry-RestartingtheNSClient++service)
-   [More information](#HandlingNSClient++settingsintheWindowsRegistry-Moreinformation)

# About the document

This document describes how to make changes to the NSClient++ settings in the Windows registry.

# Changed settings location

Starting with version 0.4.0 of [NSClient++](http://www.nsclient.org/) supported storing its settings in the Windows Registry. In 0.4.4 the Windows registry is the default place for the settings. When you install NSClient++ versions 0.4.4 and later, you will be able to tell if you should use OP5 Monitor or Nagios as your monitoring tool. Since you are reading here, you are most likely a OP5 Monitor user and should therefore choose OP5 Monitor. There will then be an 'op5.ini' file included in the installation. You shall not edit any settings in op5.ini. All additional settings made for NSClient++ shall be made in the registry.

# Getting started

The graphical approach to is to open 'regedit.exe'. Administrators can also use 'regquery' or PowerShell to edit the Registry, based on individual comfort level or scripting skill.

All settings shall be placed under the following subdirectory of the Registry:
`[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++]`

All paths mentioned in the official NSClient++ manual start from this Registry location:` [HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++]`

# Allowed hosts

During the installation you had the opportunity to set "allowed host". That setting is located under:
`[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\default]`

Let's say you want change the "allowed host" setting and add the 192.168.1.0/24 net. Then edit the string value "allowed hosts" under `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\default]` so it looks like this:
**String Name:** `allowed hosts`
**String Value:** `127.0.0.1,::1,192.168.1.0/24`

# Logging

In earlier versions it was done in an ini file and it looks like this:
`[/settings/log]`
`file name = nsclient.log`
`level = debug`

But now we will add it into the registry instead.

## Changing log file

In `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\log]` add the following string value:
**String Name:** `file name`
**String Value:** `other_nsclient_log_file.log`

## Turning on debug mode

In `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\log]` add the following string value:
**String Name:** `level`
**String Value:** `debug`

Restart the NSClient++ service when done.

## Log file size

Let's say you have turned on debug log mode. Then the file size will increase faster than normal since a lot more are added to the log file. If you let the log file grow uncontrolled you might even runt out of disk space.

There is one way to change this behavior. NSClient++ have a "truncate log file function" built in. It will take the value of "max size" and when the "max size" is reached the log file will be truncated. Approximately 30% to 50% of the log file will be removed.

To turn on "log rotation" add in `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\log\file]` the following string value:

**String Name:** max size
**String Value:** 1024000

The "String Value" above is in bytes no units are allowed.

# Modules

Let's say that you need to activate the WMI module, which is not activated by default. Then you need to activate the module:
`CheckWMI`

Under `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\modules]` add the following string value:
**String Name:** `CheckWMI`
**String Value:** `1`

# External scripts

All settings for external scrips shall be set under:
`[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\external scripts\scripts]`

Let's say you have written a custom power shell script and want to use it as an external script. The script is called `check_something.ps1`.

1.  Create the following folder:
    `C:\Program Files\NSClient++\scripts\my_scripts`
     
2.  Put the script into the folder you created above
     
3.  Then put a string value under `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\external scripts\scripts]` that looks like this:
    **String name:** `check_something`
    **String Value:** `cmd /c echo scripts\my_scripts\check_something.ps1; exit $LastExitCode | powershell.exe -command -`

When called from the monitor server with check\_nrpe use "`check_something`" as command name for `-c`.

If you want to enable arguments for the external scripts then add the following string value under `[HKEY_LOCAL_MACHINE\SOFTWARE\NSClient++\settings\external scripts\]`
**String Name:** `allow arguments`
**String Value:** `1`

Then if we use the example with "`check_something`" and want to add an argument to the script the string value could look like this:
**String name:** `check_something`
**String Value:** `cmd /c echo scripts\my_scripts\check_something.ps1 $ARG1$; exit $LastExitCode | powershell.exe -command -`

Remember to restart the NSClient++ service when you are done.

# Restarting the NSClient++ service

You can restart the NSClient++ service either from **Services** or on command line with:
`C:\Program Files\NSClient++>nscp service --stop`
`Stopping service.`
`C:\Program Files\NSClient++>nscp service --start`
`Starting NSCP`

# More information

For more settings in NSClient++, please take a look at the official NSClient++ settings documentation:

**Settings –** <http://docs.nsclient.org/0.4.4/manual/settings.html>
**Checks –** <http://docs.nsclient.org/0.4.4/manual/checks.html>
**Scripts –** <http://docs.nsclient.org/0.4.4/howto/external_scripts.html#writing-scripts>

