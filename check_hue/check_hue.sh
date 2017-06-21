#!/bin/sh

lightnum=$1
path="/opt/plugins/custom/huestatus/"
file="light$lightnum.json"
. /opt/plugins/utils.sh

# Pull Light Status
curl --silent http://10.0.1.139/api/7mOXk8pT0KqDy52N97c3fg0e3BdZ1HZw34YPBTcM/lig       hts/$lightnum >"$path$file"

name=$(cat "/$path/$file" | jq -r '.name')
mv "$path/$file" "$path$name.json"

Status=$(cat "$path$name.json" | jq '.state.on')
Reachable=$(cat "$path$name.json" | jq '.state.reachable')

if [ "$Reachable" == "false" ] ; then
       echo "Unable to contact Light $name"
       exit $STATE_CRITICAL
else
        if [ "$Status" == "true" ]; then
                echo "The Light $name is ON"
                exit $STATE_OK
        elif [ "$Status" == "false" ]; then
                echo "The Light $name is OFF"
                exit $STATE_WARNING
        else
                echo "I Got Nothing Boss"
                exit $STATE_CRITICAL
        fi
fi
