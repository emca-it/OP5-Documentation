# Why security scanners shouldn't be trusted blindly

## I ran Nessus/other security scanner against my OP5 Monitor machine, and it told me that several software packages are out of date and contain vulnerabilities, but according to "yum update" there are no more recent versions available!

* * * * *

 

Security scanner tools can be quite misleading when they report back about vulnerable software versions, especially on platforms like CentOS and RHEL, due to the way RedHat handles backporting of bug/security fixes and version numbers of software packages.

Taking PHP as example. RedHat wants to keep the same Major.Minor.Micro version of PHP throughout the entire life cycle of RHEL 6 due to compatibility concerns. So, what RedHat does when they become aware of security issues that has been fixed for more recent versions of PHP, is that they backport the fix for the vulnerability to the current Major.Minor.Micro version (5.3.3) that was selected for RHEL 6, and then simply add a serial number after 5.3.3 to indicate what patch level this release of the PHP package has.

At the time of writing, the patch level of PHP is 46 (php-5.3.3-46) -- meaning that RedHat has applied a substantial amount of different bug/security fixes to PHP since the initial release of PHP 5.3.3. This is something that security scanners often fail to take into account. The scanner only sees: "**PHP 5.3.3 - That version is old and contain security issues**" - completely disregarding RedHat's -46 serial number indicating all the patches that have been backported and applied since 5.3.3, by RedHat.

 

So, as long as you are running the most recent packages provided by RedHat for RHEL/CentOS, or from OP5 for OP5 Appliance OS (APS), there should generally be no reason to be alarmed, provided the Operating System version is still supported according to [RedHat's Support Life Cycle Matrix](https://access.redhat.com/support/policy/updates/errata). You can read about RedHat's backporting policy [here](https://access.redhat.com/security/updates/backporting).

 

Should you however encounter an actual security vulnerability, don't hesitate to contact us at [https://www.op5.com/support/support-portal](https://www.op5.com/support/support-portal/).

* * * * *

 

 

