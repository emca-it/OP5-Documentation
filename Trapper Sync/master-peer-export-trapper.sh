#!/bin/bash
nodes=`mon node status --type=poller | grep poller | wc -l`
if [ $nodes -eq 0 ] ; then
        echo -e "This is a master OR a peer. Creating a database dump: /opt/trapper/share/db/trapper_dump.sql"
        mysqldump -u root merlin -p trapper > /opt/trapper/share/db/trapper_dump.sql
else
        echo "Error. This script is not intended to run on a poller!"
        exit 0
fi