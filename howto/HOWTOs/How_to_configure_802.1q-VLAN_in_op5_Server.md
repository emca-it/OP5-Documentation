# How to configure 802.1q-VLAN in OP5 Server

## **Introduction**

As you probably already know, VLAN (Virtual LAN) is used to segment networks. There are several reasons why you would want to configure VLAN on your OP5 server.

Let us say you have a very large amount of monitored hosts and services. All the traffic destined for the server will then probably be routed at the distribution layer. This could be avoided with VLAN configured on the server. Since the server would be on the same network as your hosts, the traffic will never be sent to your router/firewall. The traffic would only be handled in the access layer.

## **Prerequisites**

The interface connecting to the OP5 server, most likely a switch port, has to be configured as an 802.1Q trunk.

## **Planning**

Before you start configuring your VLAN, there are a few things to take under consideration. For starters, where should the traffic destined for the Internet go?

Either you could remove the IP details from the physical interface and use one of the VLAN for the default route. Note that you might have to add the option “BOOTPROTO=none” to the physical interface for this to work. Or you could just tag untagged traffic at the switch with the desired VLAN ID and leave the configuration for the physical interface. Most often referred to as native VLAN in terms of switch configuration.

## **Configuration**

It is recommended that you have physical access to the server since you could easily lose contact with the server if something isn’t correctly configured.

1. Use your favorite SSH client to connect to your OP5 server.
2. Create a new file in /etc/sysconfig/network-scripts/ and name it “ifcfg-eth0.X”. Where “X” is your VLAN ID. *The valid VLAN ID range is between 1 and 4096. VLAN 1 is untagged traffic.*
3. Add the following to that file and replace the options to match your network configuration.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    DEVICE=eth0.x
    BOOTPROTO=static
    BROADCAST=1.2.3.4
    IPADDR=1.2.3.4
    NETMASK=255.255.255.0
    NETWORK=1.2.3.0
    TYPE=Ethernet
    ONBOOT=yes
    VLAN=yes
    ```

    **Note:***Only add the “GATEWAY” statement for the interface used for outbound traffic. There can only be one default route.*

4. Save the new configuration file and restart the network service. Note that you will lose connection to the server and will have to reconnect.

        # /etc/init.d/network restart
