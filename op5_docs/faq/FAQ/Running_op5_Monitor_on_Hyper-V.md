# Running op5 Monitor on Hyper-V

## Question

* * * * *

Can I run the virtual *op5 Monitor* appliance on *Microsoft Hyper-V*?

## Answer

* * * * *

Our virtual image is packaged in the Open Virtualization Format. This format is supported by Oracle, IBM, HP, Dell and VMware, but unfortunately not by Microsoft.

However, installing Monitor using the appliance system ISO (available in the ["extensions" section of the download page](http://www.op5.com/download-op5-monitor/extensions/), for op5 customers) is very straightforward.
Import the appliance system ISO into your image library, create a new VM in Hyper-V, boot it from the APS ISO, select the "install" option and grab a cup of coffee. When the installation is done the VM is rebooted and you're good to go.

Support information

Please note that running op5 Monitor in Hyper-V is not supported.

Issues with upgrading your op5 installation has been reported. We do not test our builds in Hyper-V.

## Installing "Linux Integration Services"

* * * * *

Microsoft provides a suite of applications and system modules called "Linux Integration Services", which enhances performance of the virtual machine and provides additional features.
See [this article on *Microsoft TechNet*](https://technet.microsoft.com/en-us/library/dn531030.aspx)* *for additional information (external link).

## Known issues

* * * * *

### Networking stops working

If the virtual appliance is hosted on Hyper-V running on Windows Server 2012, networking can in some scenarios stop working.
The issues is caused to due to a bug in Hyper-V and RedHats recommended solution is to stop the "irqbalance" service and restart the machine.

Open the virtual machine console for the op5 Monitor server, login to the system and issue the following commands:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# chkconfig irqbalance off
# reboot
```
