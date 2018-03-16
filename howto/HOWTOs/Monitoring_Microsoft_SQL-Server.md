# Monitoring Microsoft SQL-Server

Microsoft SQL Server is one of the most used databases today. Because it often has an important role in your business you need to make sure you get alerted if there is a problem with your databases. The purpose of this article is to describe how OP5 Monitor can be used to monitor both important environment parts of the operating system and how to perform queries to the database. In this document we will assume that Microsoft SQL Server is the main application running on the server.

## **This will be done**

The suggested configuration components for monitoring Microsoft SQL Server are:

-   basic checks on the server like CPU, memory, disc usage, swap usage etc.
-   advanced checks of the operating system by checking several performance counters in the operating system
-   queries to databases
-   checking backup jobs.

## **Check commands**

Add the required check-commands, if they don’t already exist in your configuration, with the import functionality in OP5 Monitor (‘Configure’ -\> ‘Commands’ -\> ‘Check Command Import’):

### **List of commands**

plugin name

check\_command

check\_nt

check\_mssql\_db\_file\_size

check\_mssql\_log\_file\_size

check\_nt\_memory\_page\_per\_sec

check\_nt\_physical\_disk\_time

check\_mssql\_num\_deadlocks

check\_mssql\_num\_user\_connections

negate

check\_mssql\_cache\_hit\_ratio

check\_sql

check\_mssql\_backup\_job

check\_mssql\_query\_string\_regex

check\_mssql\_query\_count

check\_mssql\_query\_reponstime

 

## **Description of the commands**

In the table below you will get a description of the so called performance check\_commands used to monitor a Microsoft SQL Server.

command\_name

description

check\_mssql\_db\_file\_size
 and
 check\_mssql\_log\_file\_size

-   Disk usage is something we always need to check. With this check\_command you will be able to monitor the size of the data and log files size.
-   If you use ‘\_total’ as \$ARG1\$ you will get the sum of all data or log files.
-   Warning and Critical is meassured in KB.

check\_nt\_memory\_page\_per\_sec

-   This counter will measure pages per second that is fetched from RAM to the harddrive or vice versa.
-   Normally this value should be 0
-   Values between 1 to 20 should not be a problem but as usual everything is relative
-   Values over 20 during a longer time period mostly means that you need to add more RAM to the server

check\_nt\_physical\_disk\_time

-   This counter measures how busy a physical array is, not any logical partition or an individual disc in the array.
-   It will give you a pretty good knowledge about how busy your disk array is.
-   The value should not be over 55% on the server. If it is over 55% during several 10 minutes periods over 24 hours it will be an indication of I/O problems on the server

check\_mssql\_num\_deadlocks

-   Deadlocks appear when two processes, who has locked one “pieces of data” each, both try to lock the same “new piece” of data at the same time. Every involved process will be waiting indefinitely for the other process to release the lock. Microsoft SQL Server will detect and kill one of the processes which means that one process will loose data
-   OP5 Monitor will send a Critical alert as soon as one deadlock appears

check\_mssql\_num\_user\_connections

If the number of connections at the same time is too high you might run in to problems and needs to increase the number of threads on the running server. This check\_command will count the number of connections.

check\_mssql\_cache\_hit\_ratio

-   Buffer Cache Hit Ratio counter indicates of how often your Microsoft SQL Server goes to the Buffer instead of the harddrive when searching for data.
-   The value should be over 90 %
-   We may only use either Warning och Critical here so in the default config we have chosen Critical.

 

The table below describes the check\_command you may use when monitoring Microsoft SQL Server by queries

command\_name

description

check\_mssql\_backup\_job

-   The check\_command is one way to monitor the backup internal backup jobs of your Microsoft SQL Server.
     State OK will be true if the string “The job succeeded.” is found in the query made to the msdb database
-   State Critical will be returned if the string “The job succeeded” is not found or if the last backup job is older than 24 hours

check\_mssql\_query\_string\_regex

-   The check\_command takes a given query and will search for a given search string in the result set and alert if not found.
-   You may use regular expressions when searching for a string in the first cell in the first row of the result.

check\_mssql\_query\_count

The check\_command takes a given query and return the number of hits.

check\_mssql\_query\_reponstime

The check\_command will report the responstime of a given query.

## **Adding the services**

Add the required services, (‘Configure’ -\> ‘Host: \<your-mssql-server\>’ -\> ‘Go’ -\> ‘Services for host \<your-mssql-server\>’ -\> ‘Add new service’ -\> ‘Go’):

When you added the host you had probably already added services like CPU usage, mem usage, disk usage and so on. The table below describes services you probably want to add. (Arguments are just examples, you need to adjust them to suite your environment).

## **Performance services**

service\_description

check\_command

check\_command\_args

MSSQL Services

check\_nt\_service

SQLSERVERAGENT,MSSQLSERVER

MSSQL DB File Size op5

check\_mssql\_db\_file\_size

1024!1256

MSSQL Log File Size op5

check\_mssql\_log\_file\_size

1024!1256

NT Memory Page/SecP

check\_nt\_memory\_page\_per\_sec

20!30

NT Physical Disk Time

check\_nt\_physical\_disk\_time

45!55

MSSQL Cache Hit Ratio

check\_mssql\_cache\_hit\_ratio

90!80

MSSQL Num Deadlocks

check\_mssql\_num\_deadlocks

1

MSSQL Num User Connections

check\_mssql\_num\_user\_connections

200!250

## **Query services**

service\_description

check\_command

check\_command\_args

MSSQL Backup job – master

check\_mssql\_backup\_jobn

user!passwd!job name

MSSQL Select String

check\_mssql\_query\_string\_regex

user!password!db!select field from table where…!.\*The job succeeded..\*

MSSQL query count

check\_mssql\_query\_count

user!password!db!select field from table where…!10!20

MSSQL respons time

check\_mssql\_query\_reponstime

user!password!db!select field from table where…!5!10

Use the “Test this service” button for the services to see if they work. Once they are correct and working as they should you may add the services to all of your Microsoft SQL Servers with the clone function.

## **Monitoring a cluster**

It is not unusual that a Microsoft SQL Server is running in a clustered environment. Of cource we can monitor your Microsoft SQL Server in that kind of environment to. Please read the how-to about [Monitoring Microsoft clustered servers](Monitoring_Microsoft_clustered_servers).

 

 

