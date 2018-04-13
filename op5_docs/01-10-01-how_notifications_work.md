# how\_notifications\_work

# About

In the OP5 Monitor user manual we describe some of the basics with notifications. Let us take a closer look at how it really works.

#  When do notifications occur and who gets notified?

 The decision to send out notifications is made in the service check and host check logic. Host and service notifications occur in the following instances:

- When a hard state change occurs. More information on state types and hard state changes can be found [here](http://www.naemon.org/documentation/usersguide/statetypes.html).
  - When a host or service remains in a hard non-OK state and the time specified by the configuration setting *notification\_interval* in the host or service configuration has passed since the last notification was sent out (for that specified host or service).

Each host and service definition has a *contact\_groups* option that specifies what contact groups receive notifications for that particular host or service. Contact groups can contain one or more individual contacts.

When OP5 Monitor sends out a host or service notification, it will notify each contact that is a member of any contact groups specified in the *contact\_groups* option of the service definition. OP5 Monitor realizes that a contact may be a member of more than one contact group, so it removes duplicate contact notifications before it does anything.

The default behavior is if a host has the option *contact\_groups* configured in the host configuration, that or those contact\_groups will receive notifications for the host and the services on the host. There is an exception to this default behavior:

- If a service on a host has the option *contact\_groups* set to a different contact group than the one on the host, the contact group on the host will receive all the notifications, *except* from the service that has a contact group defined.
  - If a service on a hostgroup has the option *contact\_groups* set, only that specific contact group will receive the notification.

Additional information on implied inheritance can be found here: <http://www.naemon.org/documentation/usersguide/objectinheritance.html#implied_inheritance>

# Notification filters

When a notification is about to be sent it has to go through a number of filters before OP5 Monitor can determine whether a notification really is supposed to be sent or not.

|:--|
|**Filter**

**Description**|Program-wide

This tells OP5 Monitor if notifications are turned on or not in a program-wide basis. Program-wide notification settings are managed in Manage -\> Process information.|Service and host filters

- Is the host or service in scheduled downtime or not?
- Is the host or service in a flapping state?
- Do the host or service notification options says that this type of notification is supposed to be sent?
- Are we in the right time period for notifications at the moment?
- Have we already sent a notification about this alert? Has the host or service remained in the same non-OK state that it was when the last notification went out?|Contact filters

- Do the contact notifications options says that this type of notification is supposed to be sent?
- Are we in the right time period for notifications at the moment, according to the notification time period set on the contact?|

# Notification commands

How the notifications are sent is defined in either one of the two files below:

- checkcommands.cfg
- misccommands.cfg

The commands are divided into:

- **host notification commands** -- such as the default 'ping'
- **service notification commands** -- all other service checks running against the host

The notification commands are then using scripts in the same way as the normal check commands does.
 All default scripts shipped with OP5 Monitor is located in:

/opt/monitor/op5/notify

*From the host machine's page in the OP5 web console --*

- **To disable host notifications:** simply toggle the Notifications switch.
- **To disable service notifications:** click on the Options drop-down menu in the upper right and select "Service Operations -\> Disable notifications for all services".

# Notification macros

Many of the arguments sent to the notification commands are macros. The macros are a sort of variables containing a, in most cases, program-wide value. You can read more about macros in the Naemon manual: <http://www.naemon.org/documentation/usersguide/macros.html>

One of the most important macro used with notifications is: `$NOTIFICATIONTYPE$`
 This macro tells you what type of notification that is supposed to be sent. The `$NOTIFICATIONTYPE$` macro can have one of the following values:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p><strong>Notification type</strong></p>
<p><strong>Description</strong></p></td>
<td align="left"><p>PROBLEM</p>
<p>A service or host has just entered (or is still in) a problem state.</p></td>
</tr>
</tbody>
</table>

 The list of macros described in the Naemon manual is very useful when you are working with new notification commands and scripts. That list can be found here:  <http://www.naemon.org/documentation/usersguide/macrolist.html>

# URL in notification email

One part of the notification email is a link back to the OP5 Monitor server that has sent the notification, and the hostname in this link can be configured to something else than the sending servers hostname.

This can be useful if OP5 Monitor is configured for [load-balanced](Load_balanced_monitoring) or [distributed monitoring](Distributed_Monitoring) so notifications can be sent out from different sources, but one of the peers is the preferred system for configuration and for viewing data. This is the recommended way to use load balanced systems. If this setting is configured, the link back to OP5 Monitor in the notification email can be set to always point to one of the load balanced or distributed systems.

The URL back to OP5 Monitor can be configured by creating the file: `/etc/op5/notify.yml` with a hostname different from the systems hostname displayed by setting the following option:

**/etc/op5/notify.yml**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
hostname: master1.op5.com
```

The below example is a notification sent from **master2** **.op5.com** in a load balanced configuration:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
op5 Monitor

Service CUSTOM detected 2016-07-03 16:36:11.
'Certificate Expiration Check' on host 'master01' has passed the CRITICAL threshold.
https://master01.op5.com/monitor/index.php/status/service/master01

Additional info;
CRITICAL - File /opt/plugins/custom/certificate-expire is 21770079 seconds old

Host:    master01
Address: 172.27.0.12
Alias:   OP5 Monitor Server
Status:  UP
Comment: /etc/op5/notify.yml configured on master2
```

The link in the notification email will take you to **master1** to view the problem in more detail.

# Changing "from" in notification e-mail

Notifications are by default sent from the e-mail address "op5monitor" without any domain. The MTA adds the local domain name, which by default is "`@localhost.localdomain`".
 To change the e-mail address that notification are sent from use the --from argument for the notification command, or reconfigure your MTA and hostname in OP5 Monitor to send the message from the correct domain.

 To change the sender e-mail address in the notification command from `op5monitor@localhost.localdomain` to `op5notification@mycompany.com`, do the following:

- Navigate to the check\_command configuration under *Manage -\> Configuration -\> Check Commands*
  - Enter the host notification command "host-notify" in the search box
  - Edit the *command\_line* for the notification command and add: "`--from op5notification@mycompany.com`" without the "-signs.

**Example**:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
command_name=host-notify
command_line=$USER3$/notify/notify --from op5notification@mycompany.com -c "$CONTACTNAME$" -h "$HOSTNAME$" -f "$NOTIFICATIONTYPE$" -m "$CONTACTEMAIL$" -p "$CONTACTPAGER$" "HOSTALIAS=$HOSTALIAS$" HOSTADDRESS=$HOSTADDRESS$" "HOSTSTATE=$HOSTSTATE$" "HOSTSTATEID=$HOSTSTATEID$" "HOSTSTATETYPE=$HOSTSTATETYPE$" "HOSTATTEMPT=$HOSTATTEMPT$" "HOSTLATENCY=$HOSTLATENCY$" "HOSTEXECUTIONTIME=$HOSTEXECUTIONTIME$" "HOSTDURATION=$HOSTDURATION$" "HOSTDURATIONSEC=$HOSTDURATIONSEC$" "HOSTDOWNTIME=$HOSTDOWNTIME$" "HOSTPERCENTCHANGE=$HOSTPERCENTCHANGE$" "HOSTGROUPNAME=$HOSTGROUPNAME$" "HOSTGROUPALIAS=$HOSTGROUPALIAS$" "LASTHOSTCHECK=$LASTHOSTCHECK$" "LASTHOSTSTATECHANGE=$LASTHOSTSTATECHANGE$" "LASTHOSTUP=$LASTHOSTUP$" "LASTHOSTDOWN=$LASTHOSTDOWN$" "LASTHOSTUNREACHABLE=$LASTHOSTUNREACHABLE$" "HOSTOUTPUT=$HOSTOUTPUT$" "HOSTPERFDATA=$HOSTPERFDATA$" "HOSTACKAUTHOR=$HOSTACKAUTHOR$" "HOSTACKCOMMENT=$HOSTACKCOMMENT$" "NOTIFICATIONNUMBER=$NOTIFICATIONNUMBER$" "CONTACTALIAS=$CONTACTALIAS$" "DATETIME=$DATETIME$" "SHORTDATETIME=$SHORTDATETIME$" DATE=$DATE$" "TIME=$TIME$" "TIMET=$TIMET$" "HOSTACTIONURL=$HOSTACTIONURL$" "HOSTNOTESURL=$HOSTNOTESURL$" "ADMINPAGER=$ADMINPAGER$" "ADMINEMAIL=$ADMINEMAIL$" "NOTIFICATIONCOMMENT=$NOTIFICATIONCOMMENT$"
```

To change this for the service notifications, you need to repeat the steps above on the command* *"service-notify" as well.

# Additional Resources

The notifications in OP5 Monitor follows a extensive rule set that is inherited from the core daemon Naemon. More documentation can be found in the [notification documentation for Naemon](http://www.naemon.org/documentation/usersguide/notifications.html)
