# Install plugin check\_linux\_stats in Debian or Ubuntu

## Question

* * * * *

How do I install the plugin check\_linux\_stats in Debian or Ubuntu?

## Answer

* * * * *

Besides the plugin itself you will need to install the following packages to meet the dependencies: nagios-nrpe-server, nagios-plugins and libsys-statistics-linux-perl

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
sudo apt-get install nagios-nrpe-server nagios-plugins libsys-statistics-linux-perl
```

When the dependencies are met the plugin can be copied to the folder `/usr/lib/nagios/plugins` and executed via the nrpe agent.

 

Some example commands that can be configured on the Ubuntu/Debian host and called from op5 Monitor with the name of the command[name] via the check\_command "check\_nrpe".

Thresholds are just examples and should be adjusted to reflect the configuration of the server.

 

**linux-stats.cfg**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# Check memory & swap usage
command[check_mem]=/usr/lib/nagios/plugins/check_linux_stats.pl -M -w 100,25 -c 100,50
# Check cpu usage
command[check_cpu]=/usr/lib/nagios/plugins/check_linux_stats.pl -C -w 99 -c 100 -s 5
# Check open files
command[check_open_file]=/usr/lib/nagios/plugins/check_linux_stats.pl -F -w 15000,250000 -c 20000,350000
# Check io disk on device sda1, sda3 and sda4
command[check_io]=/usr/lib/nagios/plugins/check_linux_stats.pl -I -w 2000,600 -c 3000,800 -p sda1,sda3,sdb1,sdc1,sdd1 -s 5
# Check processes
command[check_procs]=/usr/lib/nagios/plugins/check_linux_stats.pl -P -w 1000 -c 2000
# Check network usage on eth0
command[check_net_eth0]=/usr/lib/nagios/plugins/check_linux_stats.pl -N -w 1000000 -c 1500000 -p eth0 -s 5
# Check socket usage
command[check_socket]=/usr/lib/nagios/plugins/check_linux_stats.pl -S -w 1000 -c 1200
# Check uptime 
command[check_uptime]=/usr/lib/nagios/plugins/check_linux_stats.pl -U -w 5
```

 

 

