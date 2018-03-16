# Monitoring and graphing Windows performance counters

This how-to covers how to monitor and graph a Windows performance counter in OP5 Monitor and OP5 Statistics.

op5 Statistics is considered deprecated software and is not supported.

 

## **Monitoring the performance counter**

In perfmon, select a performance counter that you want to monitor and/or graph. In this example we monitor and graph the following performance counter:

Performance object: Terminal Services Session
 Instance: Console
 counter: Thread Count

Request the counter-value from command-line to verify access and to examine the returned data:

    # /opt/plugins/check_nt -H 192.168.1.8 -v COUNTER -l "Terminal Services Session(Console)Thread Count"

    20

(in this example the returned value is an integer with a value of 20)

To monitor this counter in OP5 Monitor, just add the following check-command and service:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
check_nt_tsc_threadcount</td>
<td align="left">command_line:
$USER1$/check_nt -H $HOSTADDRESS$ -v COUNTER -l “Terminal Services Session (Console) Thread Count”,”TS Console Thread Count is: %.f” -w $ARG1$ -c $ARG2$</td>
</tr>
</tbody>
</table>

## **Graphing the performance counter**

To graph this counter in OP5 Statistics, follow the steps below. Some of the steps can be performed faster using the duplicate function which is available for Data Templates, Graph Templates and Host Templates. This guide will however cover how to manually add new templates from scratch.:

1. If you haven’t already added the host, for which you want to create graphs, to Statistics device-list, export the device from Monitor webconfig:
 ‘Configure’ -\> ‘Export hosts to statistics’:
 remove SNMP Community string (if you haven’t enabled/configured an SNMP agent in the windows-server)
 select Host template “Windows NSClient”
 select the host(s) you want to export
 click ‘Export hosts’

2. Create a copy of an existing script and set the correct owner/group/permissions:

    # cd /opt/statistics/scripts
    # cp check_nt_cpu.sh check_nt_tsc_threadcount.sh
    # chown stats:apache check_nt_tsc_threadcount.sh
    # chmod 755 check_nt_tsc_threadcount.sh

3. Edit the new script and replace the command with the one you created in your command-line test(se above). Replace ‘-H \$HOSTADDRESS\$’ with ‘-H \$1′, see example below:

    # /opt/plugins/check_nt -H $1 -v COUNTER -l "Terminal Services Session(Console)Thread Count"

4. Test-run your script at command-line, as the ‘stats’ user, against your windows-server:

    # su - stats
    # /opt/statistics/scripts/check_nt_tsc_threadcount.sh 192.168.1.8

(The test should return /only/ the value you want to collect)

5. Add a new Data Input Method:
 Name: Windows NSClient – TS Console threadcount
 Input Type: Script/Command
 Input String: /bin/sh \<path\_cacti\>/scripts/check\_nt\_tsc\_threadcount.sh \<ip\>
 click ‘create’

Add Input/Output Fields to your new Data Input Method:

Field [Input]: IP
 Friendly Name: Host Address
 Special Type Code: hostname
 click ‘create’

Field [Output]: threads
 Friendly Name: Terminal Services Console threadcount

Finally ‘save’ your new Data Input Method

6. Add a new Data Template:
 Data Templates
 Name: Windows NSClient – Terminal Services Console threadcount
 Data Source
 Name: |host\_description| – Terminal Services Console threadcount
 Data Input Method: Windows NSClient – TS Console threadcount
 Data Source Item
 Internal Data Source Name: TSCthreadcount
 click ‘create’

7. Add a new Graph Template:
 Template
 Name: Windows – TS Console threadcount
 Graph Template
 check ‘title’ checkbox and set to: |host\_description| – TS Console threadcount
 check checkbox ‘Rigid Boundaries Mode’ (the right checkbox, not the left one)
 Vertical Label: threads
 click ‘create’

Add Graph Template Items
 Item \# 1:
 Data Source: Windows NSClient – Terminal Services Console threadcount – (TSCthreadcount…
 select color
 Graph Item Type: AREA
 Text Format: threadcount
 Item \# 2:
 Graph Item Type: GPRINT
 Consolidation Function: LAST
 GPRINT Type: Exact Numbers
 Text Format: Current:
 Item \# 3:
 Graph Item Type: GPRINT
 Consolidation Function: AVERAGE
 GPRINT Type: Exact Numbers
 Text Format: Average:
 Item \# 4:
 Graph Item Type: GPRINT
 Consolidation Function: MAX
 GPRINT Type: Exact Numbers
 Text Format: Maximum:

finally ‘save’ your new Graph Template

8. Associate your new Graph Template with the device/host for which you want to create the graph. (If you want to create the graph for a large number of hosts you can instead associate the Graph Template with an existing (or new) Host Template)

9. Create your new graph using the link ‘Create Graphs for this Host’ in the Device properties page.

10. Add your new graph (or the host) to the Graph Tree

11. Wait and see. Within 15 min (3 polls) you should be able to se current values in your graph. The AREA should also begin to plot after 15 min.**
**

 

 

