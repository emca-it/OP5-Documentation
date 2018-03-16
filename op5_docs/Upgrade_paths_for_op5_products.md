# Upgrade paths for OP5 products

# Purpose of this document

This document lists the minimum number of system- and product-versions recommended to install when upgrading old installations to the latest versions.

Releases previous to 5.2 are considered deprecated. If you are upgrading from a version previous to 5.2 please contact OP5 to consult the upgrade before continuing.

-   [Purpose of this document](#Upgradepathsforop5products-Purposeofthisdocument)
-   [Minor Upgrades](#Upgradepathsforop5products-MinorUpgrades)
    -   [Yum upgrade](#Upgradepathsforop5products-Yumupgrade)
    -   [Portal page upgrade](#Upgradepathsforop5products-Portalpageupgrade)
-   [Major upgrades](#Upgradepathsforop5products-Majorupgrades)
    -   [Verify version](#Upgradepathsforop5products-Verifyversion)
    -   [Verify OS](#Upgradepathsforop5products-VerifyOS)
    -   [Upgrade ](#Upgradepathsforop5products-Upgrade)
    -   [Upgrade including OS upgrade](#Upgradepathsforop5products-UpgradeincludingOSupgrade)
-   [OS Upgrade](#Upgradepathsforop5products-OSUpgrade)
    -   [Known issues](#Upgradepathsforop5products-Knownissues)
    -   [Good to know](#Upgradepathsforop5products-Goodtoknow)
    -   [Preparations](#Upgradepathsforop5products-Preparations)
    -   [Upgrade old system](#Upgradepathsforop5products-Upgradeoldsystem)
    -   [Upgrade offline system](#Upgradepathsforop5products-Upgradeofflinesystem)
    -   [Backup old system](#Upgradepathsforop5products-Backupoldsystem)
    -   [Verify the backup](#Upgradepathsforop5products-Verifythebackup)
    -   [Move backup file from the old server](#Upgradepathsforop5products-Movebackupfilefromtheoldserver)
    -   [Upgrade to latest APS and Monitor](#Upgradepathsforop5products-UpgradetolatestAPSandMonitor)
    -   [APS installation](#Upgradepathsforop5products-APSinstallation)
    -   [op5 Monitor installation](#Upgradepathsforop5products-op5Monitorinstallation)
    -   [VMware Perl SDK installation](#Upgradepathsforop5products-VMwarePerlSDKinstallation)
    -   [Restore old configuration](#Upgradepathsforop5products-Restoreoldconfiguration)
    -   [Post setup](#Upgradepathsforop5products-Postsetup)

# Minor Upgrades

Minor upgrades within a major version is done via yum or via the OP5 portal page. The preferred way is however via yum.

## Yum upgrade

To upgrade OP5 Monitor via yum log in to the the console or via ssh.

To begin upgrading type:

\# yum clean all

\# yum upgrade

If there is any updates it will be show what is going to up updated and you get a question if you want to continue or not.

## Portal page upgrade

See manual for more information.

# Major upgrades

## Verify version

Before you upgrade to the next major version you need to verify that you are running the latest minor version of you release. This can be done by doing a minor upgrade.

The minimal version you need before continuing is version 5.8. If you do not have at least 5.8 please upgrade your installation before continuing. Either do a minor upgrade if you are on version 5.2, if you are running a version below 5.2 please contact OP5 for help with upgrading.

Major upgrades should always be done one major at the time, ie. if you are running version 5.8 you need to install the latest version of Monitor 6 before upgrading to version 7.

## Verify OS

You also need to be running on a 64-bit operating system and at least CentOS/RHEL 5.

If you are running a 32 bit OS or if you are on CentOS/RHEL 4 you need to upgrade your operating system as well.

## Upgrade 

1.  Download the latest version of OP5 Monitor from[ www.op5.com](http://www.op5.com/) to /root of your monitor server. It is the Free Software that you should download.

2.  Unpack the tar.gz file\# tar zxfv op5-monitor-X.X.X-YYYYY.tar.gz

3.  Go to the folder created\# cd op5-monitor-X.X.X 

4.  Start the upgrade by executing the install.sh script\# ./install.sh 

5.  After the upgrade is done, restart your server.\# reboot

## Upgrade including OS upgrade

Go to OS Upgrade for information on upgrading.

 

# OS Upgrade

## Known issues

Here can articles about known issues be found: http://www.op5.com/blog/support-news/known-issues/

## Good to know

-   Basic  Linux knowledge is required.

-   The LDAP authentication is totally rewritten after version 5.8, if you are using an LDAP integration with OP5 Monitor 5.8 or earlier your configuration will be converted. Make sure to read the manual on LDAP integration and go  through your configuration after the upgrade to make sure everything is working.

## Preparations

1.  Download the latest Appliance System (op5 APS) and OP5 Monitor from  http://www.op5.com/get-op5-monitor/download/

2.  Burn  the ISO image on a CD.

## Upgrade old system

Before we can install the new version we have to make sure the old server is up to date so that the backup will include everything. If you are using a op5

Monitor below version 5.2.0 please follow the upgrade path how-to first.

Run the following command to upgrade the system to latest version

\# yum clean all

\# yum upgrade

Answer yes if any updates are available

## Upgrade offline system

If you do not have access to the internet from your OP5 server, follow these steps to do an offline upgrade.

You need to download and get the following files to the OP5 Monitor server:

http://repos.op5.com/centos/5/x86\_64/system-addons/3.0/updates/perl-Config-Simple-4.59-1.el5.rf.noarch.rpm

http://repos.op5.com/centos/5/x86\_64/system-addons/3.0/updates/op5backup-2.2.0-op5.1.noarch.rpm

http://repos.op5.com/centos/5/x86\_64/monitor/5/updates/op5-monitor-repo-config-5.7.3.3-op5.1.noarch.rpm

http://repos.op5.com/centos/5/x86\_64/monitor/5/updates/op5-monitor-release-5.7.3.3-op5.1.noarch.rpm

Note: If you are using a 32-bit system please change x86\_64 to i386 in the URLs above.

Install them with:

\# rpm -Uvh package\_name.rpm

## Backup old system

Use one of the following options to backup your old system. Either there is already a backup script configured using op5-backup and we will use these settings or we do a backup with new settings.

### Using default settings

This will create a backup according to the settings in /etc/op5-backup/main.conf

(default is a local backup to /root).

To create a migration backup run the backup command with the -g argument.

\# op5-backup -g

The backup will now be created, check that the backup completes successfully

### Using new settings

In this step we will create a backup to a specific location, overriding the settings in /etc/op5-backup/main.conf

To start the interactive backup start the op5-backup script with the -i  argument.\# op5-backup -i

Choose to create migration backup

Select yes to override the settings in /etc/op5-backup/main.conf

Choose where to put the backup.

1.  If you choose ftp or sftp enter servername, path and username  

2.  if you choose local just enter local path 

Select yes to run the backup in the background.

Verify the settings and select yes to start the backup

Follow the backup log with\# tail -f /var/log/cron

## Verify the backup

Verify that the backup file is OK by listing the files in the backup file.

\# tar vft migration\_backup.-.backup

Note: The complete name of the backup file can be found in the log-file /var/log/cron.

If the backup file is complete it will list the files in the backup file like this:

### Backup acknowledgement and current state

If you would like to backup acknowledgements and a hosts/service current state stop OP5 Monitor with

\# mon stop

Copy the following file off the server

/opt/monitor/var/status.sav

Restart OP5 Montor

\# mon start

## Move backup file from the old server

This is VERY important, if you are using a local backup, make sure that you copy the migration backup file off the old server to a network share on your local computer. Or why not both?

## Upgrade to latest APS and Monitor

Before the upgrade your APS make sure that you have completed the upgrade of the old system and a backup has been created and moved off the server.

There are four step you will have to complete. The VMware Perl SDK installation is only needed if you are using any VMware checks.

-   APS installation (OS installation) 

-   Monitor installation

-   VMware Perl SDK installation (only if using VMware checks)

-   Restore old configuration.

These are described below and should be done in this order.

## APS installation

1.  Insert the CD with the APS

2.  Reboot the server and start from the CD

3.  Press  arrow down then enter to select “install”. Do not click on  anything until the server has rebooted.

4.  Login as root, using the default password (monitor)

## OP5 Monitor installation

1.  Copy  the monitor tar-file to /root

2.  Extract the file using:\# tar zxfv op5-monitor-X.X.X-YYYYY.tar.gz 

3.  Go to the newly created OP5 Monitor folder\# cd op5-monitor-X.X.X 

4.  Start the installation\# ./install.sh

## VMware Perl SDK installation

This step is only needed if you are using any VMware checks.

Follow the instructions in this how-to: How to Install VMware vSphere SDK for Perl 5.1

## Restore old configuration

The following steps should be done from the console.

Copy  the migration backup file to /root

Restore  the backup\# op5-restore -b /root/migration\_backup.-.backup 

Answer yes to restart network

Answer yes to run the restore in the background

Re-install the license file

Install the license file using the portal GUI. See manual for instructions or use the command line to re-install the license. 

1.  Upload the license to the /tmp directory via SCP as root and execute the following commands:\# cp /tmp/op5license-\*.lic /etc/op5license/op5license.lic \# chown apache:apache /etc/op5license.lic  && chmod 664 /etc/op5license.lic

Do a \# yum update to install the latest patches. Important for a peered environment!

Reboot server\# reboot

Restore host/service states

Stop OP5 Monitor

1.  \# mon stop

2.  Copy  status.sav back to /opt/monitor/var/ and restart op5 

3.  \# mon start

## Post setup

Verify that your installation if working as intended. Some things to verify

-   Notifications

-   Nagvis

-   Graphs

-   Business Services

Congratulations, you are now running the latest version of OP5 Monitor

