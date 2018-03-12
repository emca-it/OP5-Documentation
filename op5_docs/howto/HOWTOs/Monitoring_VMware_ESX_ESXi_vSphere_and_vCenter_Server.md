# Monitoring VMware ESX, ESXi, vSphere and vCenter Server

# Purpose

The purpose of this article is to describe how [OP5 Monitor](http://www.op5.com/explore-op5-monitor/), [Naemon](http://www.naemon.org/) or Nagios can be used with the [Check VMware API Plugin](https://github.com/op5/check_vmware_api) to monitor your VMware ESX(i) and vCenter servers. You may monitor either a single ESX(i) server or a VMware vCenter Server as well as individual virtual machines.

More information can be found in [Monitor Virtual Infrastructure with OP5 Monitor](https://www.op5.com/op5-monitor/virtual-monitoring/) and in the document [What can you monitor in a VMware Server/cluster?](https://kb.op5.com/pages/viewpage.action?pageId=3801484)

## What can be monitored?

-   VMware vCenter (datacenter)
-   VMware ESX(i) hosts
-   VMware ESX(i) hosts through a vCenter
-   VMware virtual machines on hosts
-   VMware virtual machines through a vCenter

**Monitoring VMware servers with OP5 Monitor:**

In the video below I will give you a tour on how to monitor VMware’s virtualization platform. OP5 Monitor enables you to keep an eye on all aspects of your VMware environment such as hardware status, cluster utilization and the health of individual virtual machines. By monitoring your VMware environment you can find issues, watch utilization or plan for future upgrades. People and other systems in your organization often relies on your VMware servers, which makes it crucial to ensure their uptime.

[![Get Adobe Flash player](https://www.adobe.com/images/shared/download_buttons/get_flash_player.gif)](https://get.adobe.com/flashplayer/)

# Prerequisites

Before you start you need to make sure you have an account on the VMware server with correct access rights. In the default installation of VMware ESX/vSphere there is a *read only* profile you should use when creating a new user. That profile has sufficient rights to be used for monitoring. The newly created user should be a member of the *user *group ** based on the *read only* profile. You must also install the VMware vSphere SDK for Perl on your OP5 Monitor server.

 

# VMware vSphere SDK for Perl Installation

See [README on GitHub](https://github.com/op5/check_vmware_api)

Appliance System 6

Since OP5 Appliance System 6.0 the above dependencies are preinstalled.

# Upgrading the VMware vSphere SDK

Just follow the same instructions as for installation as per the [README on GitHub](https://github.com/op5/check_vmware_api), vmware-install.pl will uninstall any previous version and then install the latest.

 

# Management Packs

The easiest way of setting up monitoring of your VMware environment is by using Management Packs. Here's a [short video explaining how Management Packs and the Host Wizard works](#).

To set up monitoring of a VMware ESXi virtualization host using the Host Wizard, select the device type called *Standalone VMware ESXi virtualization*. The monitoring will include:

-   CPU usage
-   Memory usage
-   I/O read latency
-   I/O write latency
-   Runtime health
-   Runtime issues
-   Runtime status

# Check commands

 In recent versions of OP5 Monitor, check commands for VMware monitoring are available out of the box. However, if you were previously running an old version of OP5 Monitor, and then upgraded to a more recent version, you might need to run a check command import to get hold of all the check commands. To verify that you have the latest check commands available, view the *Check command import *page, which is found via the main configuration page of OP5 Monitor.

## Check command categories

Browsing the list of check commands in OP5 Monitor, you should find a large list of check commands prefixed *check\_vmware\_api*. There are four main categories of these check commands.

-   **check\_vmware\_api\_dc\_host** – check commands for ESX/vSphere hosts through your Datacenter/vCenter*
    *
-   **check\_vmware\_api\_dc\_vm** – check commands for virtual machines through your Datacenter/vCenter
-   **check\_vmware\_api\_host** – check commands for ESX(i)/vSphere hosts
-   **check\_vmware\_api\_host\_vm** – check commands  for virtual machines on ESX(i)/vSphere servers**
    **

Each of these categories contains subcategories such as CPU, Disk I/O, Memory and Network I/O.

# Authentication

Starting with version 5 of VMware, a username can be joined by a domain name. To do this, two different ways of formatting are accepted for the username:

-   domain\\username
-   user@domain

Although both ways of formatting should work, the latter is recommended since it does not require any sort of additional quoting. In the former case, backslash must be quoted appropriately (shell-wise), or escaped with an additional backslash.

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

