# Monitoring response-time via NSClient++

To get a more accurate picture of the availability of your IT-services, it’s a good idea to test the IT-services over the network-link that serves your centralized IT-services to other geographic locations.

This how-to paper will describe how to perform the most basic test, a test that checks the average roundtrip-time and measures packet loss using check\_ping. The test will be performed by a remote Microsoft Windows server and called via check\_nrpe and NSClient++. This test/check/service can then be added to a service group that you can use when generating SLA-reports.

Other, higher level test, can be performed in the same way. For example check\_tcp or check\_http can be used.

## Configuration at your remote windows server

-   Download and install .net framework 2.0 or later.
-   Download latest binary version of nagiospluginsnt:
     <http://exchange.nagios.org/directory/Plugins/*-Plugin-Packages/NagiosPluginsNT/details>
-   Place the plugins in some directory, for example C:\\plugins
-   Testrun check\_ping.exe at command-line. A good idea is to perform the test against a couple of the servers providing your centralized IT-services.
     C:\>C:\\plugins\\check\_ping.exe -H mailserver.domain.com -w 100,20% -c 500,60%
-   Add a command to NSClient++’s configuration file custom.ini:
     command[check\_ping]=C:\\plugins\\check\_ping.exe -H \$ARG1\$ -w \$ARG2\$ -c \$ARG3\$

If you want the possibility to supply arguments, like in the above example, you must explicitly allow this using the setting allow\_arguments=1 in op5.ini.

In previous versions of check-nt the argument-numbers are numbered with number one starting directly after the plugin-name (in the above example ARG1 is “-H” ARG2 is “mailserver.domain.com”), this is corrected in newer versions of check\_nrpe. In newer versions ARG1 is always ARG1. If you’re using old plugins, then this command is the one to put in op5.ini: command[check\_ping]=C:\\plugins\\check\_ping.exe -H \$ARG6\$ -w \$ARG7\$ -c \$ARG8\$

 

-   Restart NSClient++ to load the new settings.

## Configuration at your OP5 Monitor server

-   Test your new nrpe command at command-line:
     monitor!monitor:\~\$ /opt/plugins/check\_nrpe -H remote-windows-server.domain.com -c check\_ping -a mailserver.domain.com 100,20% 500,60%
-   Add a check-command to your configuration:
     command\_name: check\_ping\_remote
     command\_line: \$USER1\$/check\_nrpe -H \$ARG1\$ -c check\_ping -a \$ARG2\$ \$ARG3\$ \$ARG4\$
-   Add a new service to the host that you want to test the responsetime to:
     service\_name: Responsetime from location
     check\_command: check\_ping\_remote
     check\_command\_args: remote-windows-server.domain.com!mailserver.domain.com!100,20%!500,60%*
    *

 

 

