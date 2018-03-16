# File and folder synchronization in load balanced setup

## Question 

* * * * *

What directories is sensible to synchronize with the internal file sync feature in the merlin subsystem in a load balanced configuration?

## Answer

* * * * *

Add the following to the section where the peer is configured on all peers that should synchronize files in the end of  /opt/monitor/op5/merlin/merlin.conf:

 

**merlin.conf**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
sync {
/opt/plugins/custom/
/opt/monitor/op5/nagvis_ls/etc/maps/
/opt/monitor/op5/nagvis_ls/etc/profiles/
/opt/monitor/op5/nagvis_ls/share/userfiles/
/opt/monitor/op5/ninja/application/config/geomap/
/opt/monitor/op5/pnp/templates
/etc/op5/auth_users.yml
/etc/op5/auth_groups.yml
/etc/op5/auth.yml
/opt/monitor/etc/resource.cfg
}
```

 

Since the sync is done by the monitor user, the files and directories included must be owned by that user. More detailed information: can be found in the [File synchronization section in the OP5 Monitor Administrator documentation](https://kb.op5.com/display/DOC/File+synchronization)

