# SNMP trap notifications

# About

op5 Monitor is shipped with the possibility to send notifications as SNMP traps. To start use the SNMP notifications you need to

-   add a few new commands
-   configure the contacts

**Table of Content**

-   [About](#SNMPtrapnotifications-About)
-   [Adding SNMP notification commands](#SNMPtrapnotifications-AddingSNMPnotificationcommands)
    -   [To add a SNMP notification command](#SNMPtrapnotifications-ToaddaSNMPnotificationcommand)
-   [Configuring the contacts](#SNMPtrapnotifications-Configuringthecontacts)
    -   [To configure the contacts](#SNMPtrapnotifications-Toconfigurethecontacts)

# Adding SNMP notification commands

Here we need to add two commands one for host notifications and one for service notifications.

## To add a SNMP notification command

1.  Login to the op5 Monitor user interface and go to **Configure**.
2.  Click **Commands**.
3.  Add the following new commands with the following settings:
    `command_name host_notify_by_snmp command_line $USER3$/notify/notify_by_snmp.pl -h snmp.trap.host -C SNMPCOMMUNITY  -t nHostNotify "NOTIFICATIONTYPE=$NOTIFICATIONTYPE$"  "NOTIFICATIONNUMBER=$NOTIFICATIONNUMBER$"  "HOSTACKAUTHOR=$HOSTACKAUTHOR$" "HOSTACKCOMMENT=$HOSTACKCOMMENT$"  "HOSTNAME=$HOSTNAME$" "HOSTSTATEID=$HOSTSTATEID$"  "HOSTSTATETYPE=$HOSTSTATETYPE$" "HOSTATTEMPT=$HOSTATTEMPT$"  "HOSTDURATIONSEC=$HOSTDURATIONSEC$" "HOSTGROUPNAME=$HOSTGROUPNAME$"  "LASTHOSTCHECK=$LASTHOSTCHECK$"  "LASTHOSTSTATECHANGE=$LASTHOSTSTATECHANGE$" "HOSTOUTPUT=$HOSTOUTPUT$" `
    **
    **`command_name service_notify_by_snmp command_line $USER3$/notify/notify_by_snmp.pl -h snmp.trap.host -C SNMPCOMMUNITY  -t nSvcNotify "NOTIFICATIONTYPE=$NOTIFICATIONTYPE$"  "NOTIFICATIONNUMBER=$NOTIFICATIONNUMBER$"  "SERVICEACKAUTHOR=$SERVICEACKAUTHOR$"  "SERVICEACKCOMMENT=$SERVICEACKCOMMENT$" "HOSTNAME=$HOSTNAME$"  "HOSTSTATEID=$HOSTSTATEID$" "SERVICEDESCRIPTION=$SERVICEDESCRIPTION$"  "SERVICESTATEID=$SERVICESTATEID$" "SERVICEATTEMPT=$SERVICEATTEMPT$"  "SERVICEDURATIONSEC=$SERVICEDURATIONSEC$"  "SERVICEGROUPNAME=$SERVICEGROUPNAME$"  "LASTSERVICECHECK=$LASTSERVICECHECK$"  "LASTSERVICESTATECHANGE=$LASTSERVICESTATECHANGE$"  "SERVICEOUTPUT=$SERVICEOUTPUT$"`
    Change the following to their correct value, in both commands:
    `snmp.trap.host`
    `SNMPCOMMUNITY`
4.  Click **Apply**.
5.  Click **Save**.

# Configuring the contacts

## To configure the contacts

1.  Login to the op5 Monitor user interface and go to **Configure**.
2.  Either open up an existing contact or create a new one.
3.  Set **host\_notification\_commands** to: host\_notify\_by\_snmp
4.  Set **service\_notification\_commands** to: service\_notify\_by\_snmp
5.  Click **Apply**.
6.  Click **Save**.
     

     

Make sure the contact is a member of the contact\_group is associated with the correct objects.

