# Nagios Remote Plugin Executor (NRPE)

## About 

The Nagios Remote Plugin Executor (NRPE) is an agent for Linux/Unix-like systems used to execute Nagios compatible plugins on systems external to the OP5 Monitor server, or it can be used to run active checks on systems OP5 Monitor cannot reach. NRPE also allows the checks to be offload to a separate host, which frees up resources on the OP5 Monitor host. 

## Overview

There can be up to three parts when using NRPE.

1. OP5 Monitor
2. NRPE host or NRPE bastion host
3. Outpost server(s)

*OP5 Monitor* is the OP5 Monitor installation which NRPE will send results to. This could be a OP5 Monitor Poller or it could be an OP5 Monitor Master. The exact details will depend on the architecture of the system.

*NRPE host* refers to the local system which is hosting the NRPE install, and it is the system which will do all of the work needed by the checks. It will run the checks, process the results, and send the results back to the *OP5 Monitor*. When NRPE is used to report on servers inaccessible to *OP5 Monitor*, the *NRPE host* is considered an *NRPE bastion host*. By using an NRPE bastion host, NRPE can facilitate monitoring services and servers which would otherwise be invisible to *OP5 Monitor*.

*Outpost servers* are servers which are accessible to the *NRPE bastion host* and inaccessible to *OP5 Monitor*. NRPE will run active checks against remotely accessible services on the *Outpost servers*, and send the results back to *OP5 Monitor*.

[Note: The remote services need to be accessible to the *NRPE bastion host*. This could mean the service is publicly available, or it could mean the services is only available to select hosts.]

NRPE has two types of checks: 

* Direct 
* Indirect 

*Direct* checks will run against the *NRPE host*, and they can report on local resources and services. *Direct* checks can report in more detail since they have greater access to the system then *Indirect* checks do.

*Indirect* checks will run against publicly accessible services on *Outpost servers*. By using *Indirect* checks, OP5 Monitor can monitor systems and services which it couldn't due to various restrictions. *Indirect* checks don't have the same level of detail available to *Direct* checks since they are limited to relying on whatever the monitored service can provide.

## Working with NRPE

### Installing NRPE

1. Login to the server via SSH.
2. Install the EPEL package.
    * CentOS 6/7   
        
        ```
        yum install epel-release
        ```
    * Red Hat Enterprise Linux 6 (RHEL6) (Enable `optional` repository subscription first.)
        
        ```
        yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
        ```
    * Red Hat Enterprise Linux 7 (RHEL7) (Enable `optional` repository subscription first.)

        ```
        yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        ```
3. Install NRPE and a basic set of plugins.
    
    ```
    yum install nrpe \
                nagios-plugins-users \
                nagios-plugins-swap \
                nagios-plugins-disk \
                nagios-plugins-procs \
                nagios-plugins-load \
                Nagios-plugins-nrpe
    ```
4. Enable NRPE to start automatically when host boots.

    * RHEL/CentOS 7+

        ```
        systemctl enable nrpe
        ```
    * RHEL/CentOS 6

        ```
        chkconfig nrpe on
        ```
5. Next, start the NRPE service.
    * RHEL/CentOS 7+
    
        ```
        systemctl start nrpe
        ```
    * RHEL/CentOS 6
    
        ```
        service nrpe start
        ```
6. Finally, open the NRPE port in the firewall to allow traffic through. 

    [Warning: There maybe multiple firewalls between OP5 Monitor and the NRPE host. There could be a firewall on the NRPE host, and there could be firewall devices on the network. All of the firewalls will need to be configured to allow NRPE traffic to pass.]
    
    [Note: By default, NRPE listens on port 5666, but the port can be changed in the `nrpe.cfg` file.]
    
    Instructions for opening the NRPE port on the default firewall in RHEL and CentOS are below.
    
    * RHEL/CentOS 7+

        ```
        firewall-cmd --permanent --add-service=nrpe
        firewall-cmd --reload
        ```
    * RHEL/CentOS 6
    
        ```
        iptables -I INPUT -p tcp -m tcp --dport 5666 -j ACCEPT
        service iptables save
        ```

### Configure NRPE

1. Login to the server via SSH.
2. Edit `nrpe.cfg` to allow OP5 Monitor to access NRPE and send it arguments options.

    ```
    vim /etc/nagios/nrpe.cfg
    
    allowed_hosts=<ip_address>,<ip_address>,127.0.0.1,::1
    dont_blame_nrpe=1
    ```
    * `allowed_hosts` is a comma separated list of IP addresses, hostnames, or network ranges which are able to access the NRPE client. When run under the systemd init system (RHEL/CentOS 7+), inetd, or xinetd, this option has no affect. 
    
        [Note: The list cannot contain whitespace. `1.1.3.4, 1.1.3.5` will fail, but `2.2.3.4,2.2.3.5` will work.]
    
    * `dont_blame_nrpe` being set to `1` allows OP5 Monitor to send arguments to NRPE.

3. Create `op5_commands.cfg` file and create several direct checks.
    
    ```
    vim /etc/nrpe.d/op5_commands.cfg
    
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
4. Restart the NRPE service to activate the new configuration.
    * RHEL/CentOS 7+
    
        ```
        systemctl restart nrpe
        ```
    * RHEL/CentOS 6

        ```
        service nrpe restart
        ```
5. To check and make sure the NRPE service is running, run the `check_nrpe` command against the localhost.

    ```
    /usr/lib64/nagios/plugins/check_nrpe -H localhost
    ```
6. At this point, host is ready to be added to OP5 Monitor.
