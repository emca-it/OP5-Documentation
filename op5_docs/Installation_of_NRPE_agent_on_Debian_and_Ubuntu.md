# Installation of NRPE agent on Debian and Ubuntu

This article intends to give the reader a brief introduction on how to install and configure the EPEL upstream version of the NRPE agent on Debian Linux 6, 7, 8 and Ubuntu 16.04.2 LTS.

Historically, OP5 has compiled and packaged the NRPE agent for a large number of Linux distributions, but as per Q2 2014 we stopped doing this since it required a lot of maintenance and time. More information on this decision can be found here: <https://www.op5.com/blog/blogs/op5-developers-blog/deprecation-notices-q2-2014/>

 

Note that this article is intended for Debian 6, 7, 8 and Ubuntu 16.04 **client hosts**, and that these steps never should be performed on an OP5 Monitor server.

## Step-by-step guide

 

1. Install the NRPE package together with plugins:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# apt-get install nagios-nrpe-server nagios-plugins-basic
```

 

2. Create a new file called **/etc/nagios/nrpe.d/op5\_commands.cfg** containing the following information:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
################################################################################
#
# op5-nrpe command configuration file
#
# COMMAND DEFINITIONS
# Syntax:
#       command[<command_name>]=<command_line>
#
command[users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[swap]=/usr/lib/nagios/plugins/check_swap -w 20% -c 10%
command[root_disk]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p / -m
command[usr_disk]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /usr -m
command[var_disk]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /var -m
command[zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[total_procs]=/usr/lib/nagios/plugins/check_procs -w 190 -c 200
command[proc_named]=/usr/lib/nagios/plugins/check_procs -w 1: -c 1:2 -C named
command[proc_crond]=/usr/lib/nagios/plugins/check_procs -w 1: -c 1:5 -C cron
command[proc_syslogd]=/usr/lib/nagios/plugins/check_procs -w 1: -c 1:2 -C syslog-ng
command[proc_rsyslogd]=/usr/lib/nagios/plugins/check_procs -w 1: -c 1:2 -C rsyslogd
```

These paths to the plugins should match the paths to the installed plugins in step 1.

 

3. Now edit /**etc/nagios/nrpe.cfg** and add your Monitor server(s) address(es) to the *allowed\_hosts* parameter as a comma-separated list in the appropriate section:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
allowed_hosts=127.0.0.1,10.0.0.10,10.0.0.11
```

 

4. Restart the nrpe agent on the host:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# /etc/init.d/nagios-nrpe-server restart
```

 

Now you can add the services via the function "Add UNIX client services" when adding a host in OP5 Monitor.

 

If the host is behind a firewall, or you have enabled firewall software on the host, you need to open for incoming traffic on TCP port 5666.

 

# Linux server monitoring with SNMPv3

An alternative path as we recommend today is to use the SNMP (v3) protocol to monitor Linux hosts for added security. You can find how to setup that here: [Monitoring Linux/Unix servers via SNMP](Monitoring_Linux_Unix_servers_via_SNMP)

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

## Related articles

-   Page:
    [Using eventhandlers to restart services](/display/HOWTOs/Using+eventhandlers+to+restart+services)
-   Page:
    [Monitoring Dell servers](/display/HOWTOs/Monitoring+Dell+servers)
-   Page:
    [Installation of NRPE agent on SLES](/display/HOWTOs/Installation+of+NRPE+agent+on+SLES)
-   Page:
    [Running plugins with NRPE as root or another user](/display/HOWTOs/Running+plugins+with+NRPE+as+root+or+another+user)
-   Page:
    [Installation of NRPE agent on Debian and Ubuntu](/display/HOWTOs/Installation+of+NRPE+agent+on+Debian+and+Ubuntu)

