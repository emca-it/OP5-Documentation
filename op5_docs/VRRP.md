# VRRP

# About

VRRP can be used in this setup to have one DNS-name and one IP address that is primary linked to one of the master servers and if the primary master for some reason is unavailable VRRP will automatically detect this and send you to the secondary master.

**Table of Content**

-   [About](#VRRP-About)
-   [Setup](#VRRP-Setup)
    -   [On the "primary" master](#VRRP-Onthe"primary"master)
    -   [On the "secondary" master](#VRRP-Onthe"secondary"master)
-   [Activate VRRP](#VRRP-ActivateVRRP)

# Setup

To enable VRRP on you master servers follow the steps below.
 In this example we have two masters that we want to use VRRP with.
 The VRRP IP will be 192.168.1.3 and we will bind that IP to the network interface eth0.
 The IP and interface will have to change to match your network configuration.

If you already use VRRP in your network, make sure that you use the correct virtual\_router\_id.

 Edit the file */etc/keepalived/keepalived.conf*

## On the "primary" master

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
vrrp_instance VI_1 {
state MASTER
interface eth0
virtual_router_id 51
priority 200
advert_int 1
virtual_ipaddress {
192.168.1.3 dev eth0
}
}
```

## On the "secondary" master

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
vrrp_instance VI_1 {
state BACKUP
interface eth0
virtual_router_id 51
priority 100
advert_int 1
virtual_ipaddress {
192.168.1.3 dev eth0
}
}
```

# Activate VRRP

To activate vrrp run the following command:

``` {style="margin-left: 30.0px;"}
# chkconfig keepalived on
```
