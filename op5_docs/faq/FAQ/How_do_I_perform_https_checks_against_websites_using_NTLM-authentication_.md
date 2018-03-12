# How do I perform https checks against websites using NTLM-authentication?

## Question

* * * * *

How do I perform https checks against websites using NTLM-authentication?

## Answer

* * * * *

** **NTLM authentication is not supported by default in the plugin check\_http or in Webinject. There is however a [plugin available at Nagios Exchange](http://exchange.nagios.org/directory/Plugins/Network-Protocols/HTTP/check_http_ntlm/details) which can handle NTLM-auth. It's a shell script acting as a wrapper for curl which supports NTLM-auth.

