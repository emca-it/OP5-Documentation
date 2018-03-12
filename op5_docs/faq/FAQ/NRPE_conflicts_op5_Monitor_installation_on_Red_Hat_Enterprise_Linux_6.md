# NRPE conflicts op5 Monitor installation on Red Hat Enterprise Linux 6

## Question

* * * * *

Why do I get package conflicts with the NRPE package when installing or upgrading op5 Monitor on Red Hat Enterprise Linux 6?

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
Error: Package: op5-monitor-2016.d.1-op5.1.el6.noarch
    (@op5-monitor-updates)
               Requires: op5-nrpe
               Removing: nrpe-2.13.6-op5.1.el6.x86_64 (@op5-install-base)
                   op5-nrpe = 2.13.6
               Updated By: nrpe-2.15-7.el6.x86_64 (epel)
                   Not found
               Available: nrpe-2.13.3-op5.1.x86_64 (op5-monitor-updates)
                   op5-nrpe = 2.13.3
               Available: nrpe-2.13.4-op5.1.el6.x86_64 (op5-monitor-updates)
                   op5-nrpe = 2.13.4
               Available: nrpe-2.13.5-op5.1.el6.x86_64 (op5-monitor-updates)
                   op5-nrpe = 2.13.5
               Available: nrpe-2.12-16.el6.x86_64 (op5-monitor-updates)
                   Not found
               Available: nrpe-2.13.0-op5.1.x86_64 (op5-monitor-updates)
                   Not found
               Available: nrpe-2.13.1-op5.1.x86_64 (op5-monitor-updates)
                   Not found
               Available: nrpe-2.13.2-op5.1.x86_64 (op5-monitor-updates)
                   Not found
```

## Answer

* * * * *

The most probable cause is that the Epel-repository is enabled on the host system. You need to disable the Epel-repository in the repository configuration file:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/etc/yum.repos.d/epel.repo
```

1.  Change the setting enabled=1 to enabled=0 on all positions in the file:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    [epel]
    name=Extra Packages for Enterprise Linux 7 - $basearch
    #baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
    mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    failovermethod=priority
    enabled=0
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7   
    ```

2.  Save the file and clear the yum cache and initiate the installation or upgrade again:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    # yum clean all
    ```

 

