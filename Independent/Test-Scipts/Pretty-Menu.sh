#!/bin/bash
cmd=(dialog --keep-tite --menu "$SCRIPTNAME   -   Version$VERSION" 22 76 16)

options=(1  "Debian 20GB"
         2  "..."
         3  "..."
         4  "..."
         5  "..." 
         6  "..."
         7  "..."
         8  "..."
         9  "..."
         10 "..."
#         11 "exit"
        )

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices 
    do    
        case $choice in
        1)
            bash ./Scripts/Sub-menu/Make-VM/make-debian-20gb.sh
            ;;
        2)
            bash ./Scripts/Sub-menu/Make-VM/makevm.sh
            ;;
        3)
            bash ./Scripts/Sub-menu/N8N/n8n-CnC.sh
            ;;
        4)
            bash ./Scripts/Sub-menu/Docker-Testing/docker-testing.sh
            ;;
        5)
            bash ./Scripts/CnC/add-midnight-cron.sh
            ;;
        6)
            bash ./Scripts/Sub-menu/Install-Dockers/Install-Dockers.sh
            ;;
        7)
            speedometer -l  -r wlp2s0 -t lo -m $(( 1024 * 1024 * 3 / 2 ))
            ;;
        8)
            bmon
            ;;
        9)
            speedtest
            ;;
        10)
            ./snow.sh
            ;;
         *)
            exit
      esac
read -p "Hit enter to continue ..."
exec /bin/bash "$0" "$@"
      done