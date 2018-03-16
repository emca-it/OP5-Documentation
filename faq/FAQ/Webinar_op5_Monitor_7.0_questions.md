# Webinar OP5 Monitor 7.0 questions

## In this document we have listed all of the questions asked during our webinars on September 11th and September 17th 2014

You can download the presentation deck from our webinar: ***["What's new in OP5 Monitor 7.0" right here!](attachments/11632712/11567119.pdf)***

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

 

#### Q1: So what happen to Logserver Product and what does it mean for Licensing using Logger in OP5 Monitor?

A: OP5 Monitor Logserver that has been shipped as an extension to OP5 Monitor Enterprise will continue to be fully supported - no difference from before, licensing is the same. OP5 Logger is an integrated feature in OP5 Monitor Enterprise+. It’ included in the overall licence - hence a 300 Monitor Enterprise+ licence will be able to collect logs from 300 hosts.

#### Q2: Will Logger be integrated with Monitor's user control? Can you define which host's logs can a user access?

A: Yes it´s controlled in the group privileges:

![2014-09-11\_16-38-11.jpg](https://lh3.googleusercontent.com/3qJTtXmFQ8SX6vOgdUfeFLqVsZADdUh6E9X-lRc61Q5QUrTMeJtwX_dM_NCbavPysK4Myy8IyKksbp5QyjlbuN1Q4fIV2f4p_fPffJjYDxjFi2vVGJxFi2icGpPb3kWQvg)

The user rights are set on a user group level, hence if a user is part of a defined user group with log access enables - he/she will have full access to all logs in logger.

#### Q3: Is it possible to integrate with a currently existing syslog-ng server backend?

A:  As OP5 Logger is using syslog-ng as back-end it must be possible in one way or another...Please contact us on <presale@op5.com> so we can discuss best way for you.

#### Q4: Can you tell us what the logging-backend is?

A: Syslog-NG

#### Q5: How about the development for the OP5 Logserver? Will it only be lie critical updates for it and all new functionality be only for the Logger version?

A: We will sustain full support including bug fixes for OP5 LogServer. The focus for future new features and functions will be OP5 Logger.

#### Q6 Can you list other host logs by the Logger link to be able to correlate errors?

A: I’m not sure that I understand your question, however read the article in OP5 Knowledge base with a description how we did the “root cause analysis example” at <https://kb.op5.com/x/KQCn>. Hopefully it will give you an idea howto implement what you ask for.

#### Q7: Sending all logs to OP5 logger may generate huge load, are you having already experiences with that new workload for OP5 Monitor at all?

A: Yes - this is true - and one of the problems we encountered was in the free search box - so we have added support for narrowing smart search, i.e. h:backup will only list hosts with “backup” in it, l:backup only search and list log data. It’s also a configuration on how much data you need to have in your primary log DB, and when / how often you rotate your data out to the archives. A third option is also to do a split configuration, i.e. OP5 Monitor on one machine and OP5 Logger on a second machine - both optimized for resources for their particular usage.

#### Q8: Windows syslog agent, nsclient is both very old in the "packaged" op5way. When will you bring these up to date or update the versions? Get rid of the check\_nt also…

A: We do have an ongoing investigation to fix these issues. I hope that we have an answer shortly to this.

#### Q9: How do I handle my old filters created in OP5 LogServer if I migrate to OP5 Monitor Enterprise+ with integrated Logger?

A: There is no automatic import tool to migrate OP5 Logserver filters to OP5 Logger. The smart filter capabilities in OP5 Logger do use the same syntax as all other filters in OP5 Monitor so it is rather simple to manually convert them. We suggest you contact OP5 Professional Services to assure the best way way for your particular filters.

#### Q10: Does the Logger cost extra, do we need an additional license? 

A: The Logger is an integrated feature in OP5 Monitor Enterprise+, so if you are running that version today it will be no additional cost. If you are running OP5 Monitor Enterprise (no plus) you will get the Logger functionality when upgrading to v7.0, however it will be limited to collect logs only from ”local host” i.e. the OP5 Monitor system. That enables you to test it etc. If you want to be able to collect logs from all over, you need to upgrade your system from OP5 Monitor Enterprise to Monitor Enterprise+, this will also give you Trapper.

#### Q11: What about new logger and master / poller systems, eg is it possible to collect logs with poller and access it from master?

A: The OP5 Logger do not support the peer/poller functionality as other parts of OP5 Monitor. To access the OP5 Logger GUI you need to login to the system that has the logs, in this case the poller. It is also possible to access the logs via the API.

#### Q12: Is the logger part of all the versions or just the enterprise?

A: Its only included in OP5 Monitor Enterprise Plus and OP5 Monitor Free Trial

#### Q13: How are the logs stored in logger?

A: The logs are stored in a postgres database, and if configured also stored in compressed text files on disk. After a configurable time the logs are rotated out from the database.

#### Q14: What is the gain using the API instead of making the "Central NOC" the master of the different regions?

A: A use case from large customers are that they have several instances of master-poller setups. They can break the architecture and redo it but in many cases that is not applicable. One reason is that each instance should have their own responsibility of configuration. By using the API they can achieve a central system that has an aggregated view of the underlying independent systems.

#### Q15: Where can I find the OP5 Monitor 7 overview shown at the beginning of the presentation? I'd like to show it to my team.

A:  [Download the presentations here](attachments/11632712/11567119.pdf)

#### Q16: What about iPad App ?

A: The OP5 app is built to work on the iPad but it’s optimised for the iPhone.

#### Q17: Does the App support Ack commands?

A: Yes - see <https://kb.op5.com/x/x4GX>

#### Q18: Will the app be able to send sound alarms later on?

A: Good point/idea :) we should have the app to support sound off/on on the mobile - will look in to it.

#### Q19: Does the app support downtime?

A: Not sure what you mean, you can not request / set downtime over the app gui. You can however have a filter showing all your current services and hosts that is in planned downtime.

#### Q20: Is there push notifications in the app when a host/service goes down?

A1: No - as this is an on-prem system - you will need to register your system to apple. Today the app will clearly show when and what services/hostst etc are in what state, the notification will be as usual over sms and/or email.

A2: (Peter):

To be able to get push notifications working in the app, the OP5 system must send the notification to a central system. Which require an internet connection for the OP5 Monitor system. Then your specific device must be identified and mapped against your OP5 Monitor system at the central notification system. That is technical complicated and many Enterprise customers do not accept that kind of connection out of security issues. Depending on if you use Android or iOS the technical solutions are very different.

It is possible to use solutions like “notify my Android” or SMS to get it working.

if there is a demand we will investigate it.

#### Q21: Does the App only work if your monitor is upgraded to 7.0?

A: The OP5 Mobile App works on 6.3 and later. Today that is 6.3.x and 7.0.

#### Q22: Off topic: when will nsclient++ 4 be released ?

A:  nsclient++ is developed outside op5, The latest version is 4.2

#### Q23: Any changes to Nagvis or new module for it? 

A: No not for the moment. Do you have any input of how you want it to work we highly appreciate your input.

#### Q24: Can OP5 check DDOS attack ?

A: In many cases there is a possibility to use an IDS system that can log if there is suspicions traffic. By using OP5 Logger you can achieve monitoring of DDOS attacks.

 

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

