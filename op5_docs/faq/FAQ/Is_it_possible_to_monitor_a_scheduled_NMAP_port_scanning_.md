# Is it possible to monitor a scheduled NMAP port scanning?

## Question

* * * * *

Is it possible to monitor a scheduled NMAP port scanning?

## Answer

* * * * *

It is possible using the output list from NMAP to the log-directory which is stored on the server and then be monitored by check\_log2 and create alarms based on certain lines or content from the output of your NMAP-scan

