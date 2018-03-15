# Is there any sort of logs monitoring? What logs can be monitored without op5 LogServer Extension?

## Question

* * * * *

Is there any sort of logs monitoring? What logs can be monitored without op5 LogServer Extension?

## Answer

* * * * *

It is possible to forward logs to the Monitor server. The logs are saved as one text file per host and can be searched for key words (or the lack of keywords). Essentially, the same functionality as LogServer but more trouble to configure searches. However, the Monitor server cannot process the amounts of logs that the LogServer can. Nor does it have a web interface for reviewing or searching logs.

You can also monitor logs on the monitored servers directly using our agents as well using check\_logfiles on \*nix servers or by using NSClient on Windows servers and configure it to monitor the Eventlogs.

