# How OP5 Monitor works "under the hood"

## Introduction

The purpose of this article is to give the reader a high-level overview of how OP5 Monitor works "under the hood".
It will cover the different components of the product and how they interact with each other.

## Overview
*
![](images/16482360/17269437.png) \


This illustration is a simplified version of the components relationships*

## Components

Below are descriptions of the most critical components included in OP5 Monitor:

### Naemon -

Naemon is the core of Monitor, responsible for monitoring hosts and triggering notifications.
It's a community developed fork of Nagios 4 core, one of the worlds most used and trusted open source monitoring systems.

Naemon is responsible for scheduling checks, keeping blocking outages and similar,
but the actual monitoring and notifications is handled by plugins.

Monitor includes a lot of check plugins out of the box to monitor systems via common protocols like SNMP, WMI and NRPE,
but can easily be extended to support other applications, thanks to it's compatibility with the Nagios plugin API.

#### Additional information

- HOW-TO: Installing third-party plugins
- Blog post: op5 on Naemon, Nagios and the future
- The Naemon project website

### Merlin -

Merlin is the software component in Monitor responsible for load balancing/high availability and distributed monitoring.
It takes care of tasks like splitting configuration for pollers, making sure checks get spread out over peers and synchronizing object states.

It consists of two parts - a Naemon module and a system daemon.
Merlin uses a custom protocol for exchanging state information and utilizes SSH for configuration management.

### Livestatus -

Monitor uses a fork Mathias Kettner's Livestatus, a Naemon module that acts like a in-memory database,
containing real-time information about the states of objects in Naemon and related data.

Livestatus is used by many components inside Monitor, but can also be queried through a UNIX socket or command line tools like "mon".

- Documentation for the original version of MK Livestatus

### Logger -

The Logger component allows Monitor to receive syslog messages for analysis and storage.
It's built on top of the syslog-ng server and stores log data in a PostgreSQL database and compressed log archives for historical data.

The logs can be viewed and searched in Ninja or queried through the HTTP API.

#### Additional information

- HOW-TO: Using Logger and custom columns for root cause analysis

### Trapper -

Trapper is responsible for handling incoming SNMP traps/notifications.
It consists of two parts - the collector and the processor.

The collector is built on a modified version of snmptrapd and inserts received traps into a MySQL database for processing.
The processor runs a set of user defined rules to handle the trap data and updates a service in Naemon via a passive check result with the status.

Trapper can be managed in Ninja or via the command line tool "traped".

#### Additional information

- HOW-TO: Getting started with OP5 Trapper
- Manual page for snmptrapd configuration

### Synergy -

Synergy, also known as Business Service Management (BSM),
analyze information from hosts and services in Naemon to determine a high level business/service delivery status.

It queries the Livestatus database for status information and runs a set of user defined rules to determine the state of a business object.
The business object can be "materialized" as service on a host, which will result in Synergy sending passive check results to Naemon.
This allows you to include the business objects in reports and configure alerting/event handlers for them.

Synergy can be configured in Ninja under "Business Services" or with configuration files.

#### Additional information

- HOW-TO: [4 steps to turn on simple BSM in your system](https://kb.op5.com/display/HOWTOs/4+steps+to+turn+on+simple+BSM+in+your+system)
- Webinar: Introduction to Business Services Management in OP5 Monitor

### Ninja -

Ninja is the web interface for Monitor.
It gives users the ability to view status information and monitoring metrics for hosts and service,
search for log patterns, configure business services, generate reports and similar.


### Nacoma -

Nacoma is the graphical utility for Naemon object configuration and various other aspects of Monitor,
like user permissions and management packs.
It provides tools like clone and propagate that help the users work efficiently and keeps a change log containing which users made what changes.

Nacoma stores it's settings in a MySQL database and compiles Naemon configuration files for objects after each save.

It's currently embedded inside Ninja and works as the back-end for object configuration in the HTTP API.

### HTTP API -

The HTTP API provides a RESTful interface for interacting with Monitor.
It can be used to query the status of hosts and services, extract event information and performance metrics, submit check results, change configuration and similar.

The HTTP API is a great tool for build integrations with third-party systems like reporting engines, management systems and dashboards.

#### Additional information

- HOW-TO: Submitting status updates through the HTTP API
