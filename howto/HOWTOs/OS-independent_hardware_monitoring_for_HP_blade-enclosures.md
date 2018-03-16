# OS-independent hardware monitoring for HP blade-enclosures

Version

This article was written for version 5.0.1 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

This approach was used for HP C-class blade enclsoures.

Articles in the Community-Space are not supported by OP5 Support.

HP blade enclosures are often used for virtualization environments, specifically VMware. Hence OS-idependent monitoring of this hardware is desirable. This how-to describes how that can be achieved.

1.  Make sure the ILO-card in the blade enclosure has an IP-address assigned and that the card is accessible over the network from the OP5 Monitor server
2.  Configure the ILO-card to passthrough SNMP-requests to the baseboard management controller (an option you set in the ILO configuration interface)
3.  Monitor the hardware using the latest version of the check\_hpasm plugin.


