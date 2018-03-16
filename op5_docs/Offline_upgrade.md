# Offline upgrade

# About

If your OP5 Monitor system lacks internet connectivity, upgrading can be done with a ISO image downloaded from [op5.com](https://www.op5.com/download-op5-monitor/archive/) This requires a account and a valid subscription.

This image file contains all dependencies required to upgrade OP5 Monitor to the specified version in the file name, such as: ` op5-System-6.8-Monitor-7.2.8-20160819-1816.iso`

# Prerequisites

-   A [op5 Appliance system](https://kb.op5.com/display/APSDOC/op5+Appliance+System) installation.
-   General knowledge of common Linux command line tools
-   Iso image file of the version of OP5 Monitor you want to upgrade too available in the OP5 Monitor servers file system

# Upgrade procedure

Mount the ISO image file in the filesystem:

``` {style="margin-left: 30.0px;"}
# mkdir -p /media/cdrom# mount -o loop op5-System-6.8-Monitor-7.2.8-20160819-1816.iso /media/cdrom/
```

On versions prior to OP5 Monitor 7.2.8 you need to execute two additional commands:

    # yum --disablerepo=* --enablerepo=*media* update op5-release

    # rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

Upgrade the system from the mounted ISO-file:

`# yum --disablerepo=* --enablerepo=*media* update`

You will now get a summary of all packages that will be updated or installed for dependencies, answer: yes

`Is this ok [y/N]: y`

The upgrade process will take a coulple of minutes, go get some coffee or tea.

 

Your system is now updated to the version specified in the filename of the ISO-image file.

 

