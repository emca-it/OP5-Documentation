# Tuning thresholds / amount of notifications

## Why tuning is needed

 

Any monitoring system, including OP5 Monitor, needs to be adjusted to suit your organizations specific needs. This how-to describes the basics of identifying the source(s) of your notifications and adjusting thresholds and configuration to get rid of false/uninteresting or exaggerated alerts (“alarms”/notifications). A new installation definitely needs tuning, but it’s also a good idea to generate reports on a regular basis to prevent being flooded with notifications.

## Basic workflow

 

When tuning an OP5 Monitor configuration you follow three basic steps:

-   Create a report to identify your top alert producers
-   Make a decision on what to do (use table below****)****

If…

then…

the problem needs to or will be fixed

acknowledge the problem or/and disable notifications and/or active checks of the host/service.

it’s a false/uninteresting or exaggerated source of alerts.

Identify what needs to be adjusted and set/use new thresholds, time periods, timeouts and check\_attempts.

-   Perform a configuration change or acknowledge the problem (use comments).

## Alert Summary

First create a Alert Summary report using the suggested click-path/options below.

‘Alert Summary’ -\> ‘Custom Report Options:’

Report Type: Top Alert Producers
 Report Period: Last Week
 State Types: Hard States
 (because notifications are only generated on hard states (last check\_attempt)
 Host States: Host Problem States
 Service States: Service Problem States

-\> ‘Create Summary Report!’

The report you get lists your top sources for alerts resulting in problem-state notifications, i.e, the alerts you get SMS and/or e-mail about.

## Finding the problem

If one of your listed top alert producers turns out not to be an actual problem, you need to find out why, when and how often the false/uninteresting or exaggerated “problem” occurs to be able to adjust you configuration.

Here some views in Monitor comes in handy. Using the Alert Summary Report as a starting point, you can click on the host/service-names in the report to reach the host/service-information-pages. In the information-pages you can:

-   take a look at a simple graphs (for the most common services)
-   see how long you’ve had the problem (Current State Duration)
-   read any comments about the host/service
-   reach even more detailed views about the problem:

View Availability Report For This Host/Service: Produces an Availability report where you can see the extent of the problem (hours/minutes of total unscheduled downtime)

View Trends For This Host/Service: Gives you an overview of when, how often and for how long durations the problem occurs.

View Alert History For This Host/Service: Gives you a very detailed list of all Alert events. This info is often needed to determine what threshold that has triggered the alert.

## Making the adjustments****
****

Depending on what conclusions you’ve made about the alert producer you now need to make some adjustments in your configuration. Two common problems and solutions listed below. There a of course lots and lots of adjustments that can be made. Some other commonly adjusted parameters are listed below the table.******
******

If…

then…

you get a lot of notifications during backup-hours…

create a new time period excluding the backup hours and use it as check\_period and/or notification\_period for the host/service.

you get a lot of notifications on PING-services on the far end of your WAN-connections…

1.  put all the hosts experiencing the same problem in a host group.
2.  Create a more tolerant service (by editing the service or creating a new template used by the service). Set higher timeout, warning or critical thresholds.
3.  Clone the new service to the new hostgroup.

**Other commonly adjusted parameters** (please see in line help or manual for details):

max\_check\_attempts
 normal\_check\_interval
 retry\_check\_interval

