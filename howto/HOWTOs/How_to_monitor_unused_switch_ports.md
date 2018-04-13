# How to monitor unused switch ports

## **Introduction**

This guide will describe how to use OP5 Monitor to keep track of unused switch ports on your network.

## **Prerequisites**

Before you start please make sure of the following:

- OP5 Monitor is installed
- you have SNMP access from the OP5 Monitor server to the switch(es) you would like to monitor

## **Adding the command**

To add the new command:

1. Open up the OP5 Monitor configuration tool and click "**Commands**".
2. Add a new check command with the following data:

        command_name  check_portstatus

        command_line  $USER1$/check_portstatus -H $HOSTADDRESS$ -C $ARG1$ -v $ARG2$ -w $ARG3$ -c $ARG4$

3. Click **Apply.**

## **Adding the service**

To add the new service:

1. Open up the OP5 Monitor configuration tool.
2. Pick up the host you like to add the service to and click "**Services for this host**"
3. Add a new service like this

        Service description  Port status

        check_command        check_portstatus

        check_command_args   snmpcommunity!1!10!5

4. Click **Apply.**
5. Click **Save.**

## **View the result**

On the **Service information** page you can find the status output for this service. It looks like this:

    OK: 49 of 52 ports available, 1 down, click here to view the report.

From here you can view a report showing all ports on the host. In the report you can see the port

- description
- state
- speed
- idle time

To view the report click on the **click here to view the report** link.

## Comments:

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>Could be useful to paste either a link or a screenshot to the post....</p>
<p>example <a href="https://demo.op5.com/monitor/op5/portstatus/portstatus.php?hosts=192.168.1.18">https://demo.op5.com/monitor/op5/portstatus/portstatus.php?hosts=192.168.1.18</a></p>
<p>or the <a href="https://demo.op5.com/monitor/index.php/listview?q=%5Bservices%5D%20description%20~~%20%22ports%22%20or%20display_name%20~~%20%22ports%22%20or%20host.name%20~~%20%22ports%22%20or%20host.address%20~~%20%22ports%22%20or%20host.alias%20~~%20%22ports%22%20or%20plugin_output%20~~%20%22ports%22">overview&gt;&gt;</a></p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by janj at Aug 29, 2013 09:12</td>
</tr>
</tbody>
</table>
