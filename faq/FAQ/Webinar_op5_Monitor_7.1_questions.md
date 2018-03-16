# Webinar OP5 Monitor 7.1 questions

## In this document we have listed all of the questions asked during our webinars on September 29th 2015

You can download the presentation deck from our webinar: ***["What's new in OP5 Monitor 7.1" right here!](http://www.op5.com/blog/wpfb-file/op5-monitor_7-1_webinar-pdf/)***

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

 

***Question: Did new version is compatible with aNag app for android?***

Answer: aNag uses the nagios CGIs. Several security issues has been reported using the CGIs so we have removed them and encourage tools that want to integrate with OP5 Monitor to use the APIs. The APIs is a REST API and are consistent, secure and feature rich and uses industry standards like JSON and XML. OP5 have a app that is free and available both for Android and iOS utilizing the REST API today. 

***Question: How about the possibility to set access rights per host/hostgroup/service etc***

Answer: We have a very granular configuration of access rights.  In 7.1 we have added the possibility to granularly configure command rights. What type of access rights do you want?

### ***Question: Regarding the per-user/per-group UI customizations: any progress in customizing the Tactical Overview widget layout for different groups?***

Answer: We are working on making the TAC better with easier ways of building the GUI the users want. Makin the default TAC dependent on groups are discussed but no planned release date yet.

******

***Question: Hi, a performance question: How about the GUI response? it is improved? it can get a little sluggish if you have a very large number of hosts/services/etc..***

Answer: There are many ways to enhance GUI performance, I would recommend you to use OP5 Professional service to find bottlenecks and the system to fine tune it. Please send an email to niklas.hagg@op5.com, head of Professional services.

### Is possible to add to OP5 Android App more than one instance op5?

Answer: No not in current version. We have issue logged for it already in backlog and has high priority for upcoming releases, although we have no dates for upcoming releases yet to communicate. However - the OP5 App uses filters, so if you have a peered monitor architecture you can define one or multiple filters and enable them to one or many users of the app. This can be useful for example in an MSP or similar set up where you want do limit the information to the app / specific user. 

### Question: Regarding AD integration: It would be really neat if we could assign AD accounts as contacts - as it is now i need to add all AD accounts as contacts, so i can set their permissions

Answer: I understand that this is a wish that alot of our customers wants. We have spent alot of time analysing customer setups and found that almost every customer has their own implementation of their AD, thus very hard todo a out of the box tool. However OP5 Professional Service has done this several times and have know how to implement it. I recommend to have a chat with them.

### Question: Please consider having DevBeer in Malmö - Gothenborg is a looong way from Copenhagen :)

Answer: Great suggestion, we will take into consideration, Malmö is a great city:) - but this time we will be in Gothenburg - if you want to join, press here

### Question: We heard that all versions after 7.0.4 is not very stable for distributed setups, including 7.1. When do you think that is solved?

Answer: 7.1.1, released September 22nd, please see release notes

### Question: Any thoughts on changing from rrd to graphite?

Answer: Yes we have looked into several graph engines. The task is big and needs to be carefully planned because changing the behavior of a central function like graphs will affect a lot of customers. At this stage we are investigating the backend / architecture impact, looking at many different ideas but we have no commit or planned dates.

****

**Question: \*I\* trust my users, but it makes sense to not let network technicians acknowledge server problems, at the same time they might want to \*see\* servers.**

Answer: Makes perfectly sense, but at this stage we wait for feedback on the per command rights we have implemented. Please provide us with use case and also how you expect it to be administered.

Note - there are many ways to achieve this and perhaps this not working for you - but if you make the network technician "contact" on a hostgroup "servers" and you give them the right to "view" contact, but you do not give them the right to "host command acknowledge". This is supported now with the extended access rights in Mon v7.1. 

 

### Question: Any update on selective poller config push?

Answer: This is a new feature request.  Please see: [How to submit a new bug/feature request.](https://kb.op5.com/x/SoIK)

 

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

