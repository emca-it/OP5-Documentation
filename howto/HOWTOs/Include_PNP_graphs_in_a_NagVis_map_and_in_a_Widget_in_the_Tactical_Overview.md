# Include PNP graphs in a NagVis map and in a Widget in the Tactical Overview

This article aims to describe how to include PNP graphs of a service check in a NagVis map or within a widget in the Tactical Overview.

Redirection Notice

This page will redirect to [DOC:NagVis maps\#Addagraph](/display/DOC/NagVis+maps) in about 5 seconds.

This documentation is deprecated in favour of the OP5 Monitor administrator documentation: [NagVis maps\#Addagraph](https://kb.op5.com/display/DOC/NagVis+maps#NagVismaps-Addagraph)

.

## Prerequisites

Decide which graph to use for your NagVis map and then fetch its raw address (URL):

1. Navigate to the graphs page of the service check that you want to add.
2. Have a look at your browser's address bar. Copy the current address to the clipboard.
3. Start up a text editor such as Notepad and paste the address from the clipboard. The address should look like similar to this:
    `https://monitor.your.domain/monitor/index.php/pnp?srv=Service%20name&host=HostnameNote: The %20 is the URL encoded version of a space character.`
4. Modify the address like this:
    `/monitor/op5/pnp/image?view=0&source=0&srv=Service%20name&host=Hostname`**
    **In other words, everything up to the question mark has been replaced.
5. Finally add square brackets surrounding the whole address, resulting in an address that looks like this:
    `[/monitor/op5/pnp/image?view=0&source=0&srv=Service%20name&host=``Hostname`]

.

## Create a NagVis map with a PNP graph

1. Navigate to NagVis.
2. Click on the menu options *Options* –\> *Manage Maps*.
3. Decide what to name your new map and enter this *Create map*.
    Note: You do not need to choose a background.
4. Click on the *Create* button.

### Add the PNP graph

1. Click on the menu options *Edit Map* –\> *Add Icon* –\> *Service*
2. Click somewhere on the map.
3. Set *host\_name* to the host your PNP graph represents.
4. Set *service\_description* to the service your PNP graph represents.
5. Set *view\_type* to *gadget.*
6. Click the *Save* button.
7. Logon to the Monitor server by SSH and change directory into the maps directory:
    `cd /opt/monitor/op5/nagvis_ls/etc/maps`
8. Using your favorite text editor, open up the configuration file of your map. The file will be named as *the-name-of-your-map.cfg*.
9. The recently added icon should have added a service definition. Add a *gadget\_url* parameter just below *view\_type=gadget*, like this:
    `gadget_url=[/monitor/op5/pnp/image?view=0&source=0&srv=Service%20name&host=``Hostname``]`The value has been set to the same address as prepared in the prerequisites of this how-to.

### Optional: Include more than one PNP graph

Just follow the steps above and add another PNP graph.

..

## Optional: Add the NagVis map within a Widget in the Tactical Overview

1. Navigate to the Tactical Overview.
2. Enable the NagVis widget if not enabled.
3. Click on the “Edit this widget” icon (the cog wheel) in the upper right hand corner of the widget.
4. Set *Map* to the NagVis map containing the PNP graph(s).
