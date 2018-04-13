# How to Monitor a Server with Enhanced IPMI sensor

IPMI  is a standardized computer system interface used by system administrators to manage a computer system and monitor its operation. Through IPMI a number of hardware sensors are made available for monitoring.

## Plugin check\_ipmi\_sensor

The check\_ipmi\_sensor plugins is a Open Source plugin which basically is a wrapper around a tool called FreeIPMI (see below). You can read more about [FreeIPMI](http://www.thomas-krenn.com/de/wiki/IPMI_Sensor_Monitoring_Plugin#Weitere_Informationen "FreeIPMI sensor monitoring") at the creator, Thomas Krenn’s German webpage.

## Plugin details

The plugin supports IPMI v1.5 and IPMI v2.0. It can check IPMI sensors locally or via ‘Serial over LAN’ connection. In order for remote monitoring to be possible, the target (monitored system) need to be configured to accept remote connections. The exact configuration procedure is hardware (motherboard/Bios) dependant.

## Prerequisites

- Latest plugin package, or the package monitor-plugin-check\_ipmi: "**yum install monitor-plugin-check\_ipmi**"
- Install the FreeIPMI package on the OP5 Monitor server, ”**yum install freeipmi**”
- Enable and configure IPMI as described below.

## How to Enable IPMI Monitoring

The following is an example on how-to enable IPMI , please note that it can differ for your hardware.

On Dell PowerEdge servers (1950 and R410 at least) the following steps are needed in order to enable ‘Serial over LAN’.

1. On Boot, press Ctrl-E when prompted.
2. Set IPMI Enabled
3. Set a static IP address and gateway.
4. Set a username and a password.
5. Reboot

**Note:** these steps are not necessary on the OP5 Monitor server, only on the systems we want to monitor.

## Sensor groups that can be monitored

- TEMPERATURE
- VOLTAGE
- CURRENT
- FAN
- PHYSICAL\_SECURITY
- PLATFORM\_SECURITY\_VIOLATION\_ATTEMPT
- PROCESSOR
- POWER\_SUPPLY
- POWER\_UNIT
- MEMORY
- DRIVE\_SLOT
- SYSTEM\_FIRMWARE\_PROGRESS
     EVENT\_LOGGING\_DISABLED
- SYSTEM\_EVENT
- CRITICAL\_INTERRUPT
- MODULE\_BOARD
- SLOT\_CONNECTOR
- WATCHDOG2

**Note:** the availability of the sensor groups is variating depending on system configuration.

## Check Commands

If the check-commands does not exist in your configuration, do a "Check Command Import" via: (‘Configure’ -\> ‘Commands’ -\> ‘Check Command Import -\> check\_ipmi\_sensor’).

Some check commands example following:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>command_name</strong>
<strong>command_line</strong></td>
<td align="left">check_ipmi_sensor_memory
$USER1$/check_ipmi_sensor -H $HOSTADDRESS$ -U $ARG1$ -P $ARG2$ -L user -O “-c /opt/monitor/var/ipmi” -b -T MEMORY</td>
</tr>
</tbody>
</table>

## Adding the services

Below are some examples of services you can add.

Add the required services, (‘Configure’ -\> ‘Host: ‘ -\> ‘Go’ -\> ‘Services for host ‘ -\> ‘Add new service’ -\> ‘Go’):

Arguments are just examples, you need to adjust them to suite your environment.

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>service_description</strong>
<strong>check_command</strong>
<strong>check_command_args</strong>
<strong>Note</strong></td>
<td align="left">ipmi_sensor_memory
check_ipmi_sensor_memory
root!password
*</td>
<td align="left">ipmi_sensor_fan
check_ipmi_sensor_fan
root!password
*</td>
<td align="left">ipmi_sensor_power_supply
check_ipmi_sensor_power_supply
root!password
*</td>
</tr>
</tbody>
</table>

**Note\*:** You can instead add arguments(ARGs) USER11(root) and USER12(password) to the file /opt/monitor/etc/resource.cfg. Don’t forget to reload the Monitor service.
