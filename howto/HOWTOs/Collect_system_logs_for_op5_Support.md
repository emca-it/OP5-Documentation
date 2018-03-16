# Collect system logs for OP5 Support

This how-to will describe how to prepare and collect log data for naemon (nagios) and merlin, and supplying this data to OP5 Support.

Doing this is often helpful in regards to decreasing the time to resolution for your support case, and it's especially useful in case you contact OP5 Support regarding issues related to:

-   Notifications
-   Check execution
-   Peers (load balanced setups)
-   Pollers (distributed setups)

# Instructions

1.  Log on as root to all your OP5 Monitor nodes (masters, peers and pollers) via SSH, and [make sure that the "op5 community" package repository and the "support tools" are installed.
     ](https://kb.op5.com/display/FAQ/Installing+the+op5+community+repository+and+support+tools)

2.  Log on as root to *one *of your OP5 Monitor *master* nodes via SSH (if you only have a single server, then that's the one), and execute the following command:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    mon sop collect-logs
    ```

    This tool will collect all naemon and merlin log data generated the last 30 days, from all your OP5 Monitor nodes, and finally create a tarball containing this data, ready to be sent to OP5 Support.

    For a shorter or longer time period of log data, or to store the tarball at a specific location, start the command with argument `--help `for more information.

    If the log collection was successful, the output will look similar to this:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    root@artemis:~# mon sop collect-logs
    [13:23:43] Created working directory: /tmp/op5logcollect.1461324223.6124.6AQ6LG

    [13:23:43] Verifying node command execution capabilities...
    Testing (artemis)... ok
    Testing (demeter)... ok
    Testing (hermes)... ok
    Testing (poseidon)... ok

    [13:23:43] (artemis) nagios.log ...
    [13:24:32] (artemis) nagios.log (start/stop entries) ...
    [13:24:33] (artemis) merlin/daemon.log ...
    [13:24:33] (artemis) merlin/neb.log ...
    [13:24:37] (demeter) nagios.log ...
    [13:24:53] (demeter) nagios.log (start/stop entries) ...
    [13:24:53] (demeter) merlin/daemon.log ...
    [13:24:57] (demeter) merlin/neb.log ...
    [13:24:59] (hermes) nagios.log ...
    [13:25:16] (hermes) nagios.log (start/stop entries) ...
    [13:25:16] (hermes) merlin/daemon.log ...
    [13:25:19] (hermes) merlin/neb.log ...
    [13:25:21] (poseidon) nagios.log ...
    [13:25:46] (poseidon) nagios.log (start/stop entries) ...
    [13:25:46] (poseidon) merlin/daemon.log ...
    [13:25:50] (poseidon) merlin/neb.log ...
    [13:25:52] Finished collecting, now finalizing merged log...

    [13:25:54] Creating tarball: /tmp/op5logcollect.1461324223.6124.6AQ6LG/op5-monitor-logs_2016-04-22_13.23.43.tgz
    -rw-r--r-- root/root  23979529 2016-04-22 13:25 main.log
    drwxr-xr-x root/root         0 2016-04-22 13:25 nagios/
    -rw-r--r-- root/root   9122800 2016-04-22 13:25 nagios/poseidon.log
    -rw-r--r-- root/root   9928682 2016-04-22 13:25 nagios/hermes.log
    -rw-r--r-- root/root  14877597 2016-04-22 13:24 nagios/demeter.log
    -rw-r--r-- root/root  51202265 2016-04-22 13:24 nagios/artemis.log

    [13:25:56] All done!
    ```

3.  As can be seen in the output above, the file */tmp/op5logcollect.1461324223.6124.6AQ6LG/op5-monitor-logs\_2016-04-22\_13.23.43.tgz *was created.
    Either download this file using scp/sftp (WinSCP is a nice tool if you're using Windows) and then attach to your support ticket, or send the file directly to OP5 by scp via the OP5 Monitor server command line (ask OP5 Support for instructions).

