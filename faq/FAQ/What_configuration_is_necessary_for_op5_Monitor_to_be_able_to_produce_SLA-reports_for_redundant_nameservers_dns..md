# What configuration is necessary for OP5 Monitor to be able to produce SLA-reports for redundant nameservers/dns.

## Question

* * * * *

What configuration is necessary for OP5 Monitor to be able to produce SLA-reports for redundant nameservers/dns.

## Answer

* * * * *

Since Business Services was introduced in OP5 Monitor it is the preferred way of setting up logic for redundancy and/or clustered services.

However, the old info below is kept as a reference if Business Services for some reason is unwanted:

*By default the check-command "check\_dns" assumes you want to monitor the nameserver-service on a single nameserver/dns. To be able to get correct SLA-reports you need to monitor your nameservers with one single test that can use any of you nameservers. By adding an alternative check-command you can force the plugin check\_dns to use all the nameservers specified in /etc/resolv.conf for the lookup-test. The new command needs a longer timeout and could look like this: check\_command: check\_dns\_redundant command\_line: \$USER1\$/check\_dns -H \$ARG1\$ -a \$ARG2\$ -t 30 (You have to edit your services and select the new command, apply and Save configuration too)*
