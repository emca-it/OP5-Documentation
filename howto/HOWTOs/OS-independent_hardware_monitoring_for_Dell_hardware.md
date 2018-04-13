# OS-independent hardware monitoring for Dell hardware

Version

This article was written for version 5.x of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

When Dell servers are used to run VMware you lose the opportunity to Monitor the hardware status via OMSA ("Dell OpenManage Server Administrator Managed Node"). Hence OS-idependent monitoring of the hardware is desirable. This how-to describes how that can be achieved. The solution requires the servers to be equipped with DRAC-cards.

Using this approach it is possible to Monitor:

- raid
- fan status
- intrusion sensor
- power supplies
- ambient temp
- voltage

1. Make sure the DRAC-cards have IP-addresses assigned and that the cards are accessible over the network from the OP5 Monitor server
2. Make sure you have enabled LAN access to the BMC in BIOS setup
3. Monitor the hardware using the Dell BMC IPMI plugins linked below.

<http://exchange.nagios.org/directory/Plugins/Hardware/Server-Hardware/Dell/Dell-BMC-IPMI-Checks/details>
