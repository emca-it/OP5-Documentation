# Troubleshooting trapper

## Problem

Traps from devices do not appear in the web user interface.

## Identifying the issue

First of all, make sure that the traps actually reach your trapper host. You can do this by using **tcpdump** to capture all traffic arriving at the host, using this command

> `tcpdump -i any udp dst port 162`

If packets aren't arriving at the host when you know they should be, the problem is either misconfiguration of the devices sending traps, or firewall issues. This means further investigation on the OP5 server is futile, and the problem is located elsewhere.

If packets arrive at the host but nothing is shown in the GUI, you should ensure that your DNS servers are properly configured. A symptom if misconfigured DNS servers tend to be a fully populated receive queue for the collector daemon. You can check this by using **netstat**, like so:

> `netstat -upln | grep 162`

If DNS misconfiguration is the issue, the output should look something like this:

> `udp 126408 0 0.0.0.0:162 0.0.0.0:*` 10622/collector

Which basically means "There are 126408 bytes in the receive queue for the daemon 'collector' with pid 10622 listening to UDP port 162 on all interfaces". The pid and the exact amount of bytes in the receive queue may differ. The key tell here is that the second column is a high number which stays static between multiple runs of the netstat command listed above. Technically, the problem is that collector spends a lot of time trying to resolve hostnames from ip-addresses against dns servers that are simply not responding, so the requests time out. Effectively, this reduces the trap handling throughput to one trap per dns lookup timeout time, which is usually somewhere around 30 seconds. Since that causes other traps to fill up the receive queue and snmp traps are sent via udp, that means many of the traps will be lost.

## Related articles

-   Page:
    [How to configure OP5 Trapper Extension (Cisco handler)](../HOWTOs/How_to_configure_op5_Trapper_Extension_Cisco_handler_)
-   Page:
    [Getting started with OP5 Trapper](/display/HOWTOs/Getting+started+with+op5+Trapper)
-   Page:
    [Sending results using query handler](/display/HOWTOs/Sending+results+using+query+handler)
-   Page:
    [Troubleshooting trapper](/display/HOWTOs/Troubleshooting+trapper)
-   Page:
    [IBM Director handler for Trapper](/display/HOWTOs/IBM+Director+handler+for+Trapper)

