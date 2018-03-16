# Reverting a ramdisk enabled setup back to the default non-ramdisk layout

## **Introduction**

Some OP5 Monitor systems have been configured with a so called *ramdisk*, which is used for various heavy disk I/O operations. With recent versions of OP5 Monitor (version 6 and more recent), such operations are much less common. Currently, the ramdisk (if enabled) will mostly be used by performance data processing (which ends up as graph data). This article explains how to return to the default settings by disabling the ramdisk setup.

 

## **Prerequisites**

Before we can start configuring the system, you need to make sure that:

-   You are running OP5 Monitor version 6 or later.
-   You have root access to your OP5 Monitor system.
-   You are experienced in using Linux, terminal shells and SSH.
-   No one but you is currently administrating the OP5 Monitor system.
-   There is a recent backup of the system available.
-   You are aware of that the OP5 Monitor system will temporarily be put offline (monitoring wise).

 

## ****Web configuration interface (Nacoma)
****

1.  Log on to your OP5 Monitor system via the web and enter the configuration interface.
2.  Enter the Commands page.
3.  Select the *`process-host-perfdata`* command.
4.  Make sure that its command line is set as follows.
    `/bin/mv /opt/monitor/var/host-perfdata /opt/monitor/var/spool/perfdata/host_perfdata.$TIMET$`
5.  Now select the *`process-service-perfdata`* command.
6.  Make sure that its command line is set as follows:
    `/bin/mv /opt/monitor/var/service-perfdata /opt/monitor/var/spool/perfdata/service-perfdata.$TIMET$`
7.  Save the configuration if any changes were performed.

 

**It is very important that the above steps have been successfully completed BEFORE any of the additional steps found below.**

## **System settings (SSH)
**

1.  Log on to your OP5 Monitor system as root via SSH.
2.  Stop processing of raw performance data files. Leaving this process stopped and not continuing with the steps found below will fill up the ramdisk with unprocessed performance data. This would be bad for several reasons; please continue with the next steps without any longer breaks.
    `/etc/init.d/npcd stop`
3.  Reset the performance data location setting in npcd's configuration file back to its original state.
    `sed -i -r 's|^(perfdata_spool_dir[[:space:]]*=[[:space:]]*).*$|\1/opt/monitor/var/spool/perfdata/|' /opt/monitor/etc/pnp/npcd.cfg`
4.  Disable the ramdisk initialization variable in the init script's resource file.
    `sed -i -r 's|^(USE_RAMDISK)=.*$|\1=0|' /etc/sysconfig/monitor`
5.  Temporarily shut down OP5 Monitor.
    `mon stop`
6.  Reset the performance data settings in the main Nagios configuration back to their original states.
    `sed -i -r 's|^(check_result_path)[[:space:]]*=.*$|\1=/opt/monitor/var/spool/checkresults|' /opt/monitor/etc/nagios.cfg`
    `sed -i -r 's|^(service_perfdata_file)[[:space:]]*=.*$|\1=/opt/monitor/var/service-perfdata|' /opt/monitor/etc/nagios.cfg`
    `sed -i -r 's|^(host_perfdata_file)[[:space:]]*=.*$|\1=/opt/monitor/var/host-perfdata|' /opt/monitor/etc/nagios.cfg`
7.  Move any unprocessed performance data files away from the ramdisk onto the ordinary filesystem.
    `find /dev/shm/monitor/var/spool/perfdata -mindepth 1 -maxdepth 1 -type f -execdir mv '{}' /opt/monitor/var/spool/perfdata/ \;`
    `f='/dev/shm/monitor/var/host-perfdata'; [ -f "$f" ] && 'mv' -v "$f" /opt/monitor/var/`
    `f='/dev/shm/monitor/var/service-perfdata'; [ -f "$f" ] && 'mv' -v "$f" /opt/monitor/var/`
8.  Start OP5 Monitor again.
    `mon start`
9.  Finally start the npcd service again to restart the performance data processing.
    `/etc/init.d/npcd start`

     

## **Verifying that it works**

1.  Have a look at Nagios' two main performance data files. It should look like the files are repeatedly being written to (growing in size), and then afterwards being emptied (truncated to zero bytes). The command below will list the files every second until aborted (by the Ctrl+C key combination).
    `watch -n1 ls -l /opt/monitor/var/{host,service}-perfdata`You should also notice the file timestamps being updated.
    In case the files are never being updated at all, make sure that the main configuration file (nagios.cfg) was updated accordingly, and that OP5 Monitor has been started.
    In case the files are being updated, but only steadily growing in size and never being truncated to zero bytes, something is wrong with the command object configuration. Verify that the steps in the *Web configuration interface (Nacoma)* section above were properly executed. If those steps were not successfully completed - **all** the following steps, including the ones in *System Settings (SSH)* **should be repeated**.
2.  Have a look at npcd's spool directory. The command below will find all files in the directory and show how many files there are of each type. This time you should be seeing files named *host\_perfdata.* and *service\_perfdata.* pop up and then disappear, over and over again.
    `watch -n1 find /opt/monitor/var/spool/perfdata -maxdepth 1 -type f \| sed 's/[0-9]*//g' \| sort \| uniq -c \| sort -n`

    If your system is not running that many checks, it might be easier to just run a simple list of files:
    `watch -n1 ls -l /opt/monitor/var/spool/perfdata`
    In case no files shows up, there is still something wrong with the command object configuration as described in the previous step.
    In case the files are continuously increasing, something is wrong with the npcd service. Make sure that it was configured properly according to the steps above and that the service is up and running.
    In case you find some files named with a *PID* suffix, this is another issue, not related to reverting the ramdisk setup. It might still be important to investigate this in case the files are new, and especially if they are rapidly increasing in numbers. Contact OP5 Support for further troubleshooting.

3.  Finally, simply make sure that your graphs of your service checks looks fine within the OP5 Monitor web interface. Depending on your setup and your check intervals etc. it might look like the graphs are not being updated. You should probably give it some time before beginning to troubleshoot.


