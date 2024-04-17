#!/bin/bash

# Email subject and body
SUBJECT="$1"
BODY="$2"

# Construct the email message
MESSAGE="Subject: $SUBJECT\n\n$BODY"

# Send the email using Curl
curl --url "smtps://$SMTP_SERVER:$SMTP_PORT" \
     --ssl-reqd \
     --mail-from "$SMTP_USERNAME" \
     --mail-rcpt "$MAIL_TO" \
     --user "$SMTP_USERNAME:$SMTP_PASSWORD" \
     -T <(echo -e "$MESSAGE")

echo "Email sent to $MAIL_TO"

