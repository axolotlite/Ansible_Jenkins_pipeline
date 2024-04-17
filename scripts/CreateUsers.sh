#!/bin/bash
#creates a group and adds users to it
GROUPNAME="nginxG"
USERS=( Dev Text Prod )
if [ $(grep -q -E "^$GROUPNAME:" /etc/group) ]; then
	echo "group $GROUPNAME exists, skipping group creation..."
else
	echo "create $GROUPNAME"
	groupadd $GROUPNAME
fi
for user in ${USERS[@]}; do
	if [ $(id $user &>/dev/null) ]; then
		echo "$user already exists, skipping user creation..."
	else
		echo "creating user $user"
		useradd -G $GROUPNAME $user
	fi
done
