#!/bin/bash
#
#
### BEGIN INIT INFO
# Provides: selenium
# Required-Start: $local_fs $network $syslog selenium
# Required-Stop: $local_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Selenium
# Description:       Selenium
### END INIT INFO
export CLASSPATH=/opt/plugins/custom/selenium
if [ ! -d "/var/log/selenium" ]; then
	mkdir -p /var/log/selenium;
fi 

case "${1:-''}" in
'start')
        nohup env DISPLAY=:99 /usr/bin/java -jar /opt/plugins/custom/selenium/selenium-server-standalone.jar > /var/log/selenium/selenium-output.log 2> /var/log/selenium/selenium-error.log &
        echo "Starting Selenium..."
#####env DISPLAY=:0.0 firefox &
env DISPLAY=:99 firefox &
        error=$?
        if test $error -gt 0
        then
            echo "${bon}Error $error! Couldn't start Selenium!${boff}"
        fi
    ;;
    'stop')
        echo "Stopping Selenium..."
pkill -9 java
pkill -9 firefox
    ;;
    *)      # no parameter specified
        echo "Usage: $SELF start|stop|restart|reload|force-reload|status"
        exit 1
    ;;
esac
# - See more at: https://kb.op5.com/display/PLUGINS/Selenium+in+Monitor?src=search#sthash.iIiFxxCD.dpuf
