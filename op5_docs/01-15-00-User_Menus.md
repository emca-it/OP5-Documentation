# User Menus

## About

It is possible for an administrator to customize users menu.

This can be uses to limit the menu options for users that are not allowed to use certain parts of OP5 Monitor.

## Customizing

Full access users have complete control over what other user\_group have available in the OP5 menu.

**Please be aware that menu's access is controlled at the user\_group level only, it is not possible to control on a user by user basis.**

**To make a user\_group available to edit the User Menu, the "Access Rights" in the "Misc" section of the groupright page must be unchecked. All other group rights are allowed.**

You can follow the following procedure to edit the user menu for a user\_group.

1. Click on your user name in the top right of the OP5 GUI and click on "My Account" as shown in the below image.

![](images/16482374/20054072.png) \


2. At This point you should be at the "My Account" page.
    Now you will click on "Edit user menu" as shown in the below image.

![](images/16482374/20054073.png) \


3. This brings us to the "Edit user menu" page.
    You will want to select a user group from the drop down as shown in the below images.

![](images/16482374/20054074.png) \



![](images/16482374/20054075.png) \


4. Now we are where the magic can happen.
    This page will enable you to remove links and menus from the user\_groups GUI. Each option will hide that menu item when it is checked. You can hide an entire menu by selecting the main menu title, or select individual areas from a menu.
    Here is an image of what you will be seeing.

![](images/16482374/20054076.png) \


    Be sure to click "Save new settings!" when you finish editing your user menus.

## Menu Options Selection Details

The following itemized lists tell what each individual option hides from the user.

### Dashboards --

This removes the actual "Dashboards" menu, however the user will still see the default dashboards assigned to that user. They will be still be able to edit the dashboard through the active dashboard options menu on the right of the dashboard

#### Removing these major sections will also remove their entire Menu from the GUI --
	Monitor
	Report
	Manage

#### Removing any of these subsection items removes the item from Menu --
	Monitor:
		Trapper
		Business Services
		Network Outages
		Hosts
		Services
		Hostgroups
		Servicegroups
		Downtimes
		NagVis
		Log messages
		Geomap
	Report:
		Availability
		SLA
		Histogram
		Summary
		Graphs
		Saved seports
		Alert history
		Schedule reports
		Event log
		Notifications
		Log messages archive
	Manage:
		Configure
		View active config
		Backup/Restore
		Manage filters
		Scheduling queue
		Performance information
		Process information
		Host Wizard

#### items explicit to the Business Services, Host, and Service pages

##### Removing any of the following will remove "Options -> $item":
	Report

##### Removing any of the following will remove "Options -> Report > $item". Note that each of these require enabling the Report Menu Item if they need to be viewable within the Options section:
	Availability
	Histogram
	Alert History
	Event log

##### Removing any of the following will remove "Options -> Links > $item":
	Graphs
	Notifications

##### Removing any of the following will remove "Options -> Configuration > $item":
	Configure
