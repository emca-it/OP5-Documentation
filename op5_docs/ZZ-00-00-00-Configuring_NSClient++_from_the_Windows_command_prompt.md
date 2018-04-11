# Configuring NSClient++ from the Windows command prompt

Version

This article was written for version 0.5.x of NSClient++. Versions 0.3.x and earlier of NSClient++ did not rely on the Windows Registry as heavily, so these notes would not apply. These instructions should work on later versions unless otherwise noted.

Only for NSClient++ \>= 0.5.x

**Due to a [bug](https://github.com/mickem/nscp/issues/227) in NSClient++ in 0.4 you should not use anything else than 0.5 or later when handling configuration in this way.**

 

-   [About the document](#ConfiguringNSClient++fromtheWindowscommandprompt-Aboutthedocument)
-   [Listing settings](#ConfiguringNSClient++fromtheWindowscommandprompt-Listingsettings)
-   [Change settings](#ConfiguringNSClient++fromtheWindowscommandprompt-Changesettings)
-   [Allowed hosts](#ConfiguringNSClient++fromtheWindowscommandprompt-AllowedhostsAllowed_hosts)
-   [Turning on debug logging](#ConfiguringNSClient++fromtheWindowscommandprompt-TurningondebugloggingTurning_on_debug_logging)
-   [Modules](#ConfiguringNSClient++fromtheWindowscommandprompt-Modules)
-   [Fetch configuration from HTTP server](#ConfiguringNSClient++fromtheWindowscommandprompt-FetchconfigurationfromHTTPserverFetch_configuration_from_HTTP_server)
-   [Examples](#ConfiguringNSClient++fromtheWindowscommandprompt-Examples)
    -   [Allow arguments for the NRPE server](#ConfiguringNSClient++fromtheWindowscommandprompt-AllowargumentsfortheNRPEserver)
    -   [Allow nasty characters as arguments for the NRPE server](#ConfiguringNSClient++fromtheWindowscommandprompt-AllownastycharactersasargumentsfortheNRPEserver)
    -   [Allow arguments for external scripts](#ConfiguringNSClient++fromtheWindowscommandprompt-Allowargumentsforexternalscripts)
    -   [Add an external script](#ConfiguringNSClient++fromtheWindowscommandprompt-Addanexternalscript)
-   [More information](#ConfiguringNSClient++fromtheWindowscommandprompt-Moreinformation)

# About the document

There are a couple of methods you can use to configure NSClient++. In this document we will take a look at how you do it by using the nscp command.

Before you start open up a cmd window and navigate to C:\\Program Files\\NSClient++

# Listing settings

You can chose between list all settings or just a sub path.

**List all settings configured "outside" the defaults:**

    C:\Program Files\NSClient++>nscp settings --list

**List a sub path (/settings/log):**

    C:\Program Files\NSClient++>nscp settings --list --path /settings/log

# Change settings

Let's say you want to check the settings of the "allow nasty characters" for the NRPE server module and then disable it.

1.  First check the setting:
    `C:\Program Files\NSClient++>nscp settings --list --path /settings/NRPE/server --key "allow nasty characters"`
    `/settings/NRPE/server.allow arguments=true`
    `/settings/NRPE/server.allow nasty characters=true`
2.  Update the "allow nasty characters" for the NRPE server module with the new value
3.  `C:\Program Files\NSClient++>nscp settings --path /settings/default --key "allow nasty characters" --set false`
4.  Restart nscp with:
    `C:\Program Files\NSClient++>nscp service --stop`
    `Stopping service.`
    `C:\Program Files\NSClient++>nscp service --start`
    `Starting NSCP`

# Allowed hosts

In NSClient++ there are two levels where you can set which server is allowed to talk to NSClient++ on the monitored Windows server.

-   Global
-   NSClient/server
-   NRPE/server

**To check the settings:**

    C:\Program Files\NSClient++>nscp settings --list --path /settings/defaultC:\Program Files\NSClient++>nscp settings --list --path /settings/NRPE/serverC:\Program Files\NSClient++>nscp settings --list --path /settings/NSClient/server

The most common way to solve this is to sett "allowed hosts" for both NRPE and NSClient like this:

    C:\Program Files\NSClient++>nscp settings --path /settings/default --key "allowed hosts" --set "127.0.0.1,::1,172.27.86.0/24,10.10.10.0/24,192.168.1.0/24"

You might not want to allow connections via NRPE (check\_nrpe on the Monitor server) then set:

    C:\Program Files\NSClient++>nscp settings --path /settings/NRPE/server --key "allowed hosts" --set "127.0.0.1,::1,172.27.86.0/24,10.10.10.0/24,192.168.1.0/24"

Do not forget to restart the NSClient++ service when done:

Restart nscp with:
`C:\Program Files\NSClient++>nscp service --stop`
`Stopping service.`
`C:\Program Files\NSClient++>nscp service --start`
`Starting NSCP`

# Turning on debug logging

Please keep in mind that when you are using debug logging with NSClient++ the log file will grow pretty fast. By default there are no rotation of the log files but in this section we will add a sort of rotating of the log file.

If done in an ini file it looks like this:

    [/settings/log]file name = nsclient-debug.loglevel = debug

    [/settings/log/file]; Set log file size to 1Gb specified in bytes:max size = 1073741824

But now we will add it via cmd instead

1.  First check the current log level:
    `C:\Program Files\NSClient++>nscp settings --list --path /settings/log`
2.  Set log file name:
    `C:\Program Files\NSClient++>nscp settings --path /settings/log --key "file name" --set "nsclient-debug.log"`
3.  Set the log level:
    `C:\Program Files\NSClient++>nscp settings --path /settings/log --key "level" --set "debug"`
4.  Set rotation after 1Gb:
    `C:\Program Files\NSClient++>nscp settings --path /settings/log/file --key "max size" --set "1073741824"`
5.  Let's check the new settings:
    `C:\Program Files\NSClient++>nscp settings --list --path /settings/log`
    `/settings/log/file.max size=1073741824`
    `/settings/log.file name=nsclient-debug.log`
    `/settings/log.level=debug`
6.  Restart nscp with:
    `C:\Program Files\NSClient++>nscp service --stop`
    `Stopping service.`
    `C:\Program Files\NSClient++>nscp service --start`
    `Starting NSCP`

# Modules

Let's say that you need to activate a module that is not activated by default. Then you can of course do that with "nscp settings". This time you want to make it possible to use the "WMI interface" in NSClient++ then you need to activate the module:
CheckWMI

1.  First let's list all active modules:
    `C:\Program Files\NSClient++>nscp settings --list --path /modules`
2.  This is done with the following command:
    `C:\Program Files\NSClient++>nscp settings --activate-module CheckWMI --add-defaults`
3.  Restart nscp with:
    `C:\Program Files\NSClient++>nscp service --stop`
    `Stopping service.`
    `C:\Program Files\NSClient++>nscp service --start`
    `Starting NSCP` 

# Fetch configuration from HTTP server

In NSClient++ you have the possibility to fetch the configuration from a remote HTTP server. This means you can setup a central configuration site for all your NSClient++ installations. NSClient++ will periodically check for updates of the ini file you have pointed out.

Attention!

This only works with HTTP, not over HTTPS so the configuration update can be a security risk.

First thing to do before we change the settings of NSClient++ on a Windows server we need to place a configuration file on a web server. In this example we have placed it here:

<http://10.10.10.4/nsclient/nsclient.ini>

Now we will switch to the new configuration file:

1.  Update the settings:
    `C:\Program Files\NSClient++>nscp settings --switch http://10.10.10.4/nsclient/nsclient.ini`
2.  Restart nscp with:
    `C:\Program Files\NSClient++>nscp service --stop`
    `Stopping service.`
    `C:\Program Files\NSClient++>nscp service --start`
    `Starting NSCP```

If the web server for some reason will be come unreachable NSClient will be using the latest version of the settings it has been downloaded.

To swich back to using the local registry

1.  Update the settings:
    `C:\Program Files\NSClient++>nscp settings --switch registry`
2.  Restart nscp with:
    `C:\Program Files\NSClient++>nscp service --stop`
    `Stopping service.`
    `C:\Program Files\NSClient++>nscp service --start`
    `Starting NSCP`

 

# Examples

Below you will find examples of how what can be done. Remember to restart the NSClient++ service after you have changed the configuration.

## Allow arguments for the NRPE server

    C:\Program Files\NSClient++>nscp settings --path /settings/NRPE/server --key "allow arguments" --set true

## Allow nasty characters as arguments for the NRPE server

    C:\Program Files\NSClient++>nscp settings --path /settings/NRPE/server --key "allow nasty characters" --set true

## Allow arguments for external scripts

    C:\Program Files\NSClient++>nscp settings --path "/settings/external scripts" --key "allow arguments" --set true

## Add an external script

**Without arguments:**

`C:\Program Files\NSClient++>nscp settings --path "/settings/external scripts/scripts" --key "test_ps1" --set "cmd /c echo scripts\check_test.ps1; exit($lastexitcode) | powershell.exe -command -"`

With arguments:

`C:\Program Files\NSClient++>nscp settings --path "/settings/external scripts/scripts" --key "test_ps1" --set "cmd /c echo scripts\check_test.ps1 "--argument" "$ARG1$" --foo --bar; exit($lastexitcode) | powershell.exe -command -`"

# More information

For more settings in NSClient++ please take a look at the official NSClient++ settings documentation:
<https://docs.nsclient.org>

