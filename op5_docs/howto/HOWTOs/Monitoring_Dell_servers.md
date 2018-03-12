# Monitoring Dell servers

## **Introduction**

Dell server hardware can be remotely monitored via SNMP. The plugin used here comes with the op5 Monitor plugin package as default. To be able to monitor your Dell server you need to have the following installed on the monitored server:

Dell openmanage Server Administrator” (Managed Node), a.k.a ‘OMSA’ \>= 5.1.0

## **Verify OMSA**

First verify that the Dell server your trying to monitor has ‘OMSA’ installed and running. (This may require installation and network security configuration of SNMP in Windows.)
A good test is to browse to <https://dell-server:1311/>

If you don’t have OMSA installed do the following:

### **Linux**

1.  Set up the Dell OpenManage Repository

        # wget -q -O - http://linux.dell.com/repo/hardware/latest/bootstrap.cgi | bash

2.  Install OMSA

        # yum install srvadmin-all

3.  Start OMSA Services.

        # service snmpd restart
        # /opt/dell/srvadmin/sbin/srvadmin-services.sh restart

-   You may want even add this script to your server start, so next time you boot it, start automatically.

-   Run the following command to enable autostart of the service after reboot:

        # /opt/dell/srvadmin/sbin/srvadmin-services.sh enable

     

Corner Cases

On rare occations the snmp daemon won's start due to the package net-snmp is missing. This was encountered on a RHEL 6.4 installation.

If so, just run the following command: "yum install net-snmp"

The package tog-pegasus may conflict with the packages listed above and can safely be removed if not used: "yum remove tog-pegasus"

 

 

## **Windows**

1.  Go to [DELL support](http://support.dell.com/) website -\> click on “Drivers & Downloads” -\> choose your server model (in my case, I selected PowerEdge 2850) -\> choose the operating system -\> scroll-down and expand ‘Systems Management’ -\> Locate ‘OM-SrvAdmin-Dell-Web-WIN\*.exe’ and Click on ‘Download File’.
2.  Install the file you downloaded and follow the wizard.
3.  The OMSA services will start automatically in background.

## **Verify SNMP**

Secondly, verify that you have SNMP network connectivity to the Dell-server from the Monitor-server, and that the Dell openmanage agent is responding:

    # snmpwalk -v 1 -c snmp-community-string dell-server |head -n20

This should output the first 20 lines of info from the openmanage-storage-agent.

If you don’t get answer, you may need to open some ports in the iptables/firewall or stop it.

## **Verify the plugin version**

Make sure that you have the latest version of the plugin. The plugin can be found [here.](http://folk.uio.no/trondham/software/check_openmanage-3.7.9/check_openmanage)

If you are not using the latest version this plugin needs to be downloaded to /opt/plugins/custom

Also the check command needs to be updated. Go to Configure -\> Commands.

    Add a new check command: command_name: check_openmange_new command_line: $USER1$/custom/check_openmanage -H $HOSTADDRESS$ -C $ARG1$ –perfdata –info –state

## **Add the service**

When you have confirmed connectivity from your op5 Monitor server to OMSA you need to add one service on the host-object you want to monitor.
 The required check-command, if not found in the web-config, can be imported using the function “Check Command Import” which you’ll find under ‘Configure’ -\> ‘Commands’ -\> ‘Related Items:’.

Add the following service:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">service_description
Hardware status</td>
<td align="left">check_command
<p>check_openmanage</p></td>
</tr>
</tbody>
</table>

**Note:** If you have update the check\_command, please use check\_openmanage\_new instead.
 If you have a full installation of OMSA you may add a link to the OMSA web-gui as an action\_url which can be found under ‘Extras’ on the service you are about to add. This will give you an easy way to reach the OMSA web-gui directly from the Service information page.

Add the action\_url like this:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">action_url
https://$HOSTADDRESS$:1311/</td>
</tr>
</tbody>
</table>

 

 

Tip

Add a new Dell hardware service group and add your newly created services to the group.

Related article: [Monitoring the hardware of your op5 server](Monitoring_the_hardware_of_your_op5_server)

**
**

**Known issues**

-   If you are upgrading to APS 6.4 we recommend that you read this blog post posted by our support team.[Dell OpenManage checks stops working after upgrading to APS 6.4](http://www.op5.com/blog/support-news/known-issues/dell-openmanage-checks-stops-working-after-upgrading-to-aps-6-4/)
-   On CentOS 6.5 64bit some have reported that when installing the "srvadmin-all" package, it will fail with a dependency error. This will help you get around the error:

    \# yum remove tog-pegasus tog-pegasus-libs

    More information: http://en.community.dell.com/techcenter/systems-management/f/4469/t/19490204.aspx

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

### [Download op5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

