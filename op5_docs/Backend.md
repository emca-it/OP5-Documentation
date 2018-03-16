# Backend

The OP5 Monitor backend is called Merlin (Module for Effortless Redundancy and Load balancing In Nagios). It was initially created to provide an easy way to set up distributed Nagios installations, allowing Nagios processes to exchange information directly as an alternative to the standard Nagios way using NSCA. 

When we started making our own GUI for OP5 Monitor, called Ninja, we realized that we could continue the work on Merlin and adopt the project to function as backend for the new GUI by adding support for storing the status information in a database, fault tolerance and some other things.

