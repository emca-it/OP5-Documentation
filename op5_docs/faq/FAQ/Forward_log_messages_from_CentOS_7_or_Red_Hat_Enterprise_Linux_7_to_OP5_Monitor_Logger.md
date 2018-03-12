# Forward log messages from CentOS 7 or Red Hat Enterprise Linux 7 to OP5 Monitor / Logger

## Question

* * * * *

I want to monitor log messages sent from a remote system on my OP5 Monitor system. How can I do this?

## Answer

* * * * *

1.  Make sure that your OP5 Monitor server can receive connections on 514/tcp or 514/udp. TCP is more reliable than UDP. Use TCP.
2.  Configure log forwarding as described in the rsyslog documentation on the remote host: <http://www.rsyslog.com/doc/v8-stable/tutorials/reliable_forwarding.html>

