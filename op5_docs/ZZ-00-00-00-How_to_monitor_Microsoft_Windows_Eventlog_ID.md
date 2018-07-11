# How to monitor Microsoft Windows Eventlog ID

## Introduction

In Microsoft Windows, almost all events are logged to the event log.
This how-to applies to two versions of the agent NSClient++, due to changes in the command used, and describes the process for monitoring **a specific** event log ID, which can help you detect changes and behavior patterns on your system.

# NSClient++ 0.4.4.15

## Prerequisites

- The NSClient++ monitoring agent version 0.4.4.15 installed on the target host
- Permissions to add check commands and services in OP5 Monitor

##
Adding the check command

1. Hover over the "Manage" menu and select "Configure"
2. Click on “Commands” in the "Core Configuration" section
3. Add a new command with the following settings:

    Option

    Value

    command\_name

    check\_nrpe\_windows\_eventlog\_id

    command\_line

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    $USER1$/check_nrpe -s -H $HOSTADDRESS$ -c check_eventlog -a file="$ARG1$" "warning=count = $ARG2$" "critical=count = $ARG3$" "filter=source like '$ARG4$' AND id = '$ARG5$'" unique truncate-message=300 'top-syntax=The status is: ${status}: with ${count} entries matching the ID the last 24h Log message:"${list}"'
    ```

4. Click the “Submit” button and save the configuration changes.

## Using the check command in a service

The check command that we created above takes 5 user supplied arguments:

Argument

Description

\$ARG1\$

Log Name ("Application", "Security", "System", "Directory Service", "DFS Replication" or similar)

\$ARG2\$

Warning threshold for number of events

\$ARG3\$

Critical threshold for number of events

\$ARG4\$

Event Source ("ActiveDirectory\_DomainService", "DFSR", "ADWS" or similar )

\$ARG5\$

Event ID to match against

### Example use case 1

In the following example we will add a service monitoring an event ID telling us that the Active Directory Web Services doesn't have a valid TLS Certificate.
This event has the ID "1400" and is located in the "Active Directory Web Services" file.

Configuration instructions:

1. Open up your target host in the configuration utility, go to the services section and select “Add new service”.
2. Change the following configuration options:

    Option

    Value

    service\_description

    Active Directory Web Services TLS Certificate

    check\_command

    check\_nrpe\_windows\_eventlog\_id

    check\_command\_args

    Active Directory Web Services!1!2!ADWS!1400

3. Click on the “Submit” button and save the configuration changes

## Additional information

For more advanced information have a look at the NSClient++ 0.4.4 [check\_eventlog documentation](https://docs.nsclient.org/0.4.4/reference/windows/CheckEventLog.html)

# NSClient ++ 0.3.9

## Prerequisites

- The NSClient++ monitoring agent version 0.3.9 installed on the target host
- Permissions to add check commands and services in OP5 Monitor

##
Adding the check command

1. Hover over the "Manage" menu and select "Configure"
2. Click on “Commands” in the "Core Configuration" section
3. Add a new command with the following settings:

    Option

    Value

    command\_name

    check\_nrpe\_windows\_eventlog\_id

    command\_line

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    $USER1$/check_nrpe -H '$HOSTADDRESS$' -c checkEventLog -a file='$ARG1$' MaxWarn='$ARG2$' MaxCrit='$ARG3$' filter-generated'=\>$ARG4$' filter=out filter=all filter+eventID=='$ARG5$' truncate=1000 unique descriptions "syntax=%type%: %source%: (%count%)"
    ```

4. Click the “Submit” button and save the configuration changes.

## Using the check command in a service

The check command that we created above takes 5 user supplied arguments:

Argument

Description

\$ARG1\$

Event log file ("Application", "Security", "System" or similar)

\$ARG2\$

Warning threshold for number of events

\$ARG3\$

Critical threshold for number of events

\$ARG4\$

Look-back time interval ("15m", "3h", "5d" or similar)

\$ARG5\$

Event ID

### Example use case 1

In the following example we will add a service monitoring an event ID telling us that the system encountered issues while loading a users profile.
This event has the ID "1505" and is located in the "Application" file.

Configuration instructions:

1. Open up your target host in the configuration utility, go to the services section and select “Add new service”.
2. Change the following configuration options:

    Option

    Value

    service\_description

    Profile problems

    check\_command

    check\_nrpe\_windows\_eventlog\_id

    check\_command\_args

    Application!1!1!2h!1505

3. Click on the “Submit” button and save the configuration changes