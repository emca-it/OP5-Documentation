#!/bin/bash
function exit_msg {
    echo "$1" >&2   ## Send message to stderr. Exclude >&2 if you don't want it that way.
    exit "${2:-1}"  ## Return a code specified by $2 or 1 by default.
}

sanitize_node_name()
{
    trimmed=$1
    trimmed=${trimmed%% }
    trimmed=${trimmed## }
    echo "$trimmed"
}

poller_get_dump() {
        for fn in `mon node list --type=master,peer`; do
                node=$(sanitize_node_name $fn)
                echo -e "Retrieving MySQL dumpfile from $node ... "
                rsync -ru root@$node:/opt/trapper/share/db/trapper_dump.sql /opt/trapper/share/db/trapper_dump.sql > /dev/null
                if [ $? -eq 0 ] ; then
                        echo -e "Success. MySQL dumpfile was succesfully retrieved from $node\n"
                        break
                else
                        exit_msg "Error: Could not retrieve MySQL dump file from $node, rsync failed."
                fi
        done
}

poller_insert_dump() {
        echo -e "Inserting table in database 'trapper' ..."
        #mysql -u root -p trapper < /opt/trapper/share/db/trapper_dump.sql > /dev/null
        if [ $? -eq 0 ] ; then
                echo -e "Success. Table was inserted\n"
        else
                exit_msg "Error: Could not insert table to datbase 'trapper' in MySQL"
        fi
}

poller_reload_trapper() {
        echo -e "Reloading trapper service 'collector' ..."
        service collector restart > /dev/null
        if [ $? -eq 0 ] ; then
                echo -e "Success. Trapper was reloaded with new configuration.\n"
        else
                exit_msg "Error: Could not reload trapper process 'collector'"
        fi

}
poller_get_dump
poller_insert_dump
poller_reload_trapper
