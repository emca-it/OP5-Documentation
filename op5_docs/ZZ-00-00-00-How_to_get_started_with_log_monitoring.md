# How to get started with log monitoring

## **Introduction**

What to log, when & where – a best practice article on getting started with a centralized logserver and log monitoring. OP5 LogServer is an extension module available to OP5 Monitor Enterprise customers.

To really make use of a centralized logserver and get return on investment, you have to learn how to use it and configure it to suit your needs. Installation is a breeze but knowing what to do next is not as easy.

The purpose of this document is to concretise what implementing log monitoring and a [centralized logserver](http://www.op5.com/explore-op5-monitor/extensions/logserver-extension/) consist of, apart from installing the software, in order to give you an overview of what needs to be done, who to involve and how to prioritize.

## **Main goals**

If implemented correctly a centralized logserver with monitoring capabilities can really influence and support how you work, what you spend your time on and how you make decisions. Below are some main goals are listed which are important to keep in mind in order to prioritize wisely what you spend your time on when implementing a centralized logserver.

## **Stop guessing!**

We all need to make well-informed decisions, and sometimes even investigate things. Understanding in what order things happen, how one system differs from another and how your systems behaved previously, before changes, becomes crucial in today’s complex it-systems and ever-changing it-infrastructure. With a centralised logserver in place you have access to a data-mining tool providing you with a full time-stamped view of everything you’ve decided to log. You can easily filter out what you need to know, monitor the log filters, schedule a report for it, or just follow the trend of hits for your filter.

## **Work pro-actively!**

Logs contain early warning signs. Informational events about resource or license usage, and warnings about unexpected program behavior, are easily missed when you aren’t looking at all systems at the same time. You know what your systems should and should not be logging – make sure to save time by using a logserver that can filter out and monitor that information for you.

## **Secure your business!**

- Make use of the application logs of your main production systems to improve performance.
- Guarantee your customers their transactions are logged and recorded.
- Minimize downtime in case of network intrusion.
- Verify that you don’t have unauthorized access to corporate information.
- Make sure to monitor your logs to receive notifications and alarms and to be responsive.

The work of actually tuning parameters, having proper logging in applications, exterminating compromised systems and scheduling access-reports can be delegated to “system owners” in the organization.

**Planning the deployment**

When planning how to perform logging, filtering, archiving and perhaps filter monitoring for your entire network, start by putting together two things:

- A summary of your own organizations and your customers *general* demands on transaction logging, system logging, archiving/rotation, access-logging, reporting and monitoring.
- A check list table where rows are each production system, and columns are “tasks”, or type of logging/reporting/monitoring to add (see table below).

Split the work that lies ahead into three to ten stages and populate each stage with one to three tasks (types of logging to add). Plan for a test- and adjustment-period of a least a week between the end of one stage and the start of the next. The test- and adjustment-periods are needed to be able to remedy errors in your IT-environment that has been discovered in each stage, and to confirm that filters and report-types are correctly configured/adjusted. Plan for follow-up meetings with department managers at the end of the stages.

### **Don’t log everything!**

Please observe that you should exclude at least two things in your check-list-matrix:

- Logging from system where you already have *specialized* tools for analysis and archiving (like checkpoint secure client log viewer and web-server-statistics tools like AWstats). There is no point in centralizing logs where specialized tools are already in use. It will make firewall log filtering and web statistics generation less easy, while adding unnecessary load on the LogServer.
- Excessive/unnecessary logging (like debug-logging from development systems). Don’t centralize and record info that has no value for others. Developers are likely to enable debug-logging and verbose logging where ever available. These logs will just produce unnecessary load without adding value for others.

**Order of importance**

Below is a list of tasks (logserver configuration and types of logging to set up), listed in order of importance. How important it is to add logging of different types is of course specific for each organization, but the list below can be a good starting-point.

In short you start by making sure your system logs are all available in a central location and finish up by adding scheduled reports and monitoring of log filters matching on “bad signs” (early warnings) in your logs.

Task /service-type

Description

Common log-source

LogServer rotation settings

Adjusting the rotation intervals for local database, local storage and remote storage. General recommendation are to keep about three days (12-14 million rows) in database, six months on local disk and one year in remote storage.

N/A

system logs

Logs from system that uses the syslog standard.

unix-systems, linux-systems, switches and routers

Event Logs

Windows Event Logs (picked up by [syslogagent](http://www.op5.com/download-op5-monitor/agents/)). Three basic types are available: Application, Security and System. Some systems also have additional Event Log types like Directory Service, DNS Server or File Replication Service.

Windows production servers, domain controllers and Windows Terminal Servers.

access logs

Authentication and access auditing commonly records access related messages using the “auth” facility in the syslog-standard or the Windows Security Event Log.

Kerberos servers, LDAP-servers, radius-servers, VPN-appliances and remote access portals.

application logs

Application logs that does not utilize common log standards. The logs are picked up by [syslogagent](http://www.op5.com/download-op5-monitor/agents/) or app2syslog.

Oracle db-servers (oracle.log), other applications with “their own” logfile.

error-filters and warning-filters

Creating filters that catches errors and warnings.

any

summary reports

Scheduling summary reports to catch changes in trends and to determine which hosts are producing most hits for specific filters.

any

auto reports

Scheduling automatic e-mail delivery of reports containing matching log messages for specific filters.

any

monitored filters

Adding automatic monitoring of specific filters in order to trigger notifications containing number of hits or excerpts of actual log message text.

any
