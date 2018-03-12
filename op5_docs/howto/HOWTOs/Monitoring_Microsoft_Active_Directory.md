# Monitoring Microsoft Active Directory

Microsoft Active Directory is used to share user list, provide single sign on and other central features in large Microsoft based workstation and server networks. Active Directory is Microsoft’s implementation of existing business standards such as LDAP, Kerberos and DNS. The purpose of this article is describing how op5 Monitor can be used to monitor these core features of an Active Directory and make sure that notifications are sent about common errors.

 

## Watch the HOWTO video:

![](images/icons/grey_arrow_down.png)Click to watch monitoring of Microsoft servers with op5 Monitor

 

[![Get Adobe Flash player](https://www.adobe.com/images/shared/download_buttons/get_flash_player.gif)](https://get.adobe.com/flashplayer/)

**Monitoring Microsoft servers with op5 Monitor:**

In this video we will give you a tour on how to setup monitoring on Microsoft Windows, Active Directory and Microsoft hyper-v. op5 monitor provides you with the ability to monitor software in the Microsoft product line, such as Microsoft Windows, SQL Server, Active Directory, IIS and Exchange.

Prerequisites

To be able to complete this how-to you will need the following files:

-   [check\_ad.vbs](http://exchange.nagios.org/components/com_mtree/attachment.php?link_id=2332&cf_id=30)
-   [check\_ad\_time.vbs](http://git.op5.org/gitweb?p=monitor/vbs-plugins.git;a=tree)

*The scripts are not officially supported by op5 Support, but we will help you as good as we can.*

 

## This will be done

**The suggested configuration components for monitoring Active Directory are:**

-   Basic checks for each domain controller
-   Advanced checks for each domain controller
-   Service group called Active Directory that contains all services for your domain controllers.

## Prepare NSClient

-   Copy the two files to C:\\Program Files\\op5\\nsclient++\\scripts
-   Add the following rows to the file C:\\Program Files\\op5\\nsclient++\\custom.ini

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[NRPE Handlers]
check_ad=cscript.exe //T:30 //NoLogo scripts\check_ad.vbs
check_ad_time=cscript.exe //T:30 //NoLogo scripts\check_ad_time.vbs <your.ad.domain> "$ARG1$"
```

1.  -   Save the file
    -   Restart the NSClient++ service

## Check commands

Add the required check-commands, if they don’t already exist in your configuration, add dem via: (‘Configure’ -\> ‘Check Commands’ -\> ‘New command’)

Pre-built management pack

If you don't want to configure the monitoring manually, you can use the pre-built management pack "Microsoft AD server"

 

### Basic commands:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>command_name</strong>
<strong>command_line</strong></td>
<td align="left">*check_ad_time
$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_ad_time -a $ARG1$</td>
</tr>
</tbody>
</table>

### Advanced commands:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>command_name</strong>
<strong>command_line</strong></td>
<td align="left">*check_ad_dcdiag_dc
$USER1$/check_nrpe -H $HOSTADDRESS$ -c check_ad</td>
</tr>
</tbody>
</table>

\* Require changes to NSC.ini, see section below.

\*\* This is just one example of performance counters you might want to monitor, for a full list we sugest you take a look at Microsoft own [reference list](http://technet.microsoft.com/library/Cc960013).

 

Short list of counters we think is good to monitor:

-   “NTDSKerberos Authentications”,”Kerberos Authentications %d times/sec”
-   “NTDSLDAP Bind Time”,”LDAP Bind Time %.2f ms”
-   “NTDSLDAP Client Sessions”,”LDAP Client Sessions: %d”
-   “NTDSNTLM Authentications”,”NTLM Authentications %d times/sec”

### Add the required services

Go to ‘Configure’ -\> ‘Host: \<your-domain-server\>’ -\> ‘Go’ -\> ‘Services for host \<your-domain-server\>’ -\> ‘Add new service’ -\> ‘Go’

 

Add the following services (Arguments are just examples, you need to adjust them to suite your environment).

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>service_description</strong>
<strong>check_command</strong>
<strong>check_commands_args</strong></td>
<td align="left">AD: Domain Time
check_ad_time
0.5</td>
<td align="left">AD: Services
check_nt_service
W32Time,Dnscache,IsmServ,kdc,SamSs,lanmanserver,lanmanworkstation,RpcSs,Netlogon</td>
</tr>
</tbody>
</table>

 

Use the “Test this service” botton for the services to see if they work. Once the are correct and working as they should you may add the services to all of your domain controllers with the clone-function.

 

## Configuring the service group

 

Configuring a service group is not necessary for the monitoring to work, but it will be easier to display the current status on the Active Directory – for instance for help desk staff.

-   From Configure, select Service Groups and add a new service group.
-   Enter a service name and a description (alias) that is suitable for your organization.
-   Hold down the Control key and select the services you wish to include – preferably the services you added in this How-To, and some other important services for the domain controllers:
    -   CPU
    -   Load
    -   Disk usage
    -   Mem usage
    -   PING
    -   Swap usage
    -   Uptime
-   Move the selected services to the selected list.
-   Click on “Apply Changes” and then “Save”.

 

 

