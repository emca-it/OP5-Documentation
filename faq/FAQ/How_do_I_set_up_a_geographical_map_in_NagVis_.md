# How do I set up a geographical map in NagVis?

## Question

* * * * *

How do I set up a geographical map in NagVis?

## Answer

* * * * *

The current geographical map feature in NagVis does not work straight out-of-the-box, and needs some configuration to get going.

1. In the OP5 Monitor interface, click *Monitor*, and then *NagVis* via the main menu.
2. In the NagVis interface, click *Options -\> Manage Maps -\> Create Map*.
3. Set *ID* and A*lias*, and select *Geographical map *as the *Map Type*. The alias is the name that will be displayed in the interface.
4. An error message will now show up that says "No location source file given. Terminate rendering geomap", but don't worry and click *Edit Map -\> Map Options*.
5. Among the map options, set the size of the map by entering *width *and *height* (in pixels). Also set *source\_type *to *NagVis Backend*.

And finally, to actually show some hosts in the map, some hosts must be configured with custom variables called *LAT* and *LONG*, containing the latitude and longitude geographical coordinates of the host. The ordinary Geomap feature can be used to determine the coordinates of a specific location.

To display only a subset of the LONG/LAT configured hosts, the map option *filter\_group* can be used to only show hosts that are members of a specific host group.
