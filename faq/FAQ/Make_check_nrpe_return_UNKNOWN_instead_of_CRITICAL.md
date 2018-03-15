# Make check\_nrpe return UNKNOWN instead of CRITICAL

## Question

* * * * *

How can I make NRPE checks return UNKNOWN instead of CRITICAL if unavailable?

When a service is unavailable I don't want it to report as CRITICAL, but rather UNKNOWN.

## Answer

* * * * *

You can do that either by adding the flag "`-u`"  the existing check commands that utilizes the plugin "`check_nrpe`", or create a new check command that includes the flag.

From the help text of check\_nrpe:  -u         = Make socket timeouts return an UNKNOWN state instead of CRITICAL

