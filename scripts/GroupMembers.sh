#!/bin/bash

USERS=$(awk -F: '/nginxG/ {print $NF}' /etc/group)

echo "$USERS"
