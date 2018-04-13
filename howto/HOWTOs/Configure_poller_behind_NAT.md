# Configure poller behind NAT

Version

This article was written for version 6.2 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

This how-to will describe how to configure a poller that is located behind a NAT firewall where port forwarding is *not* possible. This is called running a passive poller.

It is highly recommended to use an active connection from the master to the poller (e.g. by setting up port forwarding or VPN), rather than a passive connection from the poller to the master (as described in this article).

Running multiple poller nodes behind the very same NAT is not supported – two nodes must not be seen at the same IP address, in the master's point of view.

In this example we have a master server called *master01* and a poller called *nat\_poller* that is behind a firewall.

# Prerequisites

- The master server must be accessible on port 22 and 15551 from the poller.
- Basic understanding of OP5 Monitor with master-peer configuration

# Steps

1. On *master01*, edit the */etc/hosts* file using your favorite text editor, and map the hostname *nat\_poller* to the outgoing NAT IP address of *nat\_poller* (i.e. the IP address which the poller will connect from in the master's point of view). Example:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    192.0.2.34 nat_poller
    ```

2. On *master01*, set up the poller node *nat\_poller* by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mon node add nat_poller type=poller hostgroup=nat_poller
    ```

3. On *master01*, edit the */opt/monitor/op5/merlin/merlin.conf* configuration file, and insert *takeover = no* and* connect = no* into the *nat\_poller* configuration block. Example:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    poller nat_poller {
        address = nat_poller
        port = 15551
        hostgroup = nat_poller
        connect = no
        takeover = no
    }
    ```

4. On *nat\_poller*, set up the master node *master01* by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mon node add master01 type=master
    ```

5. On nat\_poller, edit the */opt/monitor/op5/merlin/merlin.conf* configuration file, and insert into the master01 configuration block: a sub-block called object\_config, containing *fetch\_name* and fetch settings. Example:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    master master01 {
        address = master01
        port = 15551
        object_config {
            fetch_name = nat_poller
            fetch = mon oconf fetch master01
        }
    }
    ```

    The value of the *fetch\_name* setting should be set to the name of the poller.

6. On *nat\_poller*, disable any default nagios object configuration files by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    sed -i /^cfg_file=/d /opt/monitor/etc/nagios.cfg
    ```

7. On *nat\_poller*, verify and set up SSH connectivity by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mon sshkey push --all
    ```

8. On *master01*, restart the OP5 Monitor system services by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mon restart
    ```

9. On *nat\_poller*, fetch the new configuration from *master01* by executing the command below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mon oconf fetch master01
    ```
