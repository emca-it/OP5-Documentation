# Monitoring Linux/Unix servers via SNMP

For some servers it's unsuitable to install a specific agent that allows retrieval of information such as memory usage, system load and disk usage. Fortunately, many such servers come with the net-snmp software either pre-packaged or pre-installed. This article explains how to utilize SNMP to monitor such servers. Note that the information given here should work on all SNMP-enabled servers, but Microsoft recommends against using it on Windows boxen, so this article will focus on Linux/Unix servers.

## 1 - Configure the host's SNMP daemon

This is necessary in order for the host to respond to our queries. Following the HowTo article [Configure a Linux server for SNMP monitoring](Configure_a_Linux_server_for_SNMP_monitoring) will prepare the target host for monitoring. For the remainder of this article, we'll assume that you've followed those steps. You should, however, replace **authPass** and **privPass** here with the passwords you chose when configuring your server for monitoring.

## 2 - Add the server as a host in OP5 Monitor

This step is explained in great detail in the manual pages detailing how to use the [configuring](https://kb.op5.com/display/DOC/configuring), although you may want to use the [Host Wizard](https://kb.op5.com/display/DOC/Host+Wizard) to add one or more hosts to your OP5 Monitoring system.

## 3 - Configure the SNMP checks

The server-specific SNMP based checks primarily relate to checking things such as **cpu load**, **memory** **utilization**, **disk utilization** and **processes**. These are the areas we primarily recommend checking.

- CPU - Malfunctioning or suboptimally configured software tends to utilize inordinate amounts of CPU
- Memory - Running out of memory can cause system and/or process crashes
- Disk usage - Full disks spell trouble on most servers
- Processes - A computer without processes is worse than useless. Make sure yours are running.

Using the OP5 Monitor Configuration Tool, you have the option to add new services to a host. How to do so is explained in the manual for the [configuring](https://kb.op5.com/display/DOC/configuring). Briefly though; A check-command is used to create a particular check. The complete list of server-specific unix/linux checkcommands as of 2015-08-16 is listed below. There are other SNMP based checks that can be performed against servers, but some of them are vendor specific (such as chassis temperature etc), and some of them are explained elsewhere or have great tool support in the configuration tool (such as network traffic checks).

### Configuring checks using SNMP v3

Setting up all the parameters required for using SNMP can be a daunting task, and creating separate check commands for all possible variations would quickly become unwieldy. Because of that, we have chosen to use a less rigid format for SNMP v3 checks which allows you, the user, to pass command-line arguments specifically for SNMP v3 authentication and encryption directly to the plugins. Keep in mind that (almost) all checks in OP5 Monitor are executed by plugins, which are basically small scripts and programs that tend to perform one small task (although sometimes in a couple of different ways) quickly and efficiently.

The relevant help-text section for SNMP v3 plugin parameters follows:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
 -L, --seclevel=[noAuthNoPriv|authNoPriv|authPriv]
    SNMPv3 securityLevel
 -U, --secname=USERNAME
    SNMPv3 username
 -a, --authproto=[MD5|SHA]
    SNMPv3 auth proto
 -A, --authpassword=PASSWORD
    SNMPv3 authentication password
 -x, --privproto=[DES|AES]
    SNMPv3 priv proto (default DES)
 -X, --privpasswd=PASSWORD
    SNMPv3 privacy password
```

AES is the default encryption method (--privproto). We strongly recommend that you do not use DES, as DES is easily crackable by brute force. SHA is the default authentication protocol (–authproto). We recommend that you use the SHA HMAC authentication, as MD5 is both slower and less secure. If no --privproto or --authproto is used, the default settings will be used instead. The default --seclevel is determined by the passwords provided. If --authpassword is set but --privasswd is not, we assume **authNoPriv**. If Both --authpassword and --privpasswd are set, we assume **authPriv**. If neither is set, we assume **noAuthNoPriv**. This leads to a very handy situation where all you really have to provide is the SNMP v3 username (--secname) and whichever of the two passwords you have set in order for SNMP v3 authentication and encryption to work properly.

Because there are so many different combinations of SNMP v3 authentication mechanisms, we have opted to create only one check command for SNMP v3 per metric we can measure. An example of a suitable command\_line\_args string for SNMP v3 with the same warning and critical thresholds as above would read as follows (assuming your SNMP v3 username is **snmp\_user** and you have **authPass** as your authentication password and **privPass** as your privacy password; We obviously recommend that you choose other passwords yourself):

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
--secname 'snmp_user' --authpassword 'authPass' --privpasswd 'privPass'!1!2
```

### Configuring checks using SNMP v2c

The SNMP v2 checks require a community name to be specified in order to be accessed. The community name is always the first argument for all SNMP v2 checks. The default community name for SNMP installations is "public", as per common consent and legacy reasons. We obviously recommend that you change that. Assuming you change it to **community**, the string below represents one likely setting for the **command\_line\_args** used to configure options for the plugin used to perform the check that results in the service's status and message. Note that the rest of the arguments are warning and critical thresholds and have to be tweaked to suit your specific environment and the type of check you're running.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
community!1!2
```

Note that we don't recommend using SNMP v2c, since it doesn't allow for strong authentication or encryption of the traffic.

## Choose what to monitor

Below is a list of all server specific but vendor generic checkcommands provided by default. The list is exhaustive as of OP5 Monitor version 7.1.0.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
check_snmp_cpu_custom
check_snmp_cpu_iowait_v2
check_snmp_cpu_iowait_v3
check_snmp_cpu_load15_v2
check_snmp_cpu_load15_v3
check_snmp_cpu_load1_v2
check_snmp_cpu_load1_v3
check_snmp_cpu_load5_v2
check_snmp_cpu_load5_v3
check_snmp_cpu_load_v2
check_snmp_cpu_load_v3
check_snmp_disk_custom
check_snmp_disk_io_15_min_average_v2
check_snmp_disk_io_15_min_average_v3
check_snmp_disk_io_1_min_average_v2
check_snmp_disk_io_1_min_average_v3
check_snmp_disk_io_5_min_average_v2
check_snmp_disk_io_5_min_average_v3
check_snmp_disk_list_available_disks_v2
check_snmp_disk_list_available_disks_v3
check_snmp_disk_list_available_io_v2
check_snmp_disk_list_available_io_v3
check_snmp_disk_mb_left_v2
check_snmp_disk_mb_left_v3
check_snmp_disk_mb_used_v2
check_snmp_disk_mb_used_v3
check_snmp_disk_percent_left_v2
check_snmp_disk_percent_left_v3
check_snmp_disk_percent_used_v2
check_snmp_disk_percent_used_v3
check_snmp_memory_buffer_v2
check_snmp_memory_buffer_v3
check_snmp_memory_cached_v2
check_snmp_memory_cached_v3
check_snmp_memory_custom
check_snmp_memory_free_v2
check_snmp_memory_free_v3
check_snmp_memory_swap_v2
check_snmp_memory_swap_v3
check_snmp_memory_used_v2
check_snmp_memory_used_v3
check_snmp_procs_cron_v2
check_snmp_procs_cron_v3
check_snmp_procs_custom
check_snmp_procs_process_by_name_v2
check_snmp_procs_process_by_name_v3
check_snmp_procs_syslog_v2
check_snmp_procs_syslog_v3
```

## Related articles

- Page:
    [Getting started with OP5 Monitor](/display/HOWTOs/Getting+started+with+op5+Monitor)
- Page:
    [Monitoring Dell servers](/display/HOWTOs/Monitoring+Dell+servers)
- Page:
    [Configure a Linux server for SNMP monitoring](/display/HOWTOs/Configure+a+Linux+server+for+SNMP+monitoring)
- Page:
    [How to configure OP5 Trapper Extension (Cisco handler)](../HOWTOs/How_to_configure_op5_Trapper_Extension_Cisco_handler_)
- Page:
    [Migrate Monitor 7 from EL6 to EL7](/display/HOWTOs/Migrate+Monitor+7+from+EL6+to+EL7)
