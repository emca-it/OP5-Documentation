#!/bin/sh
#
# Nagios Plugin to generate percentage from 2 OIDs
#
# License: GPL
# Copyright (c) 2017 Ken Dobbins
# Author: Ken Dobbins <kdobbins@op5.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



print_usage() {
cat <<"STOP"
        check_snmp_percentage.sh:
        
        Usage: check_snmp_percentage.sh [-H] [-o] [-u] [-C] [-L] [-w] [-c]
        
        Options:
         -H
            Hostname or IP to check
         -o
            OID of Total size (i.e. Memory, Disk or Bandwidth)
         -u
            OID of in use size (i.e. Memory, Disk or Bandwidth)
         -C
            Community String
        
         -L
            Label to use for Percentage Metric
        
         -w
            Warning threshold of Percentage Metric
        
         -c
            Critical threshold of Percentage metric
        
         -p
            SNMP Port of device
STOP
}

perform_check() {
   
#get in use Metric
currused=$(snmpget -v 2c -Oqv  -c $community $host:$port $oidcheck)

#calculate percentage of total metric
currpercent=$(awk "BEGIN { pc=100*${currused}/${currtotal}; i=int(pc); print (pc-i<0.5)?i:i+1 }")

    #test the calculated percentage against assigned threshold
if [[ $currpercent -ge $critical ]]; then
    echo "*CRITICAL* $label = $currpercent | $label Percent=$currpercent;$warning;$critical Used=$currused;0;0 Total=$currtotal;0;0"
    exit $STATE_CRITICAL
elif [[ $currpercent -ge $warning ]]; then
    echo "*WARNING* $label = $currpercent | $label Percent=$currpercent;$warning;$critical Used=$currused;0;0 Total=$currtotal;0;0"
    exit $STATE_WARNING
else
    echo "*OK* $label = $currpercent | $label Percent=$currpercent;$warning;$critical Used=$currused;0;0 Total=$currtotal;0;0"
    exit $STATE_OK
fi
}

port=161
. /opt/plugins/utils.sh

#Prepare command line comments
while getopts ':H:o:u:L:C:w:c:S:' opt; do
    case $opt in
        H)
            host="$OPTARG"
            ;;
        o)
            oidtotal="$OPTARG"
            ;;
        u)
            oidcheck="$OPTARG"
            ;;
        L)
            label="$OPTARG"
            ;;
        C)
            community="$OPTARG"
            ;;
        w)
            warning="$OPTARG"
            ;;
        c)
            critical="$OPTARG"
            ;;
        p)
            port="$OPTARG"
            ;;
        S)
            servdesc="$OPTARG"
            ;;
        h)
            print_usage
            ;;
        *)
            print_usage
            ;;
    esac
done

#get previous results from livestatus
prevresult=$(mon query ls services -c perf_data host_name='$host' description='$servdesc')

#assign previous perventage to variable
prevpercent=$(echo $prevresult | awk '{print $1}' | awk -F';' '{print $1}' | awk -F'=' '{print $2}')

#assign previous used to a variable
prevused=$(echo $prevresult | awk '{print $3}' | awk -F';' '{print $1}' | awk -F'=' '{print $2}')

#assign total available to a variable
prevtotal=$(echo $prevresult | awk '{print $2}' | awk -F';' '{print $1}' | awk -F'=' '{print $2}')

#get total available for metric
currtotal=$(snmpget -v 2c -Oqv  -c $community $host:$port $oidtotal)

#test for device presence and critical failure

if [[ -z "$prevresult" ]]; then
    perform_check
elif [[ $prevtotal -eq 0 && $currtotal -eq 0 ]]; then   #does the device exist to be checked
    echo "*OK* $label = 0 | $label Percent=0;0;0 Used=0;0;0 Total=0;0;0"
    exit $STATE_OK
elif [[ $prevtotal -gt 0 && $currtotal -eq 0 ]]; then   #determine if the total metric has become zero 
    echo "*CRITICAL* RESULT CHANGED TO ZERO $label = $prevpercent | $label Percent=$prevpercent;$warning;$critical Used=$prevused;0;0 Total=$prevtotal;0;0"
    exit $STATE_CRITICAL
else    #generate current percentage for logic test
    perform_check
fi


