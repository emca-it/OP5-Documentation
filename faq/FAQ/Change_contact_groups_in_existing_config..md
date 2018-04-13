# Change contact groups in existing config.

## Question

* * * * *

What is the easiest way of changing contact groups for different objects in an existing configuration?

## Answer

* * * * *

I have checked which methods can be used to help where an existing configuration with many hosts and services is to be changed so that the objects in question use new contact groups. Usually, when configuring a basic OP5 system installation, we try to create a good structure for contact groups as early as possible (when scripting the hosts). This is because new services take the host's settings for contact groups. Unfortunately, changing a contact group in the web configuration is not easy because the clone functionality does not have an over-write function yet. Nor is this easy to fix by editing the text files as contact group settings are stored in every individual host and service object. However, it is relatively easy to script this.

The steps are as follows:

1. List all the hostnames which are to change contact group.

2. Decide if the contact group for services shall stay with the host object the service belongs to.

3. Create new host and service templates which use the new contact groups.

4. Write scripts to process hosts.cfg and services.cfg and remove the settings for contact groups as well as change templates. (All services in services.cfg are grouped by host.)

In this way, it will, in the future, be easy to change the configuration by changing the contact group in the host and service templates instead of individual host and service objects.
