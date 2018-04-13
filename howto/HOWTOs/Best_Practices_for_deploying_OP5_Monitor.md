# Best Practices for deploying OP5 Monitor

## **Introduction**

Everyone wants the best possible outcome when installing OP5 Monitor. We want to recommend some preparation steps as well as a specific but flexible order of action.

Nevertheless, we expect that you will need at least some (or perhaps a lot of) variance to make this work at your site. This document provides a structured workflow, one you can use verbatim or merely to inspire your internal documentation.

We ask that you read this document in full, print it, highlight it, scribble notes, spill some coffee on it, and use it as a reference -- for your own instructions. We would like our passion for monitoring to inspire your integration. This is not merely a checklist, but more of a conceptual document.

We hope to mold your approach to monitoring. With this document we have distilled our experiences from installing OP5 at many organizations in different industries and of varying sizes. We invite you to drink from these spirits.

## **Main Goals**

Deploying OP5 Monitor correctly should result in monitoring and getting useful alerts from the majority of hosts (your target servers and infrastructure) and the services they run. We start by thinking about hosts and sorting them into effective groups. Once you have clear groups of hosts, your engineers will have clearer ideas for immediate implementation and future additions.

## **Preparation** ** Steps**

Before you begin setting up a monitoring platform, we recommend that you collect whatever resources you need. This list need not be comprehensive, but should encompass:

- Objects --
  - hosts -- objects to monitor;
  - services -- the commands that give host status information;
  - contacts -- users and teams that will get alerts;
- third-party tools that will provide or receive status;
- login accounts to manage OP5 Monitor;
- reports you expect managers and others to read;
- the initial logical structure for grouping objects.

The below sections include some details about each of these areas, along with best practice considerations.

## Objects

Objects in OP5 Monitor include hosts, services, and contacts.

### Hosts

We suggest developing a list of specific hosts to monitor before the implementation. Your list should include the following:

- Hostname as a fully qualified domain name (FQDN) -- e.g.: 'server1.domain.com';
  - IP address;
  - Alias – usually the shortname for the host or its specialization, such as 'Server1-ABC-Customer';
  - Categories, such as Type, Location, and Function.

Later in this document, we will present additional groupings to consider. Keep revisiting your categories and their order of importance as you build your list of hosts.

There are a number of methods for adding hosts in bulk. Explore each of these methods to determine which is the best fit for your environment. Take the time to note any additional requirements that may make such organizing more obvious to your sites or teams:

- [Use an Import Script](Host-import_via_Excel_with_service_objects_cloning_and_auto-detection_of_disks)
  - Network Scans and Periodic Discovery – see [Managing Objects](https://kb.op5.com/display/DOC/Managing+objects)
  - API – We include the REST API documentation with the OP5 Monitor server's web pages. Visit https://{\$op5monhost}/api , replacing '{\$op5monhost}' with the FQDN for the OP5 Monitor.
  - **For Devops and rapidly changing environments** –

            As of version 7.3, we suggest adding or removing hosts in groups of 100 to 500. That group limit will depend on the performance of the hardware hosting your OP5 server. Note also that host deletion is far more resource-intense than host creation.

            Keep in mind that each addition or removal requires a configuration reload. For these more fluid environments, we suggest that administrators provision the OP5 server(s) with special attention to high-performance storage, sufficient CPU, and plentiful memory.

            If at any point there appears to be contention during automated management of hosts, we suggest that you review performance at the OP5 master tier before contacting support.

### Services

### Contacts & 3rd Party Operations Integration Permissions/Solutions

## Grouping Strategy

When you think about your environment, you can imagine how many servers, routers, and legacy devices make up the slices of the pie. You probably even have different pies at different sites: one office may be all routing equipment with two servers and sales staff; another may be a server farm with three floors of racked blades, PDUs, and HVAC units with serial ports.

Turning those categories into explicit groups is one of the most important steps to leveraging OP5 Monitor. If you also have geographically dispersed systems, or use Distributed Monitoring with pollers and peers, you'll need to have groups for those as well.

Therefore it's a good idea to map out these regions and categories at the start. Drawing out a nested set of groups will make clear which pollers will handle which hosts. There are no hard limits to the number of nested groups. Imagine an office in Dallas:

Hostgroup 'Dallas-TX'

Servers

Dell-Servers

HP-Servers

C-Blades

Network

Cisco-Routers

Juniper-Routers

Moxa-Serial-Consoles

Storage

NetApp-Storage

HP-MSAs

Here are some suggestions to determine which types of groups will suit you:

### Hostgroups

These can be specific to servers, switches, hardware with only IP addresses:

- Distribution - broken down by the local poller(s) which will monitor the devices
  - Geographic - building, municipality, state or province, country
  - Make - Juniper, Cisco, Dell, EMC, NetApp
  - Model - EX2200-POE24P, ISR4331-SEC-K9
  - Job - Edge\_Services, DNS\_Resolvers, Web\_Servers

### Service groups

Specific to services which run on the hosts

- CPU | Memory | Disk or Volume Usage - these are common utilization groups
  - Named Services, such as node.js, IIS, Apache, nginx, Citrix, OpenStack-Nova, OpenStack-Keystone, VMware vCenter

### Contact groups

We provide contact groups to avoid the problem of of assigning individual people or alert methods per host or service. This gives you another nest of groups: people or phone lines can belong to multiple contact groups. One of the most powerful features of contacts and contact groups are the individual configuration options, such as:

- notification periods -- when alerts can be sent
  - notification options -- which type of alerts to send, such as email or SMS

You can discover more about groups from this article describing [Groups in OP5 Monitor](https://kb.op5.com/display/DOC/Groups).

## System Hardware

We provide [recommended hardware specifics](https://www.op5.com/op5-monitor/system-requirements/) as a reference tool. While you are not required to select a specific vendor, we recommend being particular about disk performance. We have seen overactive environments, consumer-grade hardware, and sub-optimal disk configuration result in poor overall performance. This can lead to increased errors within the OP5 Monitor UI as well as the API.

## Performance Tuning

Before installing OP5 Monitor, please review the "System Hardware" recommendations above. Confirm that you are using the correct hardware or virtual resources for OP5 Monitor to work properly within your environment.

To analyze performance we recommend these free tools [link?] . They collect and review performance data prior to installing OP5 Monitor.

With OP5 Monitor installed, you can use our pre-configured check\_commands to monitor the OP5 Monitor servers as easily as any other target machine. Pay special attention to CPU, Memory, Disk Queue and disk I/O. The performance required for OP5 Monitor varies greatly based on the quantity of hosts, services, and types of services being monitored.

If you are interested in load testing your environment, please see the [documentation referencing load testing techniques](https://kb.op5.com/display/FAQ/Performance+tests+of+the+generation+7+appliance+servers) that we have used in our labs to determine system performance for OP5 Monitor appliances.

## API Usage

We provide a REST API to help you automate much of your monitoring operations. For this reason we recommend automating how you add hosts to OP5 Monitor through automation tools such as Ansible, Puppet, or Chef.

#### API within a multi-tenant/multi-team organization:

The user that submits additions or changes via the API's '/change' method will get attribution. This means an API call to the /change method will not commit other changes which are pending. The downside is that when a change and save is committed, Naemon will reload the configuration. If many API change or save calls are made at one time, or many automation tools are making adjustments to configuration, you could face performance degradation, noticeable errors, and many error messages within the UI while Naemon reloads and restarts. Thus we recommend selecting a single process to handle the queued actions.

## Recommended Practices

#### Backups

Backup OP5 Monitor frequently. One can get a full backup of an OP5 Monitor using the command 'op5-backup'. One can also tie this to a cron job. Files will be saved in '/root' unless specified within the op5-backup parameters [which file or args?] .

#### Configuration Management

In mission critical environments, we highly recommend tracking changes to Naemon configuration files. We also suggest automating such tracking by pushing changes to a version-controlled repository, such as Git or BitBucket. While this may happen several times per day, the records will reveal the times of changes as well as what changed. This would be pivotal in case one morning's changes need to be reviewed or backed out. The configuration files are also small enough that multiple daily check-ins would be worth the storage.
