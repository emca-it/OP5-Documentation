# Monitoring HP printers

HP printers with JetDirect-cards can be monitored using one of two plugins. This article describes both approaches. The status information required is the printers global status.

Different models of HP printers respond in different ways. If the check\_hpjd approach does not work for you, try the other plugin.

# **The check\_hpjd approach**

First add the following check-command, if it’s not already in your check-command-list:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
check_hpjd</td>
<td align="left">command_line:
$USER1$/check_hpjd -H $HOSTADDRESS$ -C $ARG1$</td>
</tr>
</tbody>
</table>

Use the above check-command in a new service-object associated to the host-object representing your HP-printer. See example below:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">service_description:
Printer status</td>
<td align="left">check_command:
check_hpjd</td>
</tr>
</tbody>
</table>

# **The check\_snmp\_printer approach**

First add the following check-command, if it’s not already in your check-command-list:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">command_name:
check_snmp_printer</td>
<td align="left">command_line:
$USER1$/check_snmp_printer -H $HOSTADDRESS$ -C $ARG1$ -P HP</td>
</tr>
</tbody>
</table>

Use the above check-command in a new service-object associated to the host-object representing your HP-printer. See example below:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">service_description:
Printer status</td>
<td align="left">check_command:
check_snmp_printer</td>
</tr>
</tbody>
</table>
