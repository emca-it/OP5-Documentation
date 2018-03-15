# How to use the op5 Monitor App

# About our apps

The op5 Monitor App works directly towards the op5 Monitor API and your filter settings (based on your username). This enables you to tailor your app to show the list-views you set up in Monitor. For more information on list views, see links at bottom of this page. 

## System requirements

-   op5 Monitor 6.3 or higher
-   API access on op5 Monitor
    -   API "can\_submit\_commands" access if you want to be able to "acknowledge" events in the app.
-   Android 4.x or iOS 7
-   Our mobile app:

 

[![](attachments/9929159/11141142.png)](https://play.google.com/store/apps/details?id=com.op5.op5monitor&hl=en)

 

[![](attachments/9929159/11141143.png)](https://itunes.apple.com/se/app/op5-monitor/id915446915?l=en&mt=8)

 

* * * * *

 

# Getting started

## Server settings

Enter your hostname in the box. In this example we are using demo.op5.com

![Screenshot\_2014-06-24-11-09-24.png](https://lh4.googleusercontent.com/NXJjtC98XSGis5JdeS11UxJ0HbwslGMAOmQNoIgq7Dmc9uuwrmI1bw71lmS2E5KwzQrdNoGG26JgM-M60-GjeL7p1CYsBmkR54Cf73ajgiWeX4anQWtAgl5nkYDQKG03Xg)

 

![](attachments/9929159/11141150.png)

Note: Advanced users can use another port if needed. Useful if a port forwarding firewall is used to get through NAT. The syntax is :

 

## Add user credentials

Enter the user credentials to access your op5 Monitor APIs. An example (feel free to use for testing) is:

login: <demo@op5.com>

password: MonitorDemo123

![Screenshot\_2014-06-24-11-12-59.png](https://lh5.googleusercontent.com/HC6hlv3gaqP2_9IQcaiUf5dYS5GkHznC9o9yLL4wqEKYSSXO0PIB-68xp_bECZqtdAlZQq7Z2AhNYEb1q77Ye45FXxua4GzrM0IgLftcJPMrybehUpnvYirfltJWP_3kfA)

![](attachments/9929159/11141151.png)

Note: When using op5 demo site as demo user, the user has limited access so it is not possible to create own filters, acknowledge problems and so on.
If you have added an auth module to op5 Monitor, such as LDAP. Login with username\$name-of-auth-module as your username. Both are case sensitive.

## Start screen

The start screen shows an overview of hosts and services. Below can the filters defined in the op5 Monitor system be seen.

The rotating arrows are the the refresh button.

![Screenshot\_2014-06-24-11-34-07.png](https://lh6.googleusercontent.com/93DePmvkGepD2vkwp-0cUcFteN34t6v-wCeFCH_MHhrIf7ug4XHHjb9Xtov_MvVDvt6oXbzBigB-8HGrI0ki3JjIIlF0OGycdjmp5j1JMbnYrvPARp8hP0dIwlhGCqPjRQ)

![](attachments/9929159/11141149.png)

 

 

 

 

## Menu actions

Top left there is a meny with the possibility to do different actions:

-   Home, get back to start
-   All the filters
-   Feedback, send feedback to op5 from the op5 Monitor app
-   About, information about op5 and op5 knowledgebase
-   Logout

 

![Screenshot\_2014-06-24-13-17-09.png](https://lh4.googleusercontent.com/I91S_e20MxQ6IccT0QYunZQlUb1yzAJYDR9ZJeNJPitG0AZXrxjE90c2o8tNe39AZ1TC4RvoRDS0CARjis3UTF_GEMYfS78wc7Qflr5lq8pIEm0WdNFYNdq32U4NW0vK5A)

![](attachments/9929159/11141146.png)

 

 

## Settings

Top right is the settings menu, where it is set whether hosts and services that are acknowledged or hosts and services that are in scheduled downtime should be seen in the home screen.

![Screenshot\_2014-06-24-13-36-44.png](https://lh4.googleusercontent.com/TkAFU69cEka0wHiom8pADDhagYgSbUu-GN1y_Ly-xd61RELgDhIFv9u9UGHXSo6fI-WFQ5xptItIhhILiWqUEne6-X-pduHWFcI55XtzQLMnWhx_7DHspEMNe7HipEuf_Q)

![](attachments/9929159/11141152.png)

 

 

## Acknowledge

To acknowledge a host or service problem. Pick the problem and choose top right corner, the acknowledge shows up. Press it.

 

![](attachments/9929159/11141145.png)

 

 

 

 

## Feedback

If you want to send feedback to op5 about the app, use the feedback function in the app. If you want op5 to contact you, enter your emailadress and check the “should op5 contact you?” checkbox

![Screenshot\_2014-06-24-14-02-21.png](https://lh6.googleusercontent.com/63yFW_UNdIZEQYWb_P8w6d63B19LBJxMpGv8XCTG6lYo7jM0w5xNFlJv8YX7DqGDBRnl7i6IRug5g2ScT9FFGq8dF1Mhcw9C3hOuvQfDak-7Q1kAMnBh54pKpLMDoFPFcA) 

![](attachments/9929159/11141141.png)

 

 

 

 

# Advanced usage

This chapter describes some hints for more advanced users, it requires that  the user is allowed to create filters and has basic knowledge of how to use op5 Monitor.

## Create filters

The get a list of all hosts, create a filter named: All hosts and has the syntax [hosts] all

The get a list of all services, create a filter named: All services and has the syntax [services] all

To read more about filters, see op5 knowledge base Filters

 

