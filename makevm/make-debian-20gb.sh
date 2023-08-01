#!/bin/bash
# Make Debian VM Automation Script With IP Pull  
echo "--------------------------"
echo "Pick The Settings For The Debian VM"  
echo "--------------------------"
read -p 'Hostname: ' hostname
echo "Your Virtual Machine Is Now Being Made"
curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
sleep 180
curl -X GET "https://n8n-prod.rp-helpdesk.com/webhook/ip"