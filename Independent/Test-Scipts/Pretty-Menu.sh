#!/bin/bash
        
options=("Install Docker & Docker-Compose" "Cloudflare" "Restart N8N MySQL" "Quit")
    dialog --menu "Menu" 10 30 3 1 Install Docker + Docker-Compose 2 Cloudflare 3 Quit
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
            break 2
            ;;
        *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
        esac
