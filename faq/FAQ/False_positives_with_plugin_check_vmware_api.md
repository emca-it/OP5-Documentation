# False positives with plugin check\_vmware\_api

## Question

* * * * *

My health checks with check\_vmware\_api reports an issue, but no alarms are present in vCenter, why?

## Answer

* * * * *

The issue seems to be that the alarm is cached in the database from where check\_vmware\_api fetches its information. A possible solution is to clear the event log, and update it.

More information can be found in the [VMware Knowledgebase](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2061093) and some different possible solutions can be found in the [Veeam forums](https://forums.veeam.com/monitoring-f5/v5-false-alarm-host-hardware-sensor-status-changed-t5366-15.html). If your issue persists, you should contact VMware support.
