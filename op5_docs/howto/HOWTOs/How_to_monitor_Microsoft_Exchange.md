# How to monitor Microsoft Exchange

## Introduction

There are many ways to verify that a [Microsoft Exchange](http://en.wikipedia.org/wiki/Microsoft_Exchange_Server) mail server is running. You can check mail delivery, tcp-ports, services and more. No single test will provide a complete picture of the status of your Exchange-server, hence this how-to will describe how to combine several tests to have a reliable set of services that together provide the complete picture of the exchange servers status.

This how-to primarily covers how to Monitor Microsoft Exchange Server 2010. We assume you already have the latest op5 Windows agent NSClient++ installed and running on your Exchange-server.

 

 

### [Download op5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

## Configuring the tests/services

The test we will configure are:

-   Checking standard Exchange-related network services
-   Checking your mail system end-to-end using `check_email_delivery`
-   Checking Exchange core win32-services
-   Checking Exchange-related performance counters

## Checking standard Exchange-related network services

Scan the host (your Exchange-server) the web-gui-function ‘Scan host \<hostname\> for generic network based services’. Select the services you want to Monitor, for example pop, imap, smtp, and https.

## Checking your mail system end-to-end using check\_email\_delivery

### Add a new check-command:

*command\_name:* `check_email_delivery`
 *command\_line:*

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$USER1$/check_email_delivery -p '/opt/plugins/check_smtp_send -H $ARG1$ --mailto $ARG2$ --mailfrom $ARG3$ -U $ARG4$ -P $ARG5$ --header "Subject: op5 Monitor Test"' -p '/opt/plugins/check_imap_receive -H $ARG6$ -U $ARG4$ -P $ARG5$ -s SUBJECT -s "op5 Monitor Test"'
```

 

This new check-command requires that you supply six `check_command_args` in your servicedefinition as following:
`$ARG1$`: SMTP server hostname/ip
`$ARG2$`: to-address
`$ARG3$`: from-address
`$ARG4$`: user account
`$ARG5$`: user password
`$ARG6$`: IMAP server hostname/ip

### Configure an example service:

*service\_name:* Email Delivery
 *check\_command:* `check_email_delivery`
 *check\_command\_args:*

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
 smtp.domain.com!to-address@domain.com!from-address@domain.com!username!secret!imap.domain.com
```

 

## Checking Exchange core win32-services

Depending on the role of the exchange server, create the one that corresponds best with our exchange server

### Configure the new service:

*service\_name:* Exchange Core Services
 *check\_command:* `$USER1$/check_nrpe -H $HOSTADDRESS$ -c CheckServiceState -a ShowAll $ARG1$`
 *check\_command\_args:* `MSExchangeIS,MSExchangeTransport,MSExchangeSA,MSExchangeMailSubmission,W3SVC`

*service\_name:* Exchange FrontEnd Services
 *check\_command:* `$USER1$/check_nrpe -H $HOSTADDRESS$ -c CheckServiceState -a ShowAll $ARG1$`
 *check\_command\_args:* `MSExchangeSA,MSExchangeADTopology,MSExchangeRPC,W3SVC`

*service\_name:* Exchange Edge Transport Services
 *check\_command:* `$USER1$/check_nrpe -H $HOSTADDRESS$ -c CheckServiceState -a ShowAll $ARG1$`
 *check\_command\_args:* `MSExchangeADTopology,ADAM_MSExchange,MSExchangeTransport`

 

*Note:* Take a look at [Microsoft Technet](http://technet.microsoft.com/en-us/library/ee423542.aspx "Overview of Services Installed by Exchange Setup") for a complete list of Exchange services.

 

## Checking Exchange-related performance counters

Since Exchange win32-services can be reported as running even though they’re not doing their work, we want to even check some of the most important performance counters. This will act as an early warning system for Exchange problems.

### Configure the new services:

 

*service\_name:* Messages in all Queues
 *check\_command:*` check_nrpe_win_counter`
 *check\_command\_args:* `\MSExchangeTransport Queues(_total)\Aggregate Delivery Queue Length(All Queues)!MaxWarn=3000 MaxCrit=5000`

*Comment: Shows the number of messages queued for delivery in all queues. Threshold: Should be less than 3,000 and not more than 5,000.*

 

*service\_name:* Messages not yet processed
 *check\_command:* `check_nrpe_win_counter`
 *check\_command\_args: `\MSExchangeIS Mailbox(_Total)\Messages Queued for Submission!MaxWarn=40 MaxCrit=50`
*

*Comment: Shows the current number of submitted messages not yet processed by the transport layer. Threshold: Should be below 50 at all times. Shouldn’t be sustained for more than 15 minutes.*

 

*service\_name:* Messages Submitted per Second
 *check\_command:* `check_nrpe_win_counter`
 *check\_command\_args:* `\MSExchangeTransport Queues(_total)\Messages Submitted Per Second!MaxWarn=100 MaxCrit=200`

*Comment: Shows the number of messages queued in the Submission queue per second. Determines current load. Compare values to historical baselines.  Threshold: -*

 

service\_name: Messages Delivery per Second
 check\_command: `check_nrpe_win_counter`
 check\_command\_args: `\MSExchangeTransport Queues(_total)\Messages Completed Delivery Per Second!MaxWarn=100 MaxCrit=200`

*Comment:  Shows the number of messages delivered per second. Determines current load. Compare values to historical baselines.  * *Threshold:* *-*

 

*service\_name:* Messages Average bytes
 *check\_command:* `check_nrpe_win_counter`
 *check\_command\_args:*` \MSExchangeTransport SmtpReceive(_total)\Average bytes/message!MaxWarn=300 MaxCrit=500`

*Comment:  Shows the average number of message bytes per inbound message received. Determines sizes of messages being received for an SMTP receive connector.  * *Threshold:* -

 

*service\_name:* Messages Received per Sec
 *check\_command:* `check_nrpe_win_counter`
 *check\_command\_args:* `”\\MSExchangeTransport SmtpReceive(_total)\\Messages Received/sec”!MaxWarn=500 MaxCrit=1000`

*Comment:  Shows the number of messages received by the SMTP server each second. Determines current load. Compare values to historical baselines.  * *Threshold:* -

 

*service\_name:* Messages Sent per Sec
 *check\_command:* `check_nrpe_win_counter`
 *check\_command\_args:* `\MSExchangeTransport SmtpSend(_total)\Messages Sent/sec!MaxWarn=100 MaxCrit=200`

*Comment:  Shows the number of messages sent by the SMTP send connector each second. Determines current load. Compare values to historical baselines.  * *Threshold:* -

 

*Note:* Take a look at [Microsoft Technet](http://technet.microsoft.com/en-us/library/dd335215.aspx "Performance and Scalability Counters and Thresholds") for a complete list of Exchange performance counters.

 

 

 

 

### [Download op5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

