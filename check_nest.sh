#!/bin/sh
#
# Nagios Plugin to check status of Nest Thermostat
#
# License: GPL
# Copyright (c) 2017 Ken Dobbins
# Author: Ken Dobbins <ken030607@gmail.com>
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
#

print_usage() {
        echo "check_nest.sh: You forgot to specify any nest metrics"
        echo ""
        echo "Usage: check_nest.sh [-t] [-m]"
        echo ""
        echo "Options:"
        echo " -h"
        echo "    Print detailed help screen"
        echo " -t"
        echo "    Nest API access token"
        echo " -m"
        echo "    Nest API metric to request"
		echo " -ch"
        echo "    critical high threshold of metric"
		echo "		for string output must match cl"
		echo " -cl"
        echo "    critical low threshold of metric"
		echo "		for string output must match ch"
		echo " -wl"
        echo "    warning low threshold of metric"
		echo "		for string output must match wh"
        echo " -wh"
        echo "    warning high threshold of metric"
        echo "		for string output must match wl"
		echo ""
        echo "Example:"
        echo "check_nest.sh -t ABCDEFG -m humidity"
        echo ""
        echo "You can only define 1 metric at a time."
        echo "Make sure the correct number of command line"
        echo "  arguments have been supplied"
        echo ""
		echo ""
		echo "The available nest metrics are:"
		echo ""
        echo "    hvac_state"		
        echo "    last_connection"
        echo "    is_online"
        echo "    name_long"
        echo "    label"
        echo "    where_name"
        echo "    time_to_target_training"
        echo "    time_to_target"
        echo "    hvac_mode"
        echo "    previous_hvac_mode"
        echo "    fan_timer_duration"
        echo "    fan_timer_timeout"
        echo "    fan_timer_active"
        echo "    structure_id"
        echo "    sunlight_correction_enabled"
        echo "    sunlight_correction_active"
        echo "    locked_temp_max_f"
        echo "    target_temperature_high_f"
        echo "    target_temperature_high_c"
        echo "    target_temperature_f"
        echo "    target_temperature_c"
        echo "    can_cool"
        echo "    can_heat"
        echo "    name"
        echo "    device_id"
        echo "    humidity"
        echo "    locale"
        echo "    temperature_scale"
        echo "    is_using_emergency_heat"
        echo "    has_fan"
        echo "    software_version"
        echo "    has_leaf"
        echo "    where_id"
        echo "    target_temperature_low_c"
        echo "    target_temperature_low_f"
        echo "    ambient_temperature_c"
        echo "    ambient_temperature_f"
        echo "    away_temperature_high_c"
        echo "    away_temperature_high_f"
        echo "    away_temperature_low_c"
        echo "    away_temperature_low_f"
        echo "    eco_temperature_high_c"
        echo "    eco_temperature_high_f"
        echo "    eco_temperature_low_c"
        echo "    locked_temp_max_c"
        echo "    eco_temperature_low_f"
        echo "    is_locked"
        echo "    locked_temp_min_c"
        echo "    locked_temp_min_f"
}

. /opt/plugins/utils.sh

while getopts ':m:t:e:r:h:l:' opt; do
    case $opt in
		t)token="$OPTARG";;
		e)warhigh="$OPTARG";;
		r)warlow="$OPTARG";;
		h)crithigh="$OPTARG";;
		l)critlow="$OPTARG";;
		m)metric="$OPTARG";;
		h)print_usage;;
		*)print_usage;;
    esac
done
output=$(curl -s -L https://developer-api.nest.com/devices/thermostats\?auth=$token |jq '.[].'$metric'')


# Debugging Check uncomment below statements
echo $metric
echo $output
echo $warhigh
echo $warlow
echo $crithigh
echo $critlow

if [[ "$output" =~ ^[0-9]+$ ]]; then
	if [ "$output" -ge "$warhigh" ] && [ "$output" -lt "$crithigh" ]; then
		exit $STATE_WARNING
		echo "$metric = $output ELEVATED| $output"
	elif [ "$output" -le "$warlow" ] && [ "$output" -gt "$critlow" ]; then
		exit $STATE_WARNING
		echo "$metric = $output REDUCED| $output"
	elif [ "$output" -ge "$crithigh" ]; then
		exit $STATE_CRITICAL
		echo "$metric = $output HIGH| $output"
	elif [ "$output" -le "$critlow" ]; then
		exit $STATE_CRITICAL
		echo "$metric = $output LOW| $output"
	else
		exit $STATE_OK
		echo "$metric = $output Acceptable| $output"
	fi
else
	if [ "$output" == "$warhigh"]; then
		exit $STATE_WARNING
		echo "Metric $output"
	elif [ "$output" == "$crithigh"]; then
		exit $STATE_CRITICAL
		echo "Metric $output"
	else
		exit $STATE_OK
		echo "Metric $output"
	fi
fi
