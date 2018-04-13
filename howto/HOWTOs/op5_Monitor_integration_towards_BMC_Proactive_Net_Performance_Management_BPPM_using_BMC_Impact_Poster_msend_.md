# OP5 Monitor integration towards BMC Proactive Net Performance Management (BPPM) using BMC Impact Poster (msend)

This document describes how to integrate OP5 Monitor to BMC Proactive Net Performance Management (BPPM) using BMC Impact Poster (msend). It requires configuration to be added on the receiving end and these steps are not covered in this how-to

## **Files needed**

Attachment: [msend](attachments/688567/1310727) is installed in /opt/plugins/custom

Attachment: [monitor\_msendwrapper.pl](attachments/688567/1310726.pl) is installed in /opt/plugins/custom

## **Commands**

The commands needed in OP5 Monitor are added to /opt/monitor/etc/misccommands.cfg:

**/opt/monitor/etc/misccommands.cfg**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# command 'host-msend-to-bem'
define command{
command_name host-msend-to-bem
command_line ( /opt/plugins/custom/monitor_msendwrapper.pl "op5_origin=`hostname`" "op5_time='$TIME$'" "op5_host='$HOSTNAME$'" "op5_host_alias='$HOSTALIAS$'" "op5_host_address='$HOSTADDRESS$'" "op5_host_message='$HOSTOUTPUT$'" "op5_host_group='$HOSTGROUPNAME$'" "op5_host_severity='$HOSTSTATE$'" "op5_host_statetype='$HOSTSTATETYPE$'" "op5_host_attempt='$HOSTATTEMPT$'" "op5_host_latency='$HOSTLATENCY$'" "op5_host_exectime='$HOSTEXECUTIONTIMETIONTIME$'" "op5_host_duration='$HOSTDURATION$'" "op5_host_notesurl='$HOSTNOTESURL$'" "op5_host_actionurl='$HOSTACTIONURL$'" ) &
}
# command 'service-msend-to-bem'
define command{
command_name service-msend-to-bem
command_line ( /opt/plugins/custom/monitor_msendwrapper.pl "op5_origin=`hostname`" "op5_time='$TIME$'" "op5_host='$HOSTNAME$'" "op5_host_alias='$HOSTALIAS$'" "op5_host_address='$HOSTADDRESS$'" "op5_notification_type='$NOTIFICATIONTYPE$'" "op5_service_desc='$SERVICEDESC$'" "op5_service_state='$SERVICESTATE$'" "op5_service_last_statechange='$LASTSERVICESTATECHANGE$'" "op5_service_message='$SERVICEOUTPUT$'" "op5_host_state='$HOSTSTATE$'" "op5_service_latency='$SERVICELATENCY$'" "op5_service_exectime='$SERVICEEXECUTIONTIME$'" "op5_host_notesurl='$HOSTNOTESURL$'" "op5_host_actionurl='$HOSTACTIONURL$'" "op5_service_actionurl='$SERVICEACTIONURL$'" "op5_service_notesurl='$SERVICENOTESURL$'" ) &
}
```

Classes specified are in 1:1 relation to the information included in a regular email-notification by default. It's easy to expand the commands above with other classes documented in the official msend documentation to include a lot more info if needed. We have an "extended" version which utilizes all available classes in Monitor to be submitted to BPPM but should only be used if the standard commands lacks information needed as it adds overhead to the call.

## **Contacts**

To use these commands you need to specify a contact much like when sending emails or text-messages and if needed added to a contact-group for example the default contact-group "support-group" which are used in templates so all hosts and services will be enabled at once. The contact set up in this specific case is named "msend-to-bem" and are a member of support-group, host\_notification\_command is set to host-msend-to-bem and service\_notifcation\_command is set to service-msend-to-bem

Further information about configure these commands and other useful information about OP5 Monitor please visit our online manual.

## **Configuration for msend**

Are specified directly in monitor\_msendwrapper.pl and take special notice of "COMMANDLINE="-n @bmcis02:1828\#mc -a OP5\_EVENT -b " which are specific to this environment.

## **Testing**

Manual tests without the use of the wrapper can be done using this line: /opt/plugins/custom/msend -n bmcis02 -n @bmcis02:1828\#mc -a OP5\_EVENT -m "testing as monitor user" and the result/connectivity could be verified on the receiving end.

To test the wrapper, uncomment the line in monitor\_msendwrapper.pl: \#\`echo "\$MSEND" "\$COMMANDLINE" "\$ARGS" \>\> /tmp/msend.log\`; and manually execute the script. The log will show the actual command that will be used but no classes. To also expand classes and macros OP5 Monitor must be running the script as a notification command. (Unless manually create a script setting these variables)

To test the full command and classes/macros have the line in monitor\_msendwrapper.pl un-commended as stated above and trigger a event in OP5 Monitor (ex use passive check-results) and take a look in mend.log. In this case nothing has been sent to BPPM only logged to this file. To test this for real comment out the line and make sure the last line in the script is uncommented. Verify on BPPM side what info gets sent.

Successful test should produce a line in msend.log looking something like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/plugins/custom/msend -n BMCIS02 -n @bmcis02:1828#mc -a OP5_EVENT -b "op5_host_duration='0d 0h 0m 0s';op5_host_exectime='0.000';op5_host_latency='0.553';op5_host_attempt='1';op5_host_statetype='HARD';op5_host_severity='UP';op5_host_group='servers';op5_host_message='testing';op5_host_address='dev-mon.int.op5.se';op5_host_alias='Jboss Application Server';op5_host='application-server';op5_date='1350571017';op5_origin=demo;op5_host_notesurl='/dokuwiki/doku.php/hosts/application-server'"
```

## **Future**

To be able to use the full functionality of msend capabilities such as buffering of events and heartbeat submission to BPPM requires further configuration. To date no such information are available so documentation is lacking this information but will be completed when and if this will be added.

## **Other documentation resources**

<http://www.op5.com/manuals/> contain all nescessary information on how to configure commands, contacts and what/when to notify on events and much more.
