# Nilex Integration How-to

Version

This article was written for version 5.0 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Information in this article is old and can be obsolete, it will be updated and confirmed with newer versions of OP5 Monitor when possible.

 

## Introduction

This integration between OP5 Monitor and Nilex helpdesk system makes it possible to receive notifications in Nilex and create a support ticket from the notification.

 Read more about Nilex here: [http://www.nilex.se](http://www.nilex.se/)

 

## Prerequisites

To be able to complete this how-to you will need:

-   Administrative access to a working Nilex system
-   Root command line access to a running OP5 Monitor
-   Contact Nilex to make sure you have the required api/modules

 

## Create Nilex contact

First you need to create a contact for Nilex. For the sake of this discussion,we’ll pretend it’s called ‘nilex’ in the contact\_name variable in Monitor.

## Export Nilex hosts

Next step is to export a list containing the unique host-id from Nilex

combined with the host\_name variable from Monitor. Assuming hosts arenamed the same everywhere, you should be able to use a function in Nilexfor this purpose.

 The file must be of the format:

``` {style="margin-left: 10.0px;"}
host_name:host_id
```

where host\_name is the host\_name variable from Monitor and where host\_id
is the unique id from Nilex. The file must be placed in the directory
**/opt/monitor/op5/notify/extra\_host\_vars/nilex** and it must be named
host\_id. You will most likely have to create this directory.

 

## Configure notifications

Most of our customers only wish to receive acknowledgement notifications to
their trouble-ticket system and use it as a logbook of what went wrong and
how they fixed it. For this purpose, you’ll need to create a directory named
**/opt/monitor/op5/notify/nilex/skins.mail** and copy the proper skins from
**/opt/monitor/op5/notify/skins.mail** to the aforementioned directory.

 

To only receive acknowledgement notifications, you’ll need to copy**
host.ACKNOWLEDGEMENT** and, if you want service acknowledgements, the
file** service.ACKNOWLEDGEMENT**.

When everything works properly, inventory-info from Nilex will hop up along
with the problem report, assuming you’re watching the info in Nilex, of course.

## Final words

We usually recommend our customers to send notifications directly to the mailaccounts from the Monitor server rather than through the Nilex inventory andtrouble-ticket system. The reason being that the fewer computers involved, theless potential sources of problems.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>Revision and date</strong>
Revision 1<br />2009-08-27</td>
</tr>
</tbody>
</table>


