# NRPE on IBM AIX

- [Introduction](#NRPEonIBMAIX-Introduction)
- [Installation](#NRPEonIBMAIX-Installation)
  - [Download and install packages](#NRPEonIBMAIX-Downloadandinstallpackages)
  - [Configure NRPE](#NRPEonIBMAIX-ConfigureNRPE)
  - [Create a nrpe.cfg file](#NRPEonIBMAIX-Createanrpe.cfgfile)
  - [Create a commands configuration](#NRPEonIBMAIX-Createacommandsconfiguration)
  - [Restart NRPE to load new settings](#NRPEonIBMAIX-RestartNRPEtoloadnewsettings)
  - [Make NRPE start at boot by linking it to run-level 2](#NRPEonIBMAIX-MakeNRPEstartatbootbylinkingittorun-level2)

# Introduction

Instructions to install NRPE agent & NRPE Plugins on IBM AIX.
This has been tested on AIX version 6.1 with 64-bit PowerPC architecture with successful result.

# Installation

#### Download and install packages

    NRPE:sudo rpm -ivh http://www.oss4aix.org/download/RPMS/nagios-nrpe/nagios-nrpe-2.15-1.aix5.1.ppc.rpm

    NRPE-plugins:sudo rpm -ivh http://www.oss4aix.org/download/RPMS/nagios-plugins/nagios-plugins-2.1.3-1.aix5.1.ppc.rpm

#### Configure NRPE

##### Create a nrpe.cfg file

    sudo touch /opt/freeware/etc/nagios-nrpe/nrpe.cfg

Example content for nrpe.cfg

    log_facility=daemonpid_file=/var/run/nrpe.pidserver_port=5666nrpe_user=nrpenrpe_group=nrpeallowed_hosts=<ADRESS-TO-MONITOR-SERVER>dont_blame_nrpe=0debug=0command_timeout=60connection_timeout=300include_dir=/opt/freeware/etc/nagios-nrpe/nrpe.d

##### Create a commands configuration

    sudo touch /opt/freeware/etc/nagios-nrpe/nrpe.d/op5_commands.cfg

Example content for op5\_commands.cfg:

    command[load]=/usr/libexec/nagios/check_load -w 2,3,4 -c 4,5,6command[users]=/usr/libexec/nagios/check_users -w 5 -c 10command[swap]=/usr/libexec/nagios/check_swap -w 20% -c 10%command[root_disk]=/usr/libexec/nagios/check_disk -w 20% -c 10% -p / -mcommand[procs_zombie]=/usr/libexec/nagios/check_procs -w 5 -c 10 -s Zcommand[procs_total]=/usr/libexec/nagios/check_procs -w 150 -c 200command[procs_init]=/usr/libexec/nagios/check_procs -w 1: -c 1:2 -C init

Example content for op5\_commands.cfg (with arguments allowed):
To use this you need to set *dont\_blame\_nrpe=1* in nrpe.cfg.

    command[load]=/usr/libexec/nagios/check_load -w $ARG1$ -c $ARG2$command[users]=/usr/libexec/nagios/check_users -w $ARG1$ -c $ARG2$command[swap]=/usr/libexec/nagios/check_swap -w $ARG1$ -c $ARG2$command[disk]=/usr/libexec/nagios/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$ –mcommand[procs_zombie]=/usr/libexec/nagios/check_procs -w $ARG1$ -c $ARG2$ -s Zcommand[procs_total]=/usr/libexec/nagios/check_procs -w $ARG1$ -c $ARG2$command[procs_name]=/usr/libexec/nagios/check_procs -w $ARG1$ -c $ARG2$ -C $ARG3$

##### Restart NRPE to load new settings

    sudo /etc/rc.d/init.d/nrpe restart

##### Make NRPE start at boot by linking it to run-level 2

    cd /etc/rc.d/rc2.d/ln -s ../init.d/nrpe S99nrpe

Host can now be added to OP5 Monitor and be monitored with check\_nrpe service-checks.
