# How can the hardware of network equipment be monitored?

## Question

* * * * *

How can the hardware of network equipment be monitored?

## Answer

* * * * *

To monitor the hardware of your network equipment, use the following plugins:

check\_snmp\_env: <http://nagios.manubulon.com/snmp_env.html>

check\_snmp\_env has been around for a couple of years now and version 1.2 has proven very usefull when monitoring for example a mix of Cisco switches. The plugin can monitor cisco, nokia Ipso, Bluecoat, Ironport and Foundry hardware.

In for example the Cisco-case, it monitors fans, power supplies (including RPS-modules) and temperature. It has been successfully tested on the most commonly used models ranging from cisco-1811 to cisco-4503.

The functionality has been further extended in two other plugins;

check\_snmp\_environment.pl: <https://exchange.nagios.org/directory/Plugins/Hardware/Network-Gear/Cisco/Check-various-hardware-environmental-sensors/details>

This is based on the 'check\_snmp\_env' script with the addition to check Cisco and Extreme hardware blades/modules and all hardware components for Juniper equipment. When it comes to Cisco-hardware it monitors both the modules of the supervisor and the blades in, for example, cisco-4500 and cisco-6500.

check\_env\_stats.py: <https://exchange.nagios.org/directory/Plugins/Hardware/Environmental/Network-Equipment-Environmental-Statistics/details>

This plugin provides temperature logs combined with the SNMP-location (in performance data format) and hence is very usefull when it comes to graphing and keeping an eye on the temperature in all the small dusty locations where you might have had to place your network equipment. The plugin has been successfully tested on cisco-2811 and beyond.

check\_snmp\_env is since OP5 Monitor 6.1 included and supported. More information about the plugin and the support level can be found [here](https://kb.op5.com/display/PLUGINS/check_snmp_env).
