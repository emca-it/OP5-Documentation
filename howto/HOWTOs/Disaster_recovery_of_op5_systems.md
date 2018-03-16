# Disaster recovery of OP5 systems

## Introduction

Data corruption, physical disaster, disk failures, human error are a few of the arguments of why you should implement a solid backup strategy for your OP5 system, and while recovery is in no way a new reason to perform backups, it will always remain the only reason to do them. 

For the purpose of rapid recovery, op5-backup has been written. It creates a tarball archive of all data relevant to the installed OP5 products so they in case of disaster can be quickly restored using op5-restore. The script can be used to either store the backed up data locally, on a NFS/CIFS share to later be protected by an enterprise backup system, or sent over FTP or SCP (SSH) to a remote host for safekeeping. The strategy to use will of course depend on your current backup environment and policies, but the tarball produced must be protected by some kind of additional backup method so it can be retrieved during a total hard drive failure.

For information on how to configure the backup script for FTP transfers, please refer to the OP5 System manual, chapter 6.3 Backing up the system. Instructions on how to mount NFS or CIFS to perform backups to a remote host can be found in the LogServer manual, Appendix B – Using remote storage. In addition,op5-backup contain a few examples of how to schedule it to run from crontab.

## Prerequisites

To be able to perform a complete recovery from a total system failure you will need the following:

-   Fully operational server hardware.
-   The most recent successful backup file created by op5-backup script.
-   Same release of system image from [op5 download area](http://www.op5.com/download-op5-monitor/), (or CentOS CD if you use your own hardware) and OP5 product software package that you were running when the backup was performed.

## Be prepared

To be able to handle a disaster situation efficiently, it might be a good idea to keep a few things in the same place, so you don’t need to start looking for them when you are already under pressure**:**

Info needed

Found where?

License file

Was sent to you or your technical contact by e-mail

Hardware service-tag

Found at the rear end of the server or on the front side

op5 Support contacts

Contact information on OP5 Support portal

op5 Support portal login

Was sent to you by e-mail upon purchase of your OP5 products

## Prepare the server

Make sure all hardware components are working properly and that BIOS versions, RAID firmware etc. are up to date. Set up disk redundancy if available, and ensure you are connected to the Internet.

If you are installing an OP5 appliance system, just insert the installation media during boot-up, wait for the boot prompt, select **Install OP5 APS** and press **Enter**. The rest of the installation will be performed without user interaction, so just wait until it is done, remove the install CD and reboot the system. If you prefer to use your own hardware, boot from the CentOS or Red Hat install CD and perform a system installation and configuration according to your own preferences. To be able to perform systems updates on an appliance system, you need to install your license file, so upload it to the server and run something like:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[root@monitor01 ~]# op5license-install your_license_file.xml
```

When the base system is installed, run **yum update** to make sure your system is up to date and then proceed to installing the OP5 software.

## Install OP5 software

Log in as root and transfer the OP5 software package, in this case OP5 Monitor to the server. Un-compress the content of the software package and run the install script:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[root@monitor01 ~]# tar -zxf op5-monitor-install-x.x.x.x86_64.tar.gz 
[root@monitor01 ~]# cd monitor-x.x.x 
[root@monitor01 ~]# ./install.sh
```

 

Follow the instructions on the screen until the installation is finished, then transfer the most recent backup made with op5-backup to the server and restore the backup tarball:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[root@monitor01 ~]# op5-restore -b /path/to/monitor01-Backup-20XX-XX-XX.backup
```

 

When done, reboot the machine and you should be back to where you were when the backup took place.

