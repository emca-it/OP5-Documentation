# Troubleshooting

## About

In this chapter we will present some debugging tactics to troubleshoot problems in OP5 Monitor.

## Preface

A logfile is a file that records either events that occur in an operating system or other software runs, or messages between different users of a communication software. This information is very useful when you need to troubleshoot. However it might generate a lot of data depending on the configured log level. This text will also cover which logfiles contain which type of information.

We have based the paths presented below on a CentOS 6 installation. There may be differences on CentOS 7, so we are revising as we move the Monitor Appliance to that version.

## Log Files

The tables below show the available modules and their log files.

Note that enabling Reference will add a reference to the concerned file into the log message. Please be aware that this is a costly operation, and that it only applies to configuration files in '`/etc/op5`':

### Authentication

+----------------------------+-------------------------+
| **Monitor Aspect**         | Authentication |
+----------------------------+-------------------------+
| **Module**                 | Auth |
+----------------------------+-------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+-------------------------+
| **Default Logfile Path**   | `/var/log/op5/auth.log` |
+----------------------------+-------------------------+
| **Default Debug Level**    | Error |
+----------------------------+-------------------------+
| **Default Reference**      | True |
+----------------------------+-------------------------+
| **Content**                | PHP errors. |
+----------------------------+-------------------------+

### Business Service

+----------------------------+----------------------------+
| **Monitor Aspect**         | Business Service |
+----------------------------+----------------------------+
| **Module**                 | Synergy |
+----------------------------+----------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+----------------------------+
| **Default Logfile Path**   | `/var/log/op5/synergy.log` |
+----------------------------+----------------------------+
| **Default Debug Level**    | Error |
+----------------------------+----------------------------+
| **Default Reference**      | True |
+----------------------------+----------------------------+
| **Content**                | PHP errors. |
+----------------------------+----------------------------+

+----------------------------+----------------------------------------+
| **Monitor Aspect**         | Business Service |
+----------------------------+----------------------------------------+
| **Module**                 | Synergy |
+----------------------------+----------------------------------------+
| **Log Configuration File** | `/opt/synergy/etc/config.lua` |
+----------------------------+----------------------------------------+
| **Default Logfile Path**   | See Syslog section. |
+----------------------------+----------------------------------------+
| **Default Debug Level**    | See Syslog section. |
+----------------------------+----------------------------------------+
| **Default Reference**      | See Syslog section. |
+----------------------------+----------------------------------------+
| **Content**                | Only on/off configuration available, everything else is managed by syslog-ng. |
+----------------------------+----------------------------------------+

### Configuration

+----------------------------+----------------------------+
| **Monitor Aspect**         | Configuration |
+----------------------------+----------------------------+
| **Module**                 | Nacoma |
+----------------------------+----------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+----------------------------+
| **Default Logfile Path**   | `/var/log/op5/nacoma.log` |
+----------------------------+----------------------------+
| **Default Debug Level**    | Error |
+----------------------------+----------------------------+
| **Default Reference**      | True |
+----------------------------+----------------------------+
| **Content**                | PHP errors. |
+----------------------------+----------------------------+

### GUI

+----------------------------+--------------------------+
| **Monitor Aspect**         | GUI |
+----------------------------+--------------------------+
| **Module**                 | Ninja |
+----------------------------+--------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+--------------------------+
| **Default Logfile Path**   | `/var/log/op5/ninja.log` |
+----------------------------+--------------------------+
| **Default Debug Level**    | Error |
+----------------------------+--------------------------+
| **Default Reference**      | True |
+----------------------------+--------------------------+
| **Content**                | PHP errors. |
+----------------------------+--------------------------+

### HTTP API

+----------------------------+--------------------------+
| **Monitor Aspect**         | HTTP API |
+----------------------------+--------------------------+
| **Module**                 | HTTP API |
+----------------------------+--------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+--------------------------+
| **Default Logfile Path**   | `/var/log/op5/http_api.log` |
+----------------------------+--------------------------+
| **Default Debug Level**    | Error |
+----------------------------+--------------------------+
| **Default Reference**      | True |
+----------------------------+--------------------------+
| **Content**                | PHP errors. |
+----------------------------+--------------------------+

### MayI

+----------------------------+--------------------------+
| **Monitor Aspect**         | MayI |
+----------------------------+--------------------------+
| **Module**                 | MayI |
+----------------------------+--------------------------+
| **Log Configuration File** | `/etc/op5/log.yml` |
+----------------------------+--------------------------+
| **Default Logfile Path**   | `/var/log/op5/mayi.log` |
+----------------------------+--------------------------+
| **Default Debug Level**    | Error |
+----------------------------+--------------------------+
| **Default Reference**      | False |
+----------------------------+--------------------------+
| **Content**                | PHP errors. |
+----------------------------+--------------------------+

### SMS

+----------------------------+--------------------------+
| **Monitor Aspect**         | SMS |
+----------------------------+--------------------------+
| **Module**                 | |
+----------------------------+--------------------------+
| **Log Configuration File** | `/etc/smsd.conf` |
+----------------------------+--------------------------+
| **Default Logfile Path**   | `/var/log/smsd/smsd.log` \ |
| | `/var/log/smsdsmsd_trouble.log` |
+----------------------------+--------------------------+
| **Default Debug Level**    | Notice |
+----------------------------+--------------------------+
| **Default Reference**      | |
+----------------------------+--------------------------+
| **Content**                | `smsd_trouble.log` is only avaialbe if `smart_logging` is enabled. \ |
| | `smart_logging` creates a separate log file for errors for clarity. |
+----------------------------+--------------------------+

### Syslog

+----------------------------+---------------------------------+
| **Monitor Aspect**         | Syslog |
+----------------------------+---------------------------------+
| **Module**                 | |
+----------------------------+---------------------------------+
| **Log Configuration File** | `/etc/syslog-ng/syslog-ng.conf` |
+----------------------------+---------------------------------+
| **Default Logfile Path**   | `/dev/console` \ |
|                            | `/var/log/messages` \ |
|                            | `/var/log/secure` \ |
|                            | `/var/log/maillog` \ |
|                            | `/var/log/spooler` \ |
|                            | `/var/log/boot.log` \ |
|                            | `/var/log/cron` \ |
|                            | `/var/log/kern` |
+----------------------------+---------------------------------+
| **Default Debug Level**    | |
+----------------------------+---------------------------------+
| **Default Reference**      | |
+----------------------------+---------------------------------+
| **Content**                | |
+----------------------------+---------------------------------+

### Distribution, Load Balancing (Merlin)

+----------------------------+----------------------------------------+
| **Monitor Aspect**         | Distribution \ |
|                            | Load Balancing |
+----------------------------+----------------------------------------+
| **Module**                 | Merlin |
+----------------------------+----------------------------------------+
| **Log Configuration File** | `/opt/monitor/op5/merlin/merlin.conf` |
+----------------------------+----------------------------------------+
| **Default Logfile Path**   | `/var/log/op5/merlin/daemon.log` \ |
|                            | `/var/log/op5/merlin/neb.log` |
+----------------------------+----------------------------------------+
| **Default Debug Level**    | Info |
+----------------------------+----------------------------------------+
| **Default Reference**      | |
+----------------------------+----------------------------------------+
| **Content**                | Merlin communication and module logs.  |
+----------------------------+----------------------------------------+

## Log levels

These tables show the logging levels and labels. Each level will automatically include all less granular levels. That is: if the debug level is set to Warning, then Warning, Error, and Critical events will all be logged.

### log.yml

| Level | Label | Description |
| ----- | ------- | ---------------------------------- |
| 1 | Error | Errors that have already occurred |
| 2 | Warning | Potentially harmful situations |
| 3 | Notice | Informational message |
| 4 | Debug | Fine-grained informational events |

### smsd.log
| Level | Label | Description |
| ----- | -------- | -------------------------------------------------- |
| 7 | Debug | All AT commands and modem answers and other detailed information useful for debugging |
| 6 | Info | Information regarding current occurrences. Not detailed enough for debugging but maybe interesting |
| 5 | Notice | Information regarding when a message was received or sent and when something not normal happens but program still works fine (for example wrong destination number in SMS file) |
| 4 | Warning | Warning message when the program has a problem sending a single short message |
| 3 | Error | Error message when the program has temporary problem (for example modem answered with ERROR during initialization or a file can not be accessed) |
| 2 | Critical | Error message when the program has a permanent problem (for example sending failed on multiple occurrences or wrong permissions to a queue) |

### syslog-ng

| Level | Label | Description |
| ----- | -------- | -------------------------------------------------- |
| 0 | emerg | System is unusable |
| 1 | alert | Action must be taken immediately |
| 2 | crit | Critical conditions |
| 3 | err | Error conditions |
| 4 | warning | Warning conditions |
| 5 | notice | Normal but significant condition |
| 6 | info | Informational |
| 7 | debug | Debug-level messages

## Examples

### Business Services

The two most significant configuration files to manage logging for business services: '/etc/op5/log.yml' and '/opt/synergy/etc/config.lua'.

**Synergy default in '/etc/op5/log.yml'**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
...
synergy:
  file: /var/log/op5/synergy.log
  level: error
  reference: true
...
```

To change from default to debug, edit '/etc/op5/log.yml' as follows:

**Synergy debug logging for '/etc/op5/log.yml'**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
...
synergy:
  file: /var/log/op5/synergy.log
  level: debug
  reference: true
...
```

Default configuration for /opt/synergy/etc/config.lua:

**Synergy default in '/opt/op5/etc/config.lua'**

``` {.lua data-syntaxhighlighter-params="brush: lua; gutter: false; theme: Confluence" data-custom-language-resource="com.atlassian.confluence.ext.code.custom.Custom.3687113735111001413:custom-code-syntax-resources" data-theme="Confluence" style="brush: lua; gutter: false; theme: Confluence"}
...
     -- If true logs debugging to syslog
    debug = false,
...
```

 Open '`/opt/synergy/etc/config.lua`' in any editor and change the settings to:

**Synergy debug settings in '/opt/synergy/etc/config.lua'**

``` {.lua data-syntaxhighlighter-params="brush: lua; gutter: false; theme: Confluence" data-custom-language-resource="com.atlassian.confluence.ext.code.custom.Custom.3687113735111001413:custom-code-syntax-resources" data-theme="Confluence" style="brush: lua; gutter: false; theme: Confluence"}
...
     -- If true logs debugging to syslog
    debug = true,
...
```

If you would like to change the default syslog-ng log levels, edit '`/`etc/syslog-ng/syslog-ng.conf'. Caveat: this requires a deeper understanding of syslog-ng's filters than this document can cover.

Restart synergy and syslog-ng:

    service synergy restartservice syslog-ng restart

Remember to restore the original settings and restart the services when you no longer need to troubleshoot.
