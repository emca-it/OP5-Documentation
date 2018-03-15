#!/bin/bash
#
# Script to modify first_notification_delay dynaimcally via cron.
#
# Written by Daniel Jerveren - op5 AB.


SVC_DELAY=5
HOST_DELAY=5
MY_CMD="/usr/bin/mysql -B nacoma -e"


proc_modify() {
	$MY_CMD "UPDATE $1 SET first_notification_delay=$2 WHERE name='$3';"	

	if [ $? -ne 0 ]
	then
		logger -p daemon.err "$0 failed to change $1 first_notification_delay: $!"
		exit 1
	fi
}


case "$1" in
	'extend')
		proc_modify host $HOST_DELAY default-host-template
		proc_modify service $SVC_DELAY default-service ;;
	'reset')
		proc_modify host 0 default-host-template
		proc_modify service 0 default-service ;;
	*)
		echo "Usage: $0 extend|reset" ;;
esac

php /opt/monitor/op5/nacoma/api/monitor.php -a save_config
