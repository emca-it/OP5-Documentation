# How to monitor a KVM installation

The purpose of this article is to describe how [op5 Monitor](http://www.op5.com/network-monitoring/op5-monitor/) can be used with the check\_libvirt plugin for agentless monitoring of resource usage on a KVM installation. At the moment the plugin can monitor:

**Host specific **parameters**:**

- Storage pool list
- Storage pool volume usage
- Running VM's

**VM specific **parameters**:**

- CPU Usage
- Memory Usage
- Disk I/O
- Network I/O

## Prerequisites

- Libvirt drivers need to be installed on both the OP5 Monitor server and on the target KVM host(s).
- The plugin support several transport protocols. In this guideline we will explain how to use the SSH and TLS features.
  - If you want use SSH, you need to setup a key-based authentication for the *monitor* user on the OP5 Monitor server and the *root* user on the target KVM host (libvirt is usually running as root).
  - If you want use TLS  as communication protocol then you will need to generate client and server certificates. Please follow the [libvirt.org how-to](http://wiki.libvirt.org/page/TLSCreateCACert) for that. Be careful and follow all the steps in that how-to before you continue. Notice that the KVM host server is the *server* and the OP5 Monitor server is the *client* for the TLS communication.
- All servers can be resolved in the DNS.
- Update OP5 Monitor to get the latest plugin pack.

## Check commands

### SSH as transport protocol

If you use SSH, import the required check-commands in your configuration (‘Configure’ -\> ‘Check Command Import -\> check\_libvirt\_kvm\*’). After the import you will have the following check commands:

### Commands for guest VM’s

command\_name

command\_line

check\_libvirt\_kvm\_guest\_cpu

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -N \$ARG2\$ -l CPU

check\_libvirt\_kvm\_guest\_disk\_io

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -N \$ARG2\$ -l IO

check\_libvirt\_kvm\_guest\_mem

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -N \$ARG2\$ -l MEM

check\_libvirt\_kvm\_guest\_net\_io

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -N \$ARG2\$ -l NET

### Commands for KVM host server

command\_name

command\_line

check\_libvirt\_kvm\_host\_running

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -l LIST

check\_libvirt\_kvm\_host\_storage\_pool

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -l POOL -s \$ARG2\$

check\_libvirt\_kvm\_host\_volume

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -l VOLUME -s \$ARG2\$/\$ARG3\$

check\_libvirt\_kvm\_host\_volume\_all

\$USER1\$/check\_libvirt -H qemu+ssh://\$ARG1\$@\$HOSTADDRESS\$/system -l VOLUME

Note: \$ARG1\$ macro in the command\_line refer to the user you will use to connect to the KVM host server, in these case *root*, the \$HOSTADDRESS\$ refer to the KVM host and the \$ARG2\$ refer to the guest VM-name.

### TLS as transport protocol

If you prefer user TLS, then you can add yourself the above check command to your configuration, you need only replace *qemu+ssh* with *qemu+tls, (‘Configure’ -\> ‘Commands’ -\> ‘Add new command‘ -\> ‘Go’).*

## Adding the services

Some services example following.

Add the required services as your needs, (‘Configure’ -\> ‘Host: ‘ -\> ‘Go’ -\> ‘Services for host ‘ -\> ‘Add new service’ -\> ‘Go’):

Arguments are just examples, you need to adjust them to suite your environment.

### Services for guest VM

service\_description

check\_command

check\_command\_args

Note

VM CPU Usage

check\_libvirt\_kvm\_guest\_cpu

root!sandbox-peer

\*

VM Mem Usage

check\_libvirt\_kvm\_guest\_mem

root!sandbox-peer

\*

VM Disk IO Usage

check\_libvirt\_kvm\_guest\_disk\_io

root!sandbox-peer

\*

VM Net IO Usage

check\_libvirt\_kvm\_guest\_net\_io

root!sandbox-peer

\*

### Services for KVM host server

service\_description

check\_command

check\_command\_args

Note

KVM storage pool usage

check\_libvirt\_kvm\_host\_storage\_pool

root!default

\*

KVM guest volume usage

check\_libvirt\_kvm\_host\_volume

root!win-sth1!default

\*

KVM all volume usage

check\_libvirt\_kvm\_host\_volume\_all

root

\*

KVM running vm list

check\_libvirt\_kvm\_host\_running

root

\*

\* Note: No warning or critical arguments are used in these examples. The plugin does however support thresholds.

This plugin and these check\_command has been successfully tested on CentOS/RHEL v.5.5 and 6.x with KVM 2.x.

More information about libvirt can be found at: [www.libvirt.org](http://www.libvirt.org/ "libvirt")
