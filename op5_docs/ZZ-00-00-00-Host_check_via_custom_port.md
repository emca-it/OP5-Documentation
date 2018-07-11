# Host check via custom port

## Question

* * * * *

A host that I monitor is not reachable via ping (ICMP), how can I use a host check on a different protocol, such as a TCP port?

## Answer

* * * * *

To change the host check command to verify that the host is up, do the following:

1. Navigate to the configuration page of the host
2. Click "Advanced"
3. Find the configuration option "check\_command"
4. Change to one of the predefined commands "check-host-alive-\*"

You can also create your own port check using the plugin "check\_tcp" or any other plugin of your choosing. More information on check commands can be found in the documentation in the chapter [Commands](https://kb.op5.com/display/DOC/Main+objects)

![](images/19761781/20054192.png)
