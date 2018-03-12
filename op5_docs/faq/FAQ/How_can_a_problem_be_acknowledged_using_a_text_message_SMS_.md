# How can a problem be acknowledged using a text message (SMS)?

## Question

* * * * *

How can a problem be acknowledged using a text message (SMS)?

## Answer

First you need to enable incoming text messages and the event-handler in /etc/smsd.conf.
 Change the setting 'incoming = no' to 'incoming = yes'.
 Add "eventhandler = /opt/monitor/op5/smsreceive/smsreceiver/smsreceiver.php"  In the device section (usually GSM1) and restart the smsd service with 'service smsd restart' on EL6 or 'systemctl restart smsd' on EL7.

When acknowledging a problem via SMS you can use two different approaches.
 Either you just forward (copy-paste) the notification back to the number it came from (called a "dynamic sms") or you manually compose a reply (called "static format").
 Dynamic sms does not support acknowledgement comments.
 If you use the static format, use the following format.
 host ack: 'hostack;host-name;comment'.
 service ack: 'serviceack;host-name;service-description;comment'.

Make sure contact is updated with proper mobile('Pager field in contacts form') number.

 

