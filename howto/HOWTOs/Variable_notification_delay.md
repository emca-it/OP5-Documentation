# Variable notification delay

add to /etc/cron.d/

command:
change\_delay.sh extend
change\_delay.sh reset

Example script using the old command-line API:

[change\_delay(1).sh](attachments/688519/983055.sh)

Necessary API calls using the NEW web services API:

Set the notification delay to 15 minutes for default host and services template:

    curl -k -X PATCH -H 'content-type: application/json' -d '{"first_notification_delay": "15"}' -u 'user:password' https://monitor.host/api/config/host_template/default-host-template
    curl -k -X PATCH -H 'content-type: application/json' -d '{"first_notification_delay": "15"}' -u 'user:password' https://monitor.host/api/config/service_template/default-service

Set the notification delay back to nothing:

    curl -k -X PATCH -H 'content-type: application/json' -d '{"first_notification_delay": "0"}' -u 'user:password' https://monitor.host/api/config/host_template/default-host-template
    curl -k -X PATCH -H 'content-type: application/json' -d '{"first_notification_delay": "0"}' -u 'user:password' https://monitor.host/api/config/service_template/default-service

Get a list of done changes and commit these:

    curl -k -X GET -u 'user:password' https://monitor.host/api/config/change
    curl -k -X POST -u 'user:password' https://monitor.host/api/config/change
