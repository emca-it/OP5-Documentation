# Monitoring the hardware of your OP5 server

This how-to describes how to monitor the local hardware of you OP5 server. The method described in this white-paper applies to the following models:

-   PE-860 (a.k.a “entry”, fourth generation)
-   PE-1950 (a.k.a “standard” and “large”, fourth generation)
-   PE-1950-III (a.k.a. “standard” and “large”, fifth generation)
-   PE-R410 (a.k.a. “Standard and large” sixth generation)
-   PE-R210 (a.k.a “Entry” sixth generation)

The method described in this white-paper does not apply to:

-   PE-sc1425 (a.k.a “entry”, third generation)

## **History**

op5′s first and second generation servers used Linux software raid. On these models the status of the raid-mirror was monitored using check\_linux\_raid.

On op5′s third generation “standard” and “large” models (PE-1950, R410) the local hardware was previously monitored using check\_megaraid and check\_ipmi. These plugins should **not be used any more**. Please use the method described below since it offers gives you the possibility to study the health of your server in detail. This way you can for example discover outdated firmware.

Using the web-interface of “Dell OpenManage Server Administrator, provided by the software “Dell OpenManage Server Administrator Managed Node”, a.k.a OMSA, you can also perform some basic tasks like initiating a rebuild of an array.

## **Installing OMSA**

First install the repository configuration file for Dell System Update This requires your server to have http-access to linux.dell.com.

Follow the instructions on this page to install the DSU repository: <http://linux.dell.com/repo/hardware/dsu/>

To perform a minimal install of OMSA (no web-gui) issue the following commands.

    # yum install srvadmin-storageservices srvadmin-base

    # /opt/dell/srvadmin/sbin/srvadmin-services.sh start

To perform a full install (including the OMSA web-gui) issue the following commands. This will download approximately 74 MB of software packages.

    # yum install srvadmin-all
    # /opt/dell/srvadmin/sbin/srvadmin-services.sh start

Auto-start the service on boot:

    # /opt/dell/srvadmin/sbin/srvadmin-services.sh enable

     

The package tog-pegasus may conflict with the packages listed above and can safely be removed:

\# yum remove tog-pegasus

**
**

**Verify SNMP**

Verify that you have SNMP network connectivity on the Monitor-server, and that the Dell openmanage agent is responding:

    # snmpwalk -v 1 -c snmp-community-string op5-monitor-server |head -n20

This should output the first 20 lines of info from the openmanage-storage-agent.

## **Web interface**

If you performed a full install, you can now browse the OMSA web-gui at https port 1311, se example below:

https://your-servers-address:1311/

To login, use the “root”-account of the OP5 Monitor server.

## **Adding services**

When OMSA is installed you need to one service on the host-object for your OP5 server. The required check-command can be imported using the function “Check Command Import” which you’ll find under ‘Configure’ -\> ‘Commands’ -\> ‘Related Items:’.

Add the following service:

option

data

service\_description

Hardware status

check\_command

check\_openmanage

check\_command\_args

snmp\_community

If you performed a full install of ‘OMSA’ you may add the OMSA web-gui as an action\_url which can be found under ‘Extras’ on the service you are about to add. This will give you an easy way to reach the OMSA web-gui directly from the Service information page.

Add the action\_url like this:

option

data

action\_url:

https://\$HOSTADDRESS\$:1311/

 

## **Known issues
**

If you are upgrading to APS 6.4 we recommend that you read this blog post posted by our support team.
[Dell OpenManage checks stops working after upgrading to APS 6.4](http://www.op5.com/blog/support-news/known-issues/dell-openmanage-checks-stops-working-after-upgrading-to-aps-6-4/)

