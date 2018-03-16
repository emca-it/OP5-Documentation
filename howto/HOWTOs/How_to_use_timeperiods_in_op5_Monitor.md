# How to use timeperiods in OP5 Monitor

## **Introduction**

Time periods makes it possible to control when to monitor and alert. By using time periods you can specify:

-   when a certain service will be checked.
-   when notifications will be sent out.
-   to which person to send notifications based on what time the alarm triggered.
-   when dependencies are valid.

## **Default time periods**

Name

Description

work-hours

Specifies every hour between Monday 08:00 to 17:00 Friday every week.

Non-work-hours

The non-work-hours includes all the hours that work-hours doesn’t.

24×7

From 00:00 to 23:59 every day.

*The default none work hours time period only include these hours. So any holiday’s, like Christmas Eve, will not be included and will have to be configured to be considered non work hours.*

 

**Good to know**

Before you start configuring your own time periods, there are a couple of things to consider.

Checks made manually are not restricted by time periods. Only the scheduled checks are restricted to the time period configured.

When you’re adding dates, weekdays, days of the months and calendar dates to your time period, it is important to remember that some directives overrides the other depending on how they were specified. The order of precedence for different types of directives (in descending order) is as follows:

-   Calendar date (2008-01-01)
-   Specific month date (January 1st)
-   Generic month date (Day 15)
-   Offset weekday of specific month (2nd Tuesday in December)
-   Offset weekday (3rd Monday)
-   Normal weekday (Tuesday)

## **Configuration examples**

Now let us take a look at a couple of examples to show how the time periods can be used.

**Example 1**

Let’s say we wanted to configure a time period to include non-work-hours and every holiday as well. This is one way to achieve this.

1.  Make a new time period.
2.  Add every holiday as an exception.
3.  Make yet another time period.
4.  Copy the settings from 24×7, and then exclude the work hours and holidays.

Now you have a time period that defines every non working hour, including holidays.

Now you might want to have a certain contact, other than the contacts used for working hours, during the time period you just created. To do this you only have to follow the steps below:

1.  Change the time period for the contact you want to be notified when alarms trigger.
2.  Select the time period for host\_notification\_period and/or service\_notification\_period.

**Example 2**

Another scenario might be when you want to exclude a period of time when no checks are being made. Say you have a backup job running at 3:00 every night. The system might be hogged and you don’t want any alarms being triggered at this time.

To exclude the time between 3:00 and 4:00 every day from being part of any scheduled check.

1.  Create a new time period with the settings from 24×7.
2.  Exclude 03:00-04:00, every day, month and year.
3.  Edit the host or service you want this time period to be used with and use it with check\_period.

Usually it is recommended to monitor 24×7. If you choose to do so instead of disabling any checks during this time, you could specify that no notification could be sent out during this time. This is achieved by adding a time period to the notification\_period directive of either a host or service.

This was just a few simple examples of how time periods can be used. It can also be used to decide when escalation can be made or when dependencies are considered valid. A few other scenarios where time periods are really useful might be specifying vacation days and creating more advanced on-call contact schedules etc.

 

 

