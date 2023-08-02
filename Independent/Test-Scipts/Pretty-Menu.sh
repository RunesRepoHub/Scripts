#!/bin/bash

while true; do
    DIALOG=${DIALOG=dialog}

$DIALOG --title " My first dialog" --clear \
        --inputbox "Hello , this is my first dialog program" 10 30
        
options=("Install Docker & Docker-Compose" "Cloudflare" "Restart N8N MySQL" "Quit")
    select opt in "${options[@]}"; do
        case $? in
        1)
            bash ./Scripts/Installers/install-docker.sh
            break
            ;;
        2)
            bash ./Scripts/Installers/install-cloudflare-tunnel.sh
            break
            ;;
        3)
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-mysql"
            echo " "
            break
            ;;
        4)
            break 2
            ;;
        *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
        esac
    done
done