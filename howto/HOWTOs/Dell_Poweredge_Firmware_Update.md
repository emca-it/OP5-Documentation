# Dell Poweredge Firmware Update

This article will show you how to update your bios and firmware from the command line. This applies to the following operating systems:

- OP5 Appliance System 6
- CentOS 6
- Red Hat Enterprise Linux 6

The most recent instructions for updating the firmware on Dell PowerEdge servers can be found here: <http://linux.dell.com/repo/hardware/dsu/>

Using Dell System Update is recommended.

In some cases a previous installed version of Dell Openmanage can create issues with the firmware update, this can be mitigated by removing previous installed versions of the Dell Openmanage Application and the repository file.

1. Remove all installed packages with:

        yum erase $(rpm -qa | grep srvadmin)

2. Remove the dell repo file from '***/etc/yum.repos.d/***'.
3. Reboot the server

### Hardware monitoring

You might also want to monitor your hardware of your servers. you can find information on how to do that just here: [Monitoring the hardware of your OP5 server](Monitoring_the_hardware_of_your_op5_server)
