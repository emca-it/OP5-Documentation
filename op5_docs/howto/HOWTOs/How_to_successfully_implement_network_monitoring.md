# How to successfully implement network monitoring

To implement monitoring can be a very wide concept. The purpose of this document is to concretize what such an implementation consist of, in order to give you an overview of what needs to be done, who to involve and how to prioritize.

## Main goals

There’s no point in implementing monitoring just to get it of your to do-list. If implemented correctly monitoring can really influence and support how you work, what you spend your time on and how you make decisions. Below some main goals are listed which are important to keep in mind in order to prioritize wisely how you spend your time when building a monitoring configuration.

### Get in control of your IT-services!

Every IT-service is dependent on a number of network-services, processes, servers, network equipment, and network connections. By monitoring all the dependencies you gain understanding of how different problems affect your services. Using that information you can make informed desicions on how to best manage and further develop your operations environment.

### Work proactively!

With correctly configured thresholds you will get warnings /before/ things stop working. By reacting on warnings you have already fixed the problem, or are already working on the problem, when users start reporting errors.

By using OLA-reporting (Operational Level Agreement reports) you can fix problems /before/ they start effecting your services. OLA-reports are reports that include all the dependencies of an IT-service.

### Tie the core business closer to IT-operations!

By identifying “system owners” in the organization you can make colleagues understand the importance of IT-systems. An originator/supplier relationship can be established between the system owners and the monitoring administrators to aid in finding a good routine for adding more monitoring. The work of creating and managing SLA-reports (Service Level Agreement reports) can be delegated to the system owners who can schedule the reports for automatic delivery to managers responsible for service availability.

## Planning the deployment

When planning how to deploy monitoring, split the work that lies ahead into three to ten stages and populate each stage with one to three tasks (types of services to add). Plan for a test- and adjustment-period of a least a week between the end of one stage and the start of the next. The test- and adjustment-periods are needed to be able to remedy errors in your IT-environment that has been discovered in each stage, and to confirm that thresholds and check-periods are correctly configured/adjusted. Use alert summary reports to pinpoint what needs to be remedied or adjusted in each test- and adjustment-period.

In the planning stage, the good old OSI-model can be of use.

## Order of importance

Below is a list of tasks or service-types to add to your configuration, listed in order of importance. How important it is to monitor different service-types is of course specific for each organization, but the list below can be a good starting-point.

In short you start by pinging your servers and finish up by adding monitoring of log filters matching on “bad signs” (early warnings) in your logs.

Task /service-type

Description

Applicable op5 products

Commonly used plugins

hosts

Check host availability and graph ICMP ping statistics

op5 Monitor

check\_host, check\_icmp

environmentals

Monitor and graph temperature, humidity, and floor wetness

op5 Monitor

check\_tempraxe, check\_em1,

ups

Monitor and graph status, load per phase and estimated battery runtime

op5 Monitor

check\_snmp, check\_apc, check\_ups

network services basic

Check availability of network services like dns, imap, http,
 smtp and graph their response time

op5 Monitor

check\_tcp, check\_dig, check\_http, check\_imap

agent services

Monitor and graph OS resource utilization (disk, cpu, memory, swap, processes, connections, cache)

op5 Monitor

check\_nt, check\_nrpe, check\_nwstat

services, daemons, processes and jobs

Monitor Windows services and processes, unix/linux daemons, processes and OS400 subsystems and jobs

op5 Monitor

check\_nt, check\_nrpe, check\_as400

network services advanced

Advanced monitoring of network services, like advanced
 database-or website-monitoring

op5 Monitor

check\_mysql, check\_sql, check\_oracle, check\_webinject, check\_http

graphs for traffic/errors

Monitor and graph traffic (bandwidth usage) and errors/discards on relevant NICs/ports on switches/routers. Locate and remedy sources of broken packets.

op5 Monitor

check\_traffic, check\_iferrors, check\_snmpif

hardware services

Check hardware status (disk-arrays, temperature, power-supplies, fans, memory modules)

op5 Monitor

check\_openmanage, check\_hpasm, check\_snmp, check\_snmp\_env, check\_ipmi\_sensor

logs

Collect/centralize and archive Eventlogs/syslogs and application-logs. Monitor for bad messages.

op5 Monitor + LogServer extension

check\_ls\_log, check\_log2

 

 

