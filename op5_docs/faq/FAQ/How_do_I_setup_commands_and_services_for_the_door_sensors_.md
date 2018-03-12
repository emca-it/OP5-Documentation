# How do I setup commands and services for the door sensors?

## Question

* * * * *

How do I setup commands and services for the door sensors?

## Answer

* * * * *

The door sensors are monitored using the plugin for the environment module.

The following configuration will generate a CRITICAL alert if the door is open and OK if it's closed. In the example the probe is connected to "Group 4" (the wetness-contacts).

**command\_name:** check\_em1\_door\_sensor

**command\_line:** \$USER1\$/check\_em1 -H \$HOSTADDRESS\$ -u \$ARG1\$ -q w -w \$ARG2\$ -c \$ARG3\$

**service\_description:** door sensor - server room

**check\_command:** check\_em1\_door\_sensor check\_command\_args: 4!100:!100:

**max\_check\_attempts:** 1

Please verify by browsing the environmental module that the values from the probe are above 100 when the door is closed and below 100 when it's open.

