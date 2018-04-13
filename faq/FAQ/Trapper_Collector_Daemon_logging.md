# Trapper Collector Daemon logging

In case the collector daemon is filling up your /var/log/messages with endless number of lines containing SNMP trap data, this can easily be changed by editing the */etc/init.d/collector* init script file.

The resolution is to change some of the command line arguments passed to the collector daemon. Instead of *-Lsd* we want to use *-Lf /some/place/for/logs/trapper-collector.log* instead.

Some things to keep in mind:

- This change is not permanent. In case of upgrading to a new version of Trapper, the init script file will be restored to its defaults.
- The new log file is not log rotated by default. If you need rotation, add a new log rotation setting file into the /etc/logrotation.d/ directory.
- Make sure to restart collector once the file has been modified.
- This will not stop Trapper's *processor* daemon from logging to /var/log/messages (only collector is affected by this change).

#### Collect init script

**/etc/init.d/collector**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[...]
## Before
#OPTIONS="-On -c /opt/trapper/etc/collector.conf -A -Lsd -p /opt/trapper/var/run/collector.pid"

## After
OPTIONS="-On -c /opt/trapper/etc/collector.conf -A -Lf /var/log/trapper-collector.log -p /opt/trapper/var/run/collector.pid"
[...]
```
