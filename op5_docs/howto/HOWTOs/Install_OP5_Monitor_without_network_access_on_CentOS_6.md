# Install OP5 Monitor without network access on CentOS 6

This guide is meant to be used if you lack Internet access to fullfill dependency requirements of the OP5 Install script.

## Step-by-step guide

First obtain the latest CentOS 6 ISO files from a suitable [CentOS mirror](https://www.centos.org/download/mirrors/), f.ex

-   CentOS-6.8-x86\_64-minimal.iso
-   CentOS-6.8-x86\_64-bin-DVD1.iso
-   CentOS-6.8-x86\_64-bin-DVD2.iso

 

Now, install machine using the CentOS-6.8-x86\_64-minimal.iso, and then transfer CentOS-6.8-x86\_64-bin-DVD1.iso and CentOS-6.8-x86\_64-bin-DVD2.iso to /root on the machine.

 

Mount both ISO files on directories goverened by the CentOS-Media repo:

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mkdir -p /media/CentOS /media/cdrom
mount -o loop /root/CentOS-6.8-x86_64-bin-DVD1.iso /media/CentOS
mount -o loop /root/CentOS-6.8-x86_64-bin-DVD2.iso /media/cdrom
```

 

Copy the Monitor tarball (f.ex op5-monitor-7.3.1-20161014.tar.gz) you wish to install to /root on the machine, unpack it, and run the install.sh script inside the uncompressed directory (f.ex. op5-monitor-7.3.1).

 

## Related articles

-   Page:
    [Alerting and troubleshooting in general](/display/SUPPORT/Alerting+and+troubleshooting+in+general)
-   Page:
    [Generate xml license files](/display/SUPPORT/Generate+xml+license+files)
-   Page:
    [Troubleshooting high memory usage](/display/SUPPORT/Troubleshooting+high+memory+usage)
-   Page:
    [Prettify XML in VIM](/display/SUPPORT/Prettify+XML+in+VIM)
-   Page:
    [Pinpoint host and service execution time](/display/SUPPORT/Pinpoint+host+and+service+execution+time)

