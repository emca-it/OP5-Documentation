# Exposing Monitor's API through a reverse proxy

Version

This article was written for version 6.3.1 of op5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by op5 Support.

 

# Introduction

If you are  in a situation where you need to expose [Monitor's API](https://kb.op5.com/display/DOC/HTTP-API) for use with external applications (like dashboards or the mobile app) the best solution is to use a [reverse proxy](http://en.wikipedia.org/wiki/Reverse_proxy).

In this how-to we will configure the [Apache HTTP server](https://httpd.apache.org/) as a reverse proxy and cover some basics steps for tightening security.

 

Exposing a op5 Monitor system directly to the Internet or other untrusted networks is not recommended. We encourage you to use a [VPN solution](http://en.wikipedia.org/wiki/Virtual_private_network) or similar to restrict access.

 

# Prerequisites

-   Basic Linux/UNIX knowledge

-   Root-privileges on a server with network access to port 443 on the host running Monitor

# Installation and configuration

We will start off by installing the Apache HTTP  server and it's SSL module:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
[root@reverseproxy ~]# yum install -y httpd mod_ssl
```

 

Create and edit */etc/httpd/conf.d/monitor-api-proxy.conf* with your text editor of choice. The content of this file should look something like this:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: true; theme: Confluence"}
<IfModule mod_proxy.c>

        ProxyRequests Off

        <Proxy *>
                Order deny,allow
                Allow from all

        </Proxy>

        ProxyPreserveHost On
        ProxyVia On
        SSLProxyEngine on

        ProxyPass /api https://monitorhost:443/api
        ProxyPassReverse https://monitorhost:443/api /api

        CustomLog logs/access_monitor-api-proxy.log combined
        ErrorLog logs/error_monitor-api-proxy.log

</IfModule>
```

Replace "monitorhost" with the host name or IP-address of your Monitor server.

Restart the Apache HTTP server:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
[root@reverseproxy ~]# service httpd restart
```

 

You should now have a working reverse proxy. You can test the setup with a web browser or with *curl* from your local system:

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
[user@desktop ~]# curl --insecure -u user:password https://reverseproxy/api/status/host/monitor/
```

Replace "reverseproxy" with the host name or IP-address of your reverse proxying server.

 

# Security recommendations

-   Restrict access to the reverse proxy server with a firewall or similar
-   Use certificates signed by a trusted [certificate authority](http://en.wikipedia.org/wiki/Certificate_authority) on both the  reverse proxy host and the Monitor host
-   Limit the reverse proxy to */api/status* and */api/filter* to only expose "read-only" information
-   Configure your reverse proxy to [verify the certificate](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html#sslproxyverify) of the Monitor server
-   [Install and configure](http://www.cyberciti.biz/faq/rhel-fedora-centos-httpd-mod_security-configuration/) the web application firewall *mod\_security* to [block brute-force login attempts](http://snippets.aktagon.com/snippets/563-brute-force-authentication-protection-with-modsecurity)

 

