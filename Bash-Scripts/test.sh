#!/bin/bash

# Get IP address
IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')

# Get hostname
HOSTNAME=$(hostname)

# Send data to Node.js API
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "ip": "'"$IP"'",
    "hostname": "'"$HOSTNAME"'"
  }' \
  http://your-nodejs-api-endpoint
