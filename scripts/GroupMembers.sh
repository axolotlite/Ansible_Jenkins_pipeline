#!/bin/bash

USERS=$(awk -F: '/nginxG/ {print $NF}' /etc/group)

echo "nginxG users: $USERS"
