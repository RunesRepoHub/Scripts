#!/bin/bash
# N8N CnC Menu
echo "--------------------------"
PS3='Please pick what n8n server you want to reboot: '
options=("Restart N8N Backend" "Restart N8N Prod" "Restart N8N MySQL" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Restart N8N Backend")
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-backend"
            echo " "
            break
            ;;
        "Restart N8N Prod")
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-prod"
            echo " "
            break
            ;;
        "Restart N8N MySQL")
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-mysql"
            echo " "
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done