# File synchronization

## Introduction

There is limited support for synchronizing files between peers, and between masters and pollers.

For example, when a new user has been added in OP5 Monitor on one of your masters, this function can be used to automatically synchronize the user database files on all other peers and pollers.

## Prerequisites

Make sure you have already set up a either a [load balanced](Load_balanced_monitoring) or [distributed](Distributed_Monitoring) monitoring environment (or a combination of which).

## The configuration

Although the setup is the same configuration-wise, there are two common but different ways of synchronization:

- Peered masters synchronizing files with one another (two-way).
- Masters synchronizing files to pollers (one-way).

The example and the described procedure below applies to both of these cases. However, it is recommended to repeat the procedure for all peers in case of file synchronization between peers.

### Configuring the sync directive

In this example, the master will synchronize files to its poller called poller01.

The following files will be synchronized:

- /etc/op5/auth\_users.yml

  - /etc/op5/auth\_groups.yml

The contents of the following directory will also be synchronized.

- /opt/plugins/custom/

#### Configuration procedure

1. Log on to the source node via SSH (in this case the master), as root.
2. Edit the file */opt/monitor/op5/merlin/merlin.conf *using a text editor:
    `nano /opt/monitor/op5/merlin/merlin.conf `
3. Find the configuration block related to the destination node (in this case poller01). Within this block, a new *sync* sub-block is inserted.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    poller poller01 {
      hostgroup = se-gbg
      address = 192.0.2.50
      port = 15551
      takeover = no
      sync {
        /etc/op5/auth_users.yml
        /etc/op5/auth_groups.yml
        /opt/plugins/custom/
      }
    }
    ```

    The trailing slash at the end of */opt/plugins/custom/* in the example above indicates that the contents of the directory should be synchronized, rather than the directory itself. This is the recommended way of synchronizing directories.

### Permission limitations

The files will be synchronized using the *monitor* system user – not *root*. This means that:

- Files and directories set up for synchronization must be readable and owned by the monitor user. For instance, root-only readable files cannot be synchronized.
  - All file paths and their corresponding directories, must be writable by the monitor user on the destination node.

## Triggering the synchronization

The file and directory synchronization occurs during a *configuration push*, which is triggered as a new configuration is saved in the web interface. For instance, adding a new host in Monitor and then [saving the configuration](The_basics) will trigger this.
