# Monitoring Microsoft clustered servers

Monitoring Microsoft clustered servers requires some extra configuration. This how-to describes how to configure op5 Monitor to monitor drives and win32-services on clustered Windows servers.

## Drives/partitions

Since Drives/partitions in Windows server clusters can failover between the physical servers, the drives need to be checked/monitored via the virtual server names. First you add the virtual servers as new hosts in your configuration. Secondly add services to these new hosts. See example below:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">service_description:
Disk usage Q:</td>
<td align="left">check_command:
check_nt_disk</td>
</tr>
</tbody>
</table>

## Services

In a Windows server cluster the Win32-services are named using the format ‘win-servicename\$virtualhostname’. To monitor these services the \$-sign needs to be escaped in check\_command\_args. See example below:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">service_description:
SQL Server service</td>
<td align="left">check_command:
check_nt_service</td>
</tr>
</tbody>
</table>

 

 

