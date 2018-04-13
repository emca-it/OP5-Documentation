# Delayed notifications

Version

This article was written for version 6.3.2 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 support, and this article in particular is written as a Proof of Concept.

We have had a few inquiries on how to queue up notifications for certain hosts during off-hours, and then batch-send these notifications at the beginning of the day. This document will describe one approach on how to accomplish this by using a few simple scripts and a special contact that spools notifications to file for postponed processing.

For the purpose of explaining the logic behind this, we will use a host called **host1**. This host has two contacts (**admin1** and **admin2**) who does not wish to receive notifications during the night, but they still want to get alerted of things that happened during the night when they arrive at the office 08:00. So, since these contacts do not wish to be disturbed during non-workhours, they have been assigned the *timeperiod ***workhours** which stretches from 08:00:00-16:59:59. To catch all the notifications outside work hours, we create a new contact called **nightwatch** and we assign the *timeperiod* **nonworkhours** which stretches from 17:00:00-07:59:59 to it. We will also make use of the fields called *host\_notification\_cmds\_args* and *service\_notification\_cmds\_args *that we will set to the time when we want the notifications to be sent out, which in this case is 08:00.

What will happen during the night is that the **nightwatch** will receive all notifications for alerts on the host, and the customised notification commands for this contact will write notifications to a spool directory instead of sending them as emails or sms. This spool directory is processed by a cron job that runs a script and checks if there are any spooled notifications that should be processed and sent. If there is, the script will read the notification information in the file, and then send it as a *Custom notification* through the Nagios command pipe, notifying all contacts on the host. Due to allowing Nagios to determine who will be notified, it is very important that the **nightwatch **contact does not have a *timeperiod* that overlaps with the normal contacts on the host, since this would create a notification loop where it writes the delayed notifications to itself again, while also making sure that the time specified in the *notification\_cmds\_args *fall within the *timeperiod* of **admin1** and **admin2** who are to receive the delayed notifications.

The scripts to use can be downloaded [here](attachments/9930223/10191357.gz). (wget/curl-friendly link: <https://download.op5.com/dj/delayed_notify.tar.gz>) They should be unpacked and placed in **/opt/plugins/custom** and be owned by monitor:apache, and must be made executable for everyone. In addition, you need to create the following directory, which should be owned by monitor: **/opt/monitor/var/spool/notify\_delay **and you must also create a cron job for either root or monitor looking like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
*/5 * * * *   /opt/plugins/custom/process_spool_queue.pl
```

The steps above need to be performed on all peers and pollers that will be involved in using the delayed notification feature.

When the scripts are in place, you should create two new *Commands* for delayed host- and service-notifications in OP5 Monitor:

Command

Value

host-notify-delay

\$USER1\$/custom/notify\_delay\_spool.pl "SEND=\$ARG1\$" "CONTACTNAME=\$CONTACTNAME\$" "HOSTNAME=\$HOSTNAME\$" "NOTIFICATIONTYPE=\$NOTIFICATIONTYPE\$" "SHORTDATETIME=\$SHORTDATETIME\$" "HOSTOUTPUT=\$HOSTOUTPUT\$" "HOSTSTATE=\$HOSTSTATE\$"

service-notify-delay

\$USER1\$/custom/notify\_delay\_spool.pl "SEND=\$ARG1\$" "CONTACTNAME=\$CONTACTNAME\$" "HOSTNAME=\$HOSTNAME\$" "NOTIFICATIONTYPE=\$NOTIFICATIONTYPE\$" "SERVICEDESC=\$SERVICEDESC\$" "SHORTDATETIME=\$SHORTDATETIME\$" "SERVICESTATE=\$SERVICESTATE\$" "SERVICEOUTPUT=\$SERVICEOUTPUT\$"

Create the **nightwatch** contact:

Parameter

Value

    contact_name

    nightwatch

    host_notification_period

    nonworkhours

    service_notification_period

    nonworkhours

    host_notification_cmds

    host-notify-delay

    host_notification_cmds_args

    08:00

    service_notification_cmds

    service-notify-delay

    service_notification_cmds_args

    08:00

So, the chain of events in case of a notification for **host1** being sent during the night will be as follows:

1. The notification will be issued for the contact **nightwatch** since that is the only contact on the host with a *timeperiod* matching the current time.
2. The host-notify-delay command for **nightwatch** will write the notification to a spool file, with some notification information, and the parameter SEND=08:00 at the start of the file.
3. When the cron job kicks in at 08:00, it will read the notification file in the spool directory, and since the current time matches the SEND=08:00 in the file, it will issue a *Custom host notification* to all contacts on the host with a *timeperiod* matching the current time, which means that **admin1** and **admin2** will receive one notification each, since 08:00 falls within the **workhours** *timeperiod,* while **nightwatch** will not get it due to **nonworkhours** ended at 07:59:59.

The notification to **admin1** and **admin2** will then include the original alert message as a comment:

*Host: host1*
*Address: 127.0.0.1*
*Alias: host1*
*Status: UP*
***Comment: Original alert: [2014-07-11 07:44:07] host1 DOWN: 10.0.0.1 is DOWN - rta: nan, lost 100%***
