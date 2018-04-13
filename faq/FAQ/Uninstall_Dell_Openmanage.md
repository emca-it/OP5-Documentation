# Uninstall Dell Openmanage

## Question

* * * * *

How do I remove Dell Openmanage completely from my Appliance Server?

## Answer

* * * * *

1. Remove all installed packages with the following command: `# yum erase $(rpm -qa | grep srvadmin)`

2. Remove the dell repo file from '***/etc/yum.repos.d/***'
