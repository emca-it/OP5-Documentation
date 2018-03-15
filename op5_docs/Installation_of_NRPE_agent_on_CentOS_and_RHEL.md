# Installation of NRPE agent on CentOS and RHEL

This article intends to give the reader a brief introduction on how to install and configure the EPEL upstream version of the NRPE agent on CentOS/RHEL 6 and 7.

Historically, op5 has compiled and packaged the NRPE agent for a large number of Linux distributions, but as per Q2 2014 we stopped doing this since it required a lot of maintenance and time. More information on this decision can be found here: <https://www.op5.com/blog/blogs/op5-developers-blog/deprecation-notices-q2-2014/>

 

Note that this article is intended for CentOS/RHEL 6 and 7 **client hosts**, and that these steps never should be performed on an OP5 Monitor server.

## Step-by-step guide

 

1. Add the EPEL repository

**CentOS 6 and CentOS 7:**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# yum install epel-release
```

 

**RHEL 6:**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# yum install http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
```

**
**

**RHEL 7:**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

 

2. Install NRPE and the plugins that is required to add the services via the function "Add UNIX client services" when adding a new host in the configuration UI in op5 Monitor

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# yum install nrpe nagios-plugins-users nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs
```

 

 3. Configure the agent to utilize the plugins using commands supported by op5 Monitor host scan.

Create a new file called **/etc/nrpe.d**/**op5\_commands.cfg** containing the following information:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
################################################################################
#
# op5-nrpe command configuration file
#
# COMMAND DEFINITIONS
# Syntax:
#       command[<command_name>]=<command_line>
#
command[users]=/usr/lib64/nagios/plugins/check_users -w 5 -c 10
command[load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[root_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p / -m
command[usr_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /usr -m
command[var_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /var -m
command[zombie_procs]=/usr/lib64/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[total_procs]=/usr/lib64/nagios/plugins/check_procs -w 190 -c 200
command[proc_named]=/usr/lib64/nagios/plugins/check_procs -w 1: -c 1:2 -C named
command[proc_crond]=/usr/lib64/nagios/plugins/check_procs -w 1: -c 1:5 -C crond
command[proc_syslogd]=/usr/lib64/nagios/plugins/check_procs -w 1: -c 1:2 -C syslog-ng
command[proc_rsyslogd]=/usr/lib64/nagios/plugins/check_procs -w 1: -c 1:2 -C rsyslogd
```

These paths to the plugins should match the paths to the installed plugins in step \# 2.

 

4. Now edit /**etc/nagios/nrpe.cfg** and add your Monitor server(s) address(es) to the *allowed\_hosts* parameter as a comma-separated list, example:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
allowed_hosts=127.0.0.1,10.0.0.10,10.0.0.11
```

 

5. Restart the nrpe agent on the host, and make sure that nrpe is started at boot:

**CentOS/RHEL 6:**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# service nrpe restart
# chkconfig nrpe on
```

 

**CentOS/RHEL 7:**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# systemctl restart nrpe
# systemctl enable nrpe
```

 

Now you can add the services via the function "Add UNIX client services" when adding a host in OP5 Monitor.

 

If the host is behind a firewall, or you have enabled firewall software on the host, you need to open for incoming traffic on TCP port 5666.

 

# Linux server monitoring with SNMPv3

An alternative path as we recommend today is to use the SNMP (v3) protocol to monitor Linux hosts for added security. You can find how to setup that here: [Monitoring Linux/Unix servers via SNMP](Monitoring_Linux_Unix_servers_via_SNMP)

 

# OP5 Monitor: Open Source Network Monitoring

[OP5](https://www.op5.com)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

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

