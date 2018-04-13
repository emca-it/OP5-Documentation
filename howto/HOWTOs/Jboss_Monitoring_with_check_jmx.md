# Jboss Monitoring with check\_jmx

## Introduction

This how-to will show how to monitor a installation of Jboss with OP5 Monitor and the plugin [check\_jmx](https://kb.op5.com/display/PLUGINS/check_jmx).

Java Management Extensions (JMX) is a [Java](http://en.wikipedia.org/wiki/Java_platform) technology that supplies tools for managing and monitoring [applications](http://en.wikipedia.org/wiki/Application_software), system objects, devices (e. g. printers) and service oriented networks. Those resources are represented by objects called MBeans (for [Managed Bean](http://en.wikipedia.org/wiki/JMX#Managed_Bean)).\*

JMX exposes a set of ‘Managed bean’ (MBean) wich represents a resource running in the Java Virtual Machine.

The JMX implementation of a java application server typically exposes resource usage statistics (memory, threads used etc) and lots of other statistics/metrics. Apart from generic information the application server vendor also provide MBeans specific for the application server in question.

Standard JMX using RMI is no longer available in JBoss AS as of version 7.1

## Functionality

The `check_jmx` plugin enables you to monitor the values of any MBean attribute made available through JMX.

## Prerequisites

The JMX agent need to be enabled at the application server that is being monitored. The agent must be configured to allow remote connections over RMI ((Java) Remote Method Invocation). Refer to the application server documentation for details on how to set this up.

It is also possible to run the checks in this how-to with a username and password to increase security, this how-to will not cover that. Please refer to your application servers manual how to set that up.

## Installation

The check\_jmx plugin is included in the op5-plugins package and is located in `/opt/plugins`. Metadata/checkcommand information is installed in `/opt/plugins/metadata/check_jmx.metadata`.

You will also need java installed in your OP5 Monitor, you can install java via yum from our repositories: "**`yum install java-1.7.0-openjdk`"**

More information regarding java installation and it's versions can be found through the CentOS community: <http://wiki.centos.org/HowTos/JavaOnCentOS>

## Usage

The plugin consist of a shell script wrapper (`check_jmx`) and a java jar file (`check_jmx.jar`). When running the plugin the shell script should be invoked, the jar file should not be used directly. The plugin consist of a shell script wrapper (`check_jmx`) and a java jar file (`check_jmx.jar`). When running the plugin the shell script should be invoked, the jar file should not be used directly.

    ./check_jmx -U  -O

## Examples

You can test the different checks from command-line to verify that they works before you implement them into OP5 Monitor. check the ‘used’ key of attribute ‘HeapMemoryUsage’ in the object:  ‘java.lang:type=Memory’

    cd /opt/plugins
    ./check_jmx -U service:jmx:rmi:///jndi/rmi://'app-server':'1090'/jmxrmi -O java.lang:type=Memory -A HeapMemoryUsage -K "used"

Check the ‘ThreadCount’ attribute in the object  ‘java.lang:type=Threading'

    ./check_jmx -U service:jmx:rmi:///jndi/rmi://'app-server':'1090'/jmxrmi -O java.lang:type=Threading -A ThreadCount -K ""

Check available connections in the connection-pool in the object ‘jboss.jca:name=JmsXA,service=ManagedConnectionPool’ with the attribute ‘AvailableConnectionCount’

    ./check_jmx -U service:jmx:rmi:///jndi/rmi://'app-server':'1090'/jmxrmi -O jboss.jca:name=JmsXA,service=ManagedConnectionPool -A AvailableConnectionCount

## Check Commands

Add the required check-commands, if they don’t already exist in your configuration (‘Configure’ -\> ‘Commands’ -\> ‘Check Command Import’):

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><strong>command_name</strong>
<strong>command_line</strong></td>
<td align="left">check_jmx_current_threadcount
 $USER1$/check_jmx -U service:jmx:rmi:///jndi/rmi://’$HOSTADDRESS$’:'$ARG1$’/jmxrmi -O java.lang:type=Threading -A ThreadCount  -K “” -w $ARG2$ -c $ARG3$</td>
</tr>
</tbody>
</table>

## Adding Services

Add the required services, (‘Configure’ -\> ‘Host: ‘ -\> ‘Go’ -\> ‘Services for host ‘ -\> ‘Add new service’ -\> ‘Go’):

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
<strong>check_command_args</strong></td>
<td align="left">Current Threadcount
check_jmx_current_threadcount
1090!100!120</td>
<td align="left">Garbage Collection Timing
check_jmx_garbage_collection_timing
1090!3500!4000</td>
</tr>
</tbody>
</table>

## Other

This is just an example of some parameters that you can monitor with check\_jmx, for more detailed information, please refer to the developers site. We  recommend that you also monitor the server that is running JBoss at a lower level, i.e on operating system level with for example NRPE to get more detailed information about the underlying operating system. More information: <http://www.op5.com/agents/nagios-remote-plugin-executor-nrpe/>

## Read more

The developers site: <http://snippets.syabru.ch/nagios-jmx-plugin/>

JMX4Perl How-to: [How to monitor your application server with OP5 Monitor and JMX4Perl](How_to_monitor_your_application_server_with_op5_Monitor_and_JMX4Perl)

JMX on wikipedia: <http://en.wikipedia.org/wiki/JMX>

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free.

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)
