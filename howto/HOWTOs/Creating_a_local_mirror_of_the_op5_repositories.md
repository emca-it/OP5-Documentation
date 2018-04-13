# Creating a local mirror of the OP5 repositories

Version

This article has been tested and verified with OP5 Monitor 7.0 and earlier, it could work on both lower and higher versions if nothing else is stated. Running local mirrors of the official repositories is only supported on a best-effort level.

- [Purpose](#Creatingalocalmirroroftheop5repositories-Purpose)
- [Prerequisites ](#Creatingalocalmirroroftheop5repositories-Prerequisites)
- [Configuration of the local mirror](#Creatingalocalmirroroftheop5repositories-Configurationofthelocalmirror)
- [Configuring the OP5 Monitor system](#Creatingalocalmirroroftheop5repositories-Configuringtheop5Monitorsystem)
- [Scheduling repository synchronization](#Creatingalocalmirroroftheop5repositories-Schedulingrepositorysynchronization)

## Purpose

This how-to is aimed towards the users who wants to create a local mirror of the *op5* repositories instead of fetching them via the Internet directly.
It may be need to be modified to work with different versions of *op5 Monitor*, *op5 Appliance System* and *CentOS*.

## Prerequisites

- A server running *op5 Monitor* or the *op5 Appliance System* with a valid license
- A server running the 64 bit version of CentOS 6.x for hosting of the local mirror with 4 GB of free disk space

## Configuration of the local mirror

1. Make sure that the server hosting the local mirror is up to date:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum update -y
```

2. Install the packages "yum-utils" and "createrepo"

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install -y yum-utils createrepo
```

3. Copy the repository configuration files and verification keys from the *op5 Monitor* system to the mirror host:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# scp root@<monitorhost>:/etc/yum.repos.d/op5-* /etc/yum.repos.d/
# scp root@<monitorhost>:/etc/pki/rpm-gpg/RPM-GPG-KEY-op5 /etc/pki/rpm-gpg/
```

This step may need to be executed again if new repositories are added by *op5*

4. Verify that the repositories has been installed correctly:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
$ yum repolist
```

5. Install and enable *Apache httpd* to serve our repository mirror:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install -y httpd
# service httpd start
# chkconfig httpd on
```

If you have the iptables firewall enabled, make sure to allow inbound traffic for port 80/TCP

6. Create a repository directory and synchronize the packages to the local system:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# mkdir /var/www/html/repos
$ cd /var/www/html/repos
# reposync -l -r "op5-*"
```

Synchronizing the repositories can take some time, depending on your Internet connection - this is a good time for a coffee break!

7. Create metadata for the locally synchronized repositories:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# for REPO in $(find /var/www/html/repos -iname "op5-*" -type d); do createrepo ${REPO}; done
```

## Configuring the OP5 Monitor system

8. Reconfigure the repositories on the OP5 Monitor server to use the local mirror by changing the "baseurl" setting:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# cat /etc/yum.repos.d/op5-release.repo

[op5-monitor-base]

name=op5 Monitor Base
baseurl=http://<local-op5-repo-address>/repos/op5-monitor-base
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-op5%

[op5-monitor-updates]
name=op5 Monitor Updates
baseurl=http://<local-op5-repo-address>/repos/op5-monitor-updates
enabled=1

gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-op5%
```

Change the "baseurl" setting in all OP5 related repositories located in "/etc/yum.repos.d/"

9. Clean up all yum cache information with the following command:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum clean all
```

## Scheduling repository synchronization

A tool like cron can be used to schedule synchronization of the OP5 repositories.
Below is an example script that can be placed in "/etc/cron.daily" to be executed on a daily basis:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: true; theme: Confluence"}
#!/usr/bin/env bash

echo -e "\nStarting OP5 repository sync at: $(date)\n"

echo "Cleaning up yum cache data"
yum clean all

cd "/var/www/html/op5"
reposync -l -r 'op5-*'

echo "Creating repository meta-data..."
for REPO in $(find /var/www/html/repos/* -iname "op5-*" -type d); do echo "Creating repo in ${REPO}"; createrepo ${REPO}; done
```
