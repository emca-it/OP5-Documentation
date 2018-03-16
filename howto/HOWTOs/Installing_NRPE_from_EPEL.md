# Installing NRPE from EPEL

Redirection Notice

This page will redirect to [Installation of NRPE agent on CentOS and RHEL](/display/HOWTOs/Installation+of+NRPE+agent+on+CentOS+and+RHEL) in about 5 seconds.

 

Version

This article was written for version 7.0 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

 

# Introduction

If you need to use the NRPE monitoring agent on a *Red Hat Enterprise Linux*-based system with SELinux or IPv6 enabled, installing it from the third-party [EPEL repository](https://fedoraproject.org/wiki/EPEL) is currently your best option.

In this how-to we will configure the repository and required packages on CentOS/RHEL 6 and 7 based systems.

The EPEL repository is not controlled and managed by OP5 AB - we can not guarantee the quality of the software packages.

# Prerequisites

-   Root access on the host
-   A working Internet-connection

# Installation

We first need to install the EPEL the repository and it's public GPG key. This is most easily done by executing one of the following commands:

**On RHEL 6.x**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
 # yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
```

**On RHEL 7.x**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

**On CentOS 6.x/7.x**

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum --enablerepo=extras install epel-release
```

 

If the installation of the repositories was successful, execute the following command to install NRPE:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum install nrpe
```

You should now have the NRPE monitoring agent installed. Information covering configuration NRPE can be found [here](https://kb.op5.com/display/DOC/NRPE).

# Disabling the EPEL repository

Disabling the repository is optional, but it's recommended if you don't want software from EPEL to appear in your search results or install applications from it by mistake.
This is done by changing the value of "enabled" to "0" in the repository configuration file:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/epel.repo
```

 

If you choose to disable the repository, make sure to enable it during updates so the NRPE agent receives security and bug fixes:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
# yum --enablerepo=epel update
```
