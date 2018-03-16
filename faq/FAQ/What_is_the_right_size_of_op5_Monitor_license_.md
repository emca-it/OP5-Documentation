# What is the right size of OP5 Monitor license?

There are many variation of how OP5 Monitor is deployed and used. This note aims to clarify and help you to plan the right size of your license in order to be compliant. Our primary goal with OP5 licensing is to keep it simple and clear so that anyone can calculate what the cost will be, both initially and for future upgrades. 

## The general principle of our pricing are based on two values:

1.  The number of **hosts** monitored by the system, hence the greater number of hosts, the less you pay per host.

2.  The **contract time**, hence the longer you choose to sign up, the less you pay per host.

Note - you can always upgrade with more hosts to a subscription at any time during the contract period.

## Definitions:

**A host** – a host as we define it is an object that is presented as a host within OP5 Monitor, a host can be a server, network device, something part of a virtual infrastructure or physical infrastructure for example temperature/humidity-sensors or UPS power but has a unique name in OP5 Monitor. There can be many logical hosts on a physical device/object you want to monitor, this is handy if you have shared hardware between multiple customers or environments which needs to be separated for reporting, alarms, access-rights and so on.

There are a number of unique values that is directly depending on a host: 

-   Services

-   Notifications

-   Alarms

-   Escalations

-   Check intervals

-   Report data / Graphs

-   etc..

## Example:

If you have 10 physical servers and you chose to virtualize them all and you want be able to create per virtual server statistics, alarms, reports/SLAs, views etc. the overall needed number of host will be 11 as you will have 10 virtual servers + the actual VMware host(s) hosting the VM's.

You can also choose to monitor only on the VMware host API – this will only require 1 host / license, you will get all the same alarms, reports etc. The drawback obviously is that they will all be bundled together as one host.

## What about if I run a distributed or redundant set-up?

Op5 Monitor in a distributed or redundant set-up is a fully synchronized system, so adding hosts in a Peer or Poller will automatically register to the central host configuration.

## Is one IP address always one host?

No - there can be many configuration were multiple hosts shares the same IP address.

## Has host anything to do with the hostname (FQDN)?

No - the address can be a hostname or FQDN as well as an IP but has nothing to do with host as per definition.

## What is a “Device” as referred to on the web or in the documentation?

With “device” we mean host, see definition above. It’s just a way for us to make our basic licensing easier to understand.

