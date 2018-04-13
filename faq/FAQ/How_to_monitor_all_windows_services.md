# How to monitor all windows services

## Question

* * * * *

How do I monitor all windows services that are in automatic mode?

## Answer

* * * * *

Use the check command "check\_nrpe\_win\_services" but instead of entering the service that you would like to monitor as an argument use "CheckAll".

This will check all services that are in automatic mode, however by default there is some services that are in automatic mode but not started, these will make the check fail. To exclude these add an exclude to the check command argument. For example if we would like to check all services that are in automatic mode and exclude the "Remote Registry" service we use this check command argument:  CheckAll exclude=RemoteRegistry
