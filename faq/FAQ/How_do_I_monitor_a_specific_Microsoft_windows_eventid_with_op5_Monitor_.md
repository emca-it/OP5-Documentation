# How do I monitor a specific Microsoft windows eventid with OP5 Monitor?

## Question

* * * * *

How do I monitor a specific Microsoft windows eventid with OP5 Monitor?

## Answer

* * * * *

You can use a function builtin to NSClient. The function is called CheckEventLog. Download our latest version of NSClient from the Agents section on: [http://www.op5.com/get-op5-monitor/download.](http://www.op5.com/get-op5-monitor/download/)

When you have installed the agent you only have to create a new check command like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
$USER1$/check_nrpe -H $HOSTADDRESS$ -c CheckEventLog -a filter=new file=$ARG1$ filter+eventID==$ARG2$ filter-generated=\<$ARG3$ MaxWarn=$ARG4$ MaxCrit=$ARG5$
```

Create a service that uses the check command above:

**check\_command\_args:** Application!18456!1h!5!10

This service will now check for event-id 18456 in the Application log and warn you if it finds five or more events with that id during the latest hour. You will get a critical if it finds ten or more.

The complete documentation for CheckEventLog can be found here:

<http://nsclient.org/nscp/wiki/CheckEventLog/check_eventlog>
