# Getting started with Bischeck

Disclamer

This is an unsupported plugin. More information about the bischeck plugin can be found at the [bischeck github page](https://github.com/thenodon/bischeck) or at the [bischeck.org](http://www.bischeck.org/).

 

## Prerequisites

A op5 Monitor installation with Bischeck installed. For information on how to install this addon, please read: [Installing Bischeck](Installing_Bischeck)

## 
Getting started with Bischeck and op5 Monitor

Until version 6.1 of op5 Monitor all monitoring was limited to static thresholds, like the classic 90% utilization for a file system. In many business cases static thresholds are not enough since they only provide a limited granularity as to when an alarm should be triggered. In the file system example it can be equally important to have a threshold for the speed of growth of the utilization. This means that we need to be able to define a threshold by calculating a utilization delta over a period of time. With Bischeck Adaptive and dynamic thresholds we can:

-   Define different threshold depending on the time of the day, day of the week or month

-   Calculate thresholds based on historical data using mathematical functions like average, max, sum, etc

All this, and much more, can be done with Bischeck. Bischeck integrates with op5 Monitor over standard API like Livestatus and NSCA.

For this article we will use an example from the area of network traffic. Our imaginary customer's network load differs a lot between day and night but previously the same threshold has been used irregardless of time of day. During the night a huge volume of backup data is transferred over the network which often pushes the utilization over the 80% utilization limit set for critical level. This behavior is acceptable during the night but not during the day. The result in this scenario is that our customer experiences a large number of alarms during the night even though the situation is perfectly acceptable. One solution is to increase the threshold for critical alarms to 90% but that will not be acceptable during the day. Another solution is to disable notifications during the night but that will be like driving blind.

The solution must be able to handle different threshold levels depending on the time and still make sure that we never break the 80% limit during the day and the 90% limit during the night. At the same time we need to compare the current network traffic against a historical level so we can generate alarms if the level changes drastically from the same period last week even if the total load is under 80% or 90%. This threshold rule will be defined for inbound and outbound traffic and the traffic should be in the 20% (warning) or 30% (critical) interval of the average of inbound and outbound traffic from the same time interval last week. This measurement will give the customer a dynamic baseline for the network traffic.

We will go through the example by showing the Bischeck configuration files, but the configuration could also be done by using the web based configuration tool Bisconf (bisconf has been deprecated and only works with bischeck 0.4.3). For full documentation about Bischeck please check out the README in latest release, [Github Bischeck page](https://github.com/thenodon/bisconf).

All the configuration files are located in /opt/monitor/op5/bischeck/etc.

Let's start with the core configuration file bischeck.xml. In this configuration we describe what to monitor.

``` {.html/xml data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"}
<?xml
    version="1.0" encoding="UTF-8"
    standalone="yes"?>
<bischeck>
<host>
<name>moon</name>
 
<service>
<name>net</name>
<schedule>15M</schedule>
<sendserver>true</sendserver>
<url>livestatus://localhost:6557</url>
<driver></driver>
 
<serviceitem>
<name>in</name>
<execstatement>{"host":"moon","service":"IF 2: eth0 traffic","query":"perfdata","label":"in_traffic"}</execstatement>
<thresholdclass>Twenty4HourThreshold</thresholdclass>
<serviceitemclass>LivestatusServiceItem</serviceitemclass>
</serviceitem>
 
<serviceitem>
<name>out</name>
<execstatement>{"host":"moon","service":"IF2: eth0 traffic","query":"perfdata","label":"out_traffic"}</execstatement>
<thresholdclass>Twenty4HourThreshold</thresholdclass>
<serviceitemclass>LivestatusServiceItem</serviceitemclass>
</serviceitem>
 
</service>
 
<service>
<name>totalTraffic</name>
<schedule>moon-net</schedule>
<sendserver>true</sendserver>
<url>bischeck://cache</url>
<driver></driver>
 
<serviceitem>
<name>total</name>
<execstatement>moon-net-in[0]+moon-net-out[0]</execstatement>
<thresholdclass>Twenty4HourThreshold</thresholdclass>
<serviceitemclass>CalculateOnCache</serviceitemclass>
</serviceitem>
 
</service>
 
</host>
</bischeck>
```

 

In Bischeck we have three main configuration concepts that define what to monitor; host, service and serviceitem. The host and service name must be equivalent to what is configured in op5 Monitor as a passive service.

In Bischeck the host definition acts only as a container for the rest of the configuration. Service defines the connection method to be used against the system to monitor and the schedule to monitor. Serviceitems defines the query used to retrieve data and the threshold class that will be used to determine threshold level for the measured data. A host can have multiple services and a service can have multiple serviceitems, but the state level for the service is set by the serviceitem with the highest level of severity.

Looking at our example we have defined a host called **moon** at line 4 and a service called **net** at line 7. At line 8 we can see that the service is executed every 15 minutes. At line 10 we define that the connection used by serviceitems is done by using livestatus against the host localhost at socket port 6557. This is the default op5 Monitor livestatus port.

For the service net we define two serviceitems. The first retrieve the performance data over livestatus for host moon and service "IF 2: eth0 traffic" with the performance data label “in\_traffic”. We do the same for serviceitem “out” but with performance data label “out\_traffic”.

For both serviceitems we have defined, line 16 and 23, we will use a threshold class called Twenty4HourThreshold. Will we see more about that a little bit later.

The next service we will define is called totalTraffic, line 30. This service will not collect data from any external system, instead it will use the internal Bischeck historical data cache, line 33. At line 31 we can also see that this service does not have a time based schedule, instead it will be executed after the moon-net service has been executed. This kind of scheduling is called “run after” in Bischeck.

This service has one serviceitem named total, line 37. The logic here is that it will add together the in and out traffic percentage that was retrieved by mon-net-in and moon-net-out at index 0 of the cached data. Index 0 is always the last collected data.

For this serviceitem we define that we will use a threshold class called Twenty4HourThreshold. Now that the first step is completed, the data collection, it's time to define the thresholds. The configuration for the threshold class Twenty4HourThreshold is done in the configuration file 24thresholds.xml.

``` {.html/xml data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"}
<?xml
    version="1.0" encoding="UTF-8"
    standalone="yes"?>
<twenty4threshold>
 
<servicedef>
<hostname>moon</hostname>
<servicename>net</servicename>
<serviceitemname>in</serviceitemname>
<period>
<calcmethod>=</calcmethod>
<warning>10</warning>
<critical>30</critical>
<hoursIDREF>1</hoursIDREF>
</period>
</servicedef>
 
<servicedef>
<hostname>moon</hostname>
<servicename>net</servicename>
<serviceitemname>out</serviceitemname>
<period>
<calcmethod>=</calcmethod>
<warning>10</warning>
<critical>30</critical>
<hoursIDREF>2</hoursIDREF>
</period>
</servicedef>
 
<servicedef>
<hostname>moon</hostname>
<servicename>totalTraffic</servicename>
<serviceitemname>total</serviceitemname>
<period>
<calcmethod>&lt;</calcmethod>
<warning>0</warning>
<critical>0</critical>
<hoursIDREF>3</hoursIDREF>
</period>
</servicedef>
 
<hours
    hoursID="1">
<hourinterval>
<from>00:00</from>
<to>23:00</to>
<threshold>avg(moon-net-in[-169H:-168H])</threshold>
</hourinterval>
</hours>
 
<hours
    hoursID="2">
<hourinterval>
<from>00:00</from>
<to>23:00</to>
<threshold>avg(moon-net-in[-169H:-168H])</threshold>
</hourinterval>
</hours>
 
<hours
    hoursID="3">
<hourinterval>
<from>00:00</from> <to>06:00</to> <threshold>90</threshold>
</hourinterval>
<hourinterval>
<from>07:00</from> <to>23:00</to> <threshold>80</threshold>
</hourinterval>
</hours>
 
</twenty4threshold>
```

 

For the Twenty4HourThreshold class we define thresholds for each host, service and serviceitem that will have some kind of threshold. These entries are called servicedef. For each service definition one or many periods can be defined to configure different settings for a combination of calendar items like month, week, day in month and day in week. If a period do not have any calendar definitions it will use the default period.

In the above example configuration we have, for simplicity, only added a default period, line 8, for the service definition mon-net-in. The calcmethod on line 9 defines how the measured value should be compared against the threshold. In our example we have used the interval definition (=). This means that our measured value should be in the interval around the threshold with a warning level of 10% higher or lower than the threshold, line 10, and a critical level of 30% higher or lower than the threshold, line 11. But where is the threshold?

For the period entry an hoursIDREF is defined. This “points” to the hours definition at line 40. The hours tag has one or several hourinterval tags defining a from-to interval. The threshold set for two consecutive hours are used to calculate a linear equation for any thresholds between the consecutive hours. In our case we made it simple defining that the threshold for all hours are the same, line 44. In this case the threshold is calculated as the average of all data points for moon-net-in for the period that exists between 169 to 168 hours ago. This means that we create a threshold based on the last 7 days of data. This also means that the data collection must run for at least one week before we have enough data to calculate the threshold. Until we have enough data the service will be in an UNKNOWN state. Since our schedule time is 15 minutes and we need to look back 169 hours we need to cache at least 676 values (169\*4). The default cache size is 500, so we need to set the property lastStatusCacheSize to 700 in the properties.xml file.

The configuration is almost identical for the service definition moon-net-out starting at line 16.

For the service definition moon-totalTraffic-total we measured the total percentage of the traffic by adding the moon-net-in and moon-net-out value. For this service definition we need to define a threshold that is 80 during the day and 90 during the night. At line 33 we define that our measured value should be less (\<) than our threshold. Since the warning and critical level are 0 we will directly get a critical alarm when the measured value is higher than the threshold level.

At line 56 we define two hourinterval; between 00:00-06:00 we have a threshold of 90 and between 07:00-23:00 the threshold level is 80.

Now we have two new services, moon-net and moon-totalTraffic that we need to integrate with op5 Monitor. This is done by creating two services, net and totalTraffic, for host moon in op5 Monitor. The services must be enabled for passive checks.

## Finalize Bischeck Setup within OP5 Monitor

Bischeck is an incredible tool for bringing adaptive thresholds into OP5 Monitor. This advanced feature does require some configuration, and is meant for the intermediate user. Be sure these last few steps are done in your installation. They are inferred in the body of this article, however for completeness we have included them as steps here.

1.  Configure a check\_command (Manage \> Configure \> Check Commands) as a placeholder. 
    1.  Name: check\_bischeck
    2.  Command: \$USER1\$/check\_dummy 2 "The bischeck service is not sending metrics, must be stale."

2.  Configure a Service Check. Using the example scenario the check command should match the Bischeck configuration, for example "net" within the host "moon". Your server can be one already added to OP5 Monitor, or a newly configured server just containing Bischeck Service Checks.
    1.  Within the Service Check configuration verify:
        1.  active\_checks\_enabled NO
        2.  passive\_checks\_enabled YES
        3.  We would also suggest: check\_freshness YES
        4.  And freshness\_threshold set to the number of seconds configured within bischeck.xml for the "schedule" part of the particular service definition.

3.  Add a Bischeck friendly graph template, be sure to name it check\_bischeck:
    1.  A great start is this graph from Urban Lagerström, provided by the Bischeck How To's: [Plot Interval Based Threshold With Extended Warning And Critical Data With PHP4Nagios](https://kb.op5.com/www.bischeck.org/?p=956)
    2.  Alternatively you can find the Graphs mentioned in documentation but not provided within the tar, at [the Git repo.](https://github.com/thenodon/bischeck/tree/master/src/main/php/php4nagios/templates.)
    3.  Upload to /opt/monitor/op5/pnp/templates, and create a symbolic link in templates.dist pointing to the template in the templates-folder. This will insure your plugin will remain, throughout future updates to OP5.

Hopefully this example gave you some ideas as to how Bischeck can be used together with op5 Monitor to create dynamic and adaptive thresholds! To read more about what you can do with Bischeck please visit [www.bischeck.org](http://www.bischeck.org/)  or the [Bischeck github page](https://github.com/thenodon/bisconf).

## Comments:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>Supporting documents related directly to Nagios Core, but also that provides insightful detail on the Bischeck setup can be <a href="http://blog.vizury.com/blog/vizuryblog/implementing-dynamic-thresholds-using-bischeck/">found here.</a><a href="https://kb.op5.com/blog.vizury.com/blog/vizuryblog/implementing-dynamic-thresholds-using-bischeck/">.</a></p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by jcavanaugh at Nov 29, 2016 12:15</td>
</tr>
</tbody>
</table>


