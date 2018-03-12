# Missing packages on Red Hat Enterprise Linux during op5 Monitor update/installation

## Question

* * * * *

During the installation or upgrade of op5 Monitor on Red Hat Enterprise Linux, yum might fail due to missing dependencies. Depending on which version of op5 Monitor and RHEL, the following packages could be missing:

-   perl(Archive::Zip)
-   perl(Class::Accessor)
-   perl(Class::Accessor::Fast)
-   perl(Config::Simple)
-   perl(IO::Pty)
-   perl(IO::Scalar)
-   perl(IO::Tty)
-   perl(Net::SMTP::SSL)
-   perl(Parse::RecDescent)
-   perl(SOAP::Lite)
-   perl(XML::Simple)
-   perl-Config-Simple
-   perl-XML-Simple
-   php-mbstring
-   php-process
-   php-snmp
-   rubygems

## Answer

* * * * *

Several packages do no exist in the default Red Hat Main channel - the Optional channel is required. Add it using one of the following methods.

 

**Using Red Hat Subscription Management**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
subscription-manager repos --enable rhel-6-server-optional-rpms
```

or,

**Using RHN Classic**

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
rhn-channel --add --channel=rhel-x86_64-server-optional-6 -u username -p password 
```
