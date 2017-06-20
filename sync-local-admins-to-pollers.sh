#!/bin/bash
#
# Description: * Sync one [and only one] admin-group from master-node to poller nodes
#              * This script also creates a backup of the remote auth_user.yml for rollbacks (/etc/op5/auth_users.yml.bak)
#              * Scripts needs to be executed as root
#
# Requirements: python-pip, shyaml, pyyaml 
#
# Usage: ./sync-local-admins-to-pollers.sh [admin-group-name]
#
# Version: 0.1  <2017-06-16>
# Created by RC

# Binaries
scp=$(which scp)
ssh=$(which ssh)
cat=$(which cat)
shyaml=$(which shyaml)
if [ $? -ne 0 ]
then
    echo "shyaml not installed."
    echo "Install with: sudo yum install python-pip -y ; sudo pip install pyyaml shyaml"
    exit 1
fi

# Local admin group & argument checking
admin_group="$1"
if [ $# -ne 1 ]
then
    echo "Usage: $0 admin-group-name"
    exit 1
elif ! cat /etc/op5/auth_users.yml | grep -A1 groups | grep -wq "$1"
then
    echo "Group $1 not found in user database. Can't continue."
    exit 1
fi

# Make sure user is root
if [ ! $EUID == 0 ]
then
    echo "Script must run as root"
    exit 1
fi

# Files
local_user_database="/etc/op5/auth_users.yml"
first_tmp_poller_file="/tmp/first_tmp_poller_file.yml"
second_tmp_poller_file="/tmp/second_tmp_poller_file.yml"
poller_user_database="/tmp/auth_users.yml"

# Get poller nodes
poller_nodes=$(mon node show --type=poller | grep ADDRESS | cut -d'=' -f2)
if [ -z "$poller_nodes" ]
then
    echo "No pollers found, can't continue."
    exit 1
fi

# Local admin users
local_users=$("$cat" "$local_user_database" | "$shyaml" keys)
echo -ne "" > "$first_tmp_poller_file"
for user in $local_users
do
    group_membership=$("$cat" "$local_user_database" | "$shyaml" get-values "$user".groups)
    if [[ "$group_membership" == $admin_group ]]
    then
        # Create temporary yml-file for local admins only
        echo "$user:" >> "$first_tmp_poller_file"
        IFS=$'\n'
        for line in $("$cat" "$local_user_database" | "$shyaml" get-value "$user")
        do
            echo ""  " $line" >> "$first_tmp_poller_file"
        done
    fi
done

for poller in $poller_nodes
do
    # Get user database from poller
    "$scp" -q "$poller":/etc/op5/auth_users.yml /tmp/
    if [ $? -ne 0 ]
    then
        echo "Could not contact poller: $poller."
        echo "Continuing with next poller."
        break
    fi

    # Sort out remote admin users
    remote_users=$("$cat" "$poller_user_database" | "$shyaml" keys)
    echo -ne "" > "$second_tmp_poller_file"
    for user in $remote_users
    do
        group_membership=$("$cat" "$poller_user_database" | "$shyaml" get-values "$user".groups)
        if [[ "$group_membership" == $admin_group ]]
        then
            # Create temporary yml-file for non-admins on poller
            echo "$user:" >> "$second_tmp_poller_file"
            IFS=$'\n'
            for line in $("$cat" "$poller_user_database" | "$shyaml" get-value "$user")
            do
                echo ""  " $line" >> "$second_tmp_poller_file"
            done
        fi
    done

    # Fix YAML indentation for hashes
    sed -i -e 's/^  -/    -/' "$first_tmp_poller_file"
    sed -i -e 's/^  -/    -/' "$second_tmp_poller_file"

    # Create backup file on poller for rollback needs
    "$ssh" "$poller" 'cp /etc/op5/auth_users.yml /etc/op5/auth_users.yml.bak'

    # Join tmp yml-files, check syntax and send back to poller
    echo "---" > "$poller_user_database"
    "$cat" $first_tmp_poller_file >> $poller_user_database
    "$cat" $second_tmp_poller_file >> $poller_user_database
    validate_yaml=$(python -c "from yaml import load, Loader; load(open('/tmp/auth_users.yml'), Loader=Loader)")
    if [ $? -eq 0 ]
    then
        "$scp" -q $poller_user_database "$poller":/etc/op5/
        "$ssh" "$poller" "chown monitor:apache $poller_user_database"
    else
        echo "YAML code in $poller_user_database is invalid. Will not push. Please review file."
        exit 1
    fi
done

# Clean up
rm -f $first_tmp_poller_file $second_tmp_poller_file $poller_user_database
exit 0
