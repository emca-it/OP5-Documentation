# Notification skins

# About

The three basic notifications (email, sms and htmlpost notifications) are all using something called notification skins. The notification skins are templates describing how the notification is supposed to look like when it is sent to its receiver.

# Files

If we will take a look at the notify folder we will find the following skins folders:

- skins.htmlpost/
  - skins.mail/
  - skins.sms/

Each folder contains a number of notification skins divided into host and service notification filters.

- host.ACKNOWLEDGEMENT
  - host.FLAPPINGSTART
  - host.FLAPPINGSTOP
  - host.PROBLEM
  - host.RECOVERY
  - service.ACKNOWLEDGEMENT
  - service.FLAPPINGSTART
  - service.FLAPPINGSTOP
  - service.PROBLEM
  - service.RECOVERY

As you can see there is one skin for the most common notification types.

# The content of a notification skin

Let us take a look at what a skin looks like.

### The sms service.PROBLEM skin

`#SERVICEDESC# on #HOSTNAME# is #SERVICESTATE#. #SERVICEOUTPUT# `

This is a very simple skin. The reason for that is that you can not send too much data with a normal sms.

### The mail service.PROBLEM skin

 `From: op5Monitor To: #CONTACTEMAIL# Subject: [op5] #NOTIFICATIONTYPE#: '#SERVICEDESC#' on '#HOSTNAME#' is #SERVICESTATE#`
` #extra_host_vars#`
` OP5 Monitor`
` Service #NOTIFICATIONTYPE# detected #LASTSERVICESTATECHANGE#. '#SERVICEDESC#' on host '#HOSTNAME#' has passed the #SERVICESTATE# threshold.`
` #STATUS_URL#`
` Additional info;`
` #SERVICEOUTPUT#`
` Host: #HOSTNAME# Address: #HOSTADDRESS# Alias: #HOSTALIAS# Status: #HOSTSTATE# Comment: #NOTIFICATIONCOMMENT#`
` Service: #SERVICEDESC# Status : #SERVICESTATE# Latency: Check was #SERVICELATENCY# seconds behind schedule Misc : Check took #SERVICEEXECUTIONTIME# seconds to complete`
` Additional links (requires configuration);`
` Host actions: #HOSTACTIONURL# Host notes: #HOSTNOTESURL#Service actions: #SERVICEACTIONURL# Service notes: #SERVICENOTESURL# `

The mail notifications can contain a lot more data and there we add a lot more to the mail skin file.
 In both The sms service.PROBLEM skin and The mail service.PROBLEM skin you find text like:

- ` #SERVICEDESC#`
- ` #HOSTNAME#`

That text is called **keywords**.
 The keywords will be replaced with the value of a command line argument looking like this:

`FOO=BAR`
 So a command line argument like the one above will generate a keyword with the name FOO having the value BAR.

If a notification macro, or other value sent to a corresponding keyword, is missing in the notification command it will not stop the notification from being sent. It is only the replacement that will be missing.

# Creating custom notification skins

Sometimes the default notification skins needs to be changed. This shall not be done in the default folders.

## To create custom notification skins

Go to the notify folder: `cd /opt/monitor/op5/notify`
 Create the custom-skins folder: `mkdir custom-skins`
 Copy the skins.\* folders to the custom-skins folder: `cp -R skins.* custom-skins/`
 Make the changes you like to do and the new skins will be used at directly after you have saved the changes.

If you have a peered system you need to do these changes on all peers.
