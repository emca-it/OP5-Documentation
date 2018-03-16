# How to Upgrade to OP5 Monitor 6.0

This article describes how to upgrade to OP5 Monitor 6.

# Known issues

Here can articles about known issues be found: <http://www.op5.com/blog/support-news/known-issues/>

# Good to know

-   Basic Linux knowledge is required.
-   The LDAP authentication is totally rewritten, if you are using an LDAP integration with OP5 Monitor today your configuration will be converted. Make sure to read the manual on LDAP integration and go through your configuration after the upgrade to make sure everything is working.

# Preparations

1.  Download the latest Appliance System 6 (op5 APS) and OP5 Monitor 6 from <http://www.op5.com/get-op5-monitor/download/>
2.  Burn the ISO image on a CD.

# Upgrade old system

Before we can install the new version we have to make sure the old server is up to date so that the backup will include everything. If you are using a OP5 Monitor below version 5.2.0 please follow the [upgrade path how-to](http://www.op5.com/how-to/upgrade-paths-for-op5-products/) first.****
****

1.  Run the following command to upgrade the system to latest version
    1.  *\# yum clean all*
    2.  *\# yum upgrade*
    3.  Answer yes if any updates are available

2.  Verify that you have backup version 4.0.0 and OP5 Monitor version 5.8.4
     *\# rpm -qa |egrep ‘monitor-release|backup’*

## Upgrade offline system

If you do not have access to the internet from your OP5 server, follow these steps to do an offline upgrade.

You need to download and get the following files to the OP5 Monitor server:
 <http://repos.op5.com/centos/5/x86_64/system-addons/3.0/updates/perl-Config-Simple-4.59-1.el5.rf.noarch.rpm>
 <http://repos.op5.com/centos/5/x86_64/system-addons/3.0/updates/op5backup-2.2.0-op5.1.noarch.rpm>
 <http://repos.op5.com/centos/5/x86_64/monitor/5/updates/op5-monitor-repo-config-5.7.3.3-op5.1.noarch.rpm>
 <http://repos.op5.com/centos/5/x86_64/monitor/5/updates/op5-monitor-release-5.7.3.3-op5.1.noarch.rpm>

Note: If you are using a 32-bit system please change x86\_64 to i386 in the URLs above.

Install them with:
 *\# rpm -Uvh package\_name.rpm*

# Backup old system

Use one of the following options to backup your old system. Either there is already a backup script configured using op5-backup and we will use these settings or we do a backup with new settings.

## Using default settings

This will create a backup according to the settings in */etc/op5-backup/main.conf*
 (default is a local backup to */root*).

To create a migration backup run the backup command with the -g argument.
 *\# op5-backup -g*

The backup will now be created, check that the backup completes successfully****
****

## Using new settings

In this step we will create a backup to a specific location, overriding the settings in */etc/op5-backup/main.conf*****
****

1.  To start the interactive backup start the op5-backup script with the -i argument.
     *\# op5-backup -i*
2.  Choose to create migration backup
3.  Select yes to override the settings in */etc/op5-backup/main.conf*
4.  Choose where to put the backup.
    1.  If you choose ftp or sftp enter servername, path and username
    2.  if you choose local just enter local path

5.  Select yes to run the backup in the background.
6.  Verify the settings and select yes to start the backup
7.  Follow the backup log with
     *\# tail /var/log/op5-backup/backup–.log* You can use tab to autocomplete the date and time for the log file)

## Verify the backup

Verify that the backup file is OK by listing the files in the backup file.

*\# tar vft migration\_backup.-.backup*

**Note:** The complete name of the backup file can be found in the log-file */var/log/cron*.

If the backup file is complete it will list the files in the backup file like this:****
****

## Backup acknowledgement and current state

If you would like to backup acknowledgements and a hosts/service current state stop OP5 Monitor with
 *\# mon stop*

Copy the following file off the server

*/opt/monitor/var/status.sav*

Restart OP5 Montor

*\# mon start*

## Move backup file from the old server

This is VERY important, if you are using a local backup, make sure that you copy the migration backup file off the old server to a network share on your local computer. Or why not both?****
****

# Upgrade to APS 6.0 and Monitor 6.0

Before the upgrade to APS 6.0 make sure that you have completed the upgrade of the old system and a backup has been created and moved off the server.

There are four step you will have to complete. The VMware Perl SDK installation is only needed if you are using any VMware checks.

-   APS installation (OS installation)
-   Monitor installation
-   VMware Perl SDK installation (only if using VMware checks)
-   Restore old configuration.

These are described below and should be done in this order.

## APS installation

1.  Insert the CD with APS 6.0
2.  Reboot the server and start from the CD
3.  Press arrow down then enter to select “install”. Do not click on anything until the server has rebooted.
4.  Login to APS 6.0 as root, using the default password (monitor)

## OP5 Monitor installation

1.  Copy the monitor tar-file to */root*
2.  Extract the file using:
     *\# tar zxfv op5-monitor-.tar.gz*
3.  Go to the newly created OP5 Monitor folder
     \# cd op5-monitor-
4.  Start the installation
     *\# ./install.sh*

## VMware Perl SDK installation

This step is only needed if you are using any VMware checks.

Follow the instructions in this how-to: [How to Install VMware vSphere SDK for Perl](How_to_Install_VMware_vSphere_SDK_for_Perl)

## Restore old configuration

1.  Copy the migration backup file to */root*
2.  Restore the backup
     *\# op5-restore -b /root/migration\_backup.-.backup*
3.  Answer yes to restart network
4.  Answer yes to run the restore in the background
5.  Re-install the licence file
6.  Install the licence file using the portal GUI. See manual for instructions.
     or use the command line to re-install the licence.
     *\# mv /etc/op5license/op5license.xml /root
    * *\# op5license-install /root/op5license.xml*
7.  Do a *\# yum update* to install the latest patches. **Important for a peered environment!**
8.  Reboot server
9.  Restore host/service states
     Stop OP5 Monitor
     *\# mon stop*
     Copy status.sav back to */opt/monitor/var/* and restart op5
     *\# mon start *

## Post setup

1.  Reinstall sms-tools, only if no SMS-notification is sent out.
     *\# yum reinstall smstools *

**Congratulations, you are now running OP5 Monitor 6.0 and APS 6.0!**

## Upgrade Monitor 6.0

The [Upgrade path for OP5 Monitor 6](Upgrade_path_for_op5_Monitor_6) describes how to upgrade Monitor 6.0 to the latest version.

