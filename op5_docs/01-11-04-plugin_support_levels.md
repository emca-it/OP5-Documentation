# plugin\_support\_levels

# About

Plugins that we ship with OP5 Monitor have different support levels. Many came from the Nagios Exchange communities, so we can only wait for community revisions. Other plugins started with OP5 or have become so deeply entrenched in Monitor that we take pride in revising them for you. This means we may open bugs or RFEs for one plugin while deferring to the outside world for another.

How can you determine which of our four support levels will apply? You can see the values for individual plugins by looking at the Plugins Index page from the Configure page, or https://{your.op5.server}/monitor/index.php/plugin/index (substituting "{your.op5.server}" with your server's FQDN).

icon

name

level of support

explanation

![Full button, green background](attachments/16482417/23793066.png "Full button")

# Full

high

OP5 fully supports and continuously tests this plugin. We have a fully compatible test environment to verify its functionality.

![Bug Support button, canary yellow background](attachments/16482417/23793067.png "Bug Support button")

# Bug Support

medium

OP5 does not test this plugin continuously. We may not have a compatible test environment available, as that may require resources beyond demand. If we or you discover a defect with the plugin, we will examine its importance and give it priority based on its customer impact as well as the necessary developer effort. OP5 Monitors its upstream project (if there is one) and updates the shipped plugin regularly.

![Best Effort button, orange background](attachments/16482417/23793068.png "Best Effort button")

# Best Effort

low

OP5 ships this plugin only as a courtesy to our customers. At some point in the plugin's history, we or a trusted customer made sure that dependencies would resolve and that the plugin would execute without runtime errors. The plugin has normally only been installed and tested at a customer site. OP5 Support can help out with command syntax.

![Deprecated button, red background](attachments/16482417/23793069.png "Deprecated button")

# Deprecated

nearly none

OP5 has concluded that this plugin can no longer be supported. It may have been replaced by a newer plugin, which we will name in the top line of its comments (to the right of the plugin listing). Please review the specific details so you can plan your changeover.

![Unsupported button, medium gray background](attachments/16482417/23793070.png "Unsupported button")

# Unsupported

none

OP5 does not support this plugin.
