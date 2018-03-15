# Receiving SNMP traps with op5 Monitor

This article remains for historical reference, to handle traps in later versions of op5 Monitor see: [op5 Trapper Home](https://kb.op5.com/display/DOC/op5+Trapper)

 

Virtually all networked equipment can be monitored with SNMP. When you know a specific value that you want to check, you use check\_snmp and specify the OID for that value.

Sometimes, though, you want to look into the SNMP traps that the host sends – these are often a compilation of possible faults initially selected by the manufacturer, and as such they often provide important details about the hardware or software health.

op5 Monitor has built-in functionality to deal with SNMP traps, and getting started is often much easier than one might think.

This article describes how to set up the general support for SNMP traps. If you have a specific application you might want to discuss this further with us at [op5 Support](http://www.op5.com/support/) – for instance we do have specific support for IBM Director and Cisco Works.

# Concept

In order to monitor SNMP traps sent from a host you need to arrange the following:

-   Enable SNMP traps to be sent to the monitor server from the monitored host
-   Make sure that no firewalls block the SNMP traps ( 162/udp )
-   Create one or more services in op5 Monitor web GUI to search the trap logs

# Configuring the monitored host

You need to enable SNMP traps on the host you wish to monitor, and configure it to send these to the op5 Monitor server.

Exactly how this is done depends on the device itself. Most “black boxes” such as routers, switches, printers etc have a distinct configuration utility – such as a web page or a telnet interface.

If you wish to enable traps from an application that run on a standard operating system such as GNU/Linux, Solaris or Windows you will need to configure the application itself.

The monitor server does not need any initial configuration to receive traps – snmptrapd is enabled by default and properly configured.

# Configuring services in op5 Monitor

When traps are received, they will be placed in a log file that is accessible through the web server, on the format https://servername/logs/172.16.45.3\_\_snmptraps.log where the IP address is that of the trapping host and server name is that of your op5 Monitor server.

The typical concept is searching these files for new traps that match a certain keyword search. There is a predefined check command for this, called check\_log\_snmptraps. It takes the keyword as an argument but figures out what file to search for by itself, provided that you have configured hosts using the IP address and not DNS name in Monitor.

For instance, if you are interested in traps regarding your RAID, it might be a good idea to set up a service searching for the keyword RAID.

Do so by adding the service, choose check\_log\_snmptraps and enter RAID as check\_command\_args. When you have saved the service, you need to go back to it and enter the advanced configuration.

## Checking logs

Since you are actually searching in a log file for new occurrences of a search string, it will very seldom report and error more than once in a row.

That means that the default behavior of doing three attempts before sending a notification needs to be changed to 1. Do so by changing max\_check\_attempts to 1.

You might also want to have a larger time span between checks, so that a potential problem persists longer than 5 minutes. Typically 15 minutes is a good value.

You are now ready to apply changes and save configuration and test it out.

 

