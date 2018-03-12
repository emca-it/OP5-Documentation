# How to migrate from Monitor 5.8.x to 7.x on op5 APS

1) Upgrade the old system to 5.8.4

2) Install the new machine with 64-bit [APS 6.0.0 iso](http://d2ubxhm80y3bwr.cloudfront.net/Downloads/op5_downloads_extensions/op5-System-install-6.0.0.x86_64-20121122.iso)

3) Import CentOS-key on the new machine

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
```

4) Change erroneous path in op5-system-addons.repo:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
sed -i 's/6/5/g' /etc/yum.repos.d/op5-system-addons.repo
```

5) Install Monitor 5.8.0 using this [tarball](http://d2ubxhm80y3bwr.cloudfront.net/Downloads/op5_monitor_archive/op5-monitor-5.8.0-op5.1-20130410.centos.tar.gz)

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
tar -zxf op5-monitor-5.8.0-op5.1-20130410.centos.tar.gz
cd op5-monitor-5.8.0
./install.sh
```

6) Install license file on the new machine

7) Upgrade new machine to 5.8.4:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
yum --disablerepo=op5-system-{base,updates} update
```

8) Configure NTP, DNS etc and prepare for IP-change

9) Perform a migration backup, excluding system configuration on the old machine

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
op5-backup -m charch -- -sysconfig
```

10) Copy the migration backup file to the new machine

11) Shut down the old machine, and apply its IP setting on the new machine

12) Restore the migration backup

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
op5-restore -b /path/to/backup_file.backup
```

13) Make sure things look OK after restore

14) Upgrade new machine to 6.3.3 using this [tarball](https://www.op5.com/download/library/file/op5-monitor-6-3-3/?dl=1)

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
tar -zxf op5-monitor-6.3.3-20140912.tar.gz
cd op5-monitor-6.3.3
./install.sh
```

15) Verify again that everything looks OK.

16) Upgrade the new machine to latest 7.x through yum

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
yum install op5-release-up-6-to-7
yum --enablerepo='*up-6-to-7*' update
```
