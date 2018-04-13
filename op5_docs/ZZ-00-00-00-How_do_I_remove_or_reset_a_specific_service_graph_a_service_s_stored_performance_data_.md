# How do I remove or reset a specific service graph (a service's stored performance data)?

## Question

* * * * *

How do I remove or reset a specific service graph (a service's stored performance data)?

## Answer

* * * * *

### The basic way

Removing all stored graphing data (performance data =\> perfdata) of a service or host check is normally a trivial operation. It's just a matter of removing the files related to the check, found in this system directory:

`/opt/monitor/op5/pnp/perfdata/hostname/`

Make sure to substitute the *hostname* text string with the name of the host which the check belongs to.

Within this directory two files for every check with processed perfdata will be found. These files have *rrd* and *xml* file extensions. Th*e *RRD files contains the perfdata used to create the graphs and the XML file contains some metadata used by the *npcd *system daemon. Both files may be removed.

### The advanced way

Sometimes not all perfdata will be removed solely by removing the files as explained above.

To mitigate system I/O resource utilization, the RRD files are not updated in real-time. Instead, the updates are sent to a system daemon called *rrdcached*. This cached and volatile data is being written to the RRD files stored on disk every now and then (using a varying time interval). It also occurs every time a new graph is generated, such as when looking at a service graph in the web interface.

Even if the RRD file has been removed, it might reappear as rrdcache flushes its cache. It could also lead to old and unexpected perfdata being written among other new, fresh, perfdata.

The following steps describes how to safely remove all perfdata of a check, including any cached data.

1. The *npcd* system daemon processes all new and raw perfdata and sends it to the rrdcached daemon. Pausing this process ensures that no race condition will occur between step 2 and 3 (below). The process can be temporarily paused by shutting down npcd using the following command:
    `service npcd stop`
2. Force rrdcached to flush any cached perfdata belonging to a specific RRD file by sending a FLUSH command to it. This is performed using inter-process communication (IPC) via rrdcached's UNIX socket file. This has been made trivial thanks to the *unixcat* command:
    `echo FLUSH /opt/monitor/op5/pnp/perfdata/hostname/checkname.rrd | unixcat /opt/monitor/var/rrdtool/rrdcached/rrdcached.sock`
    Make sure to substitute the *hostname* and *checkname *text strings as they appear in the file system.
3. It is now safe to remove the RRD and XML file:
    `rm /opt/monitor/op5/pnp/perfdata/hostname/checkname.{rrd,xml}`
    Same here - substitute the *hostname* and *checkname *text strings.
4. Restart the npcd daemon to make sure that any new perfdata will be processed:
    `service npcd start`
    **IMPORTANT:** Not firing up npcd again will make most graphs look a bit empty after a while. The system will also end up with large amounts of unprocessed perfdata; gigabytes of data in large setups.
