## |--------------------------------|
## |       Made By Rune004          |
## |    Need Support or Help?       |
## |    It can be found below.      |
## |                                |
## |            Discord:            |
## | https://discord.gg/UHd4tJg9Vm  |
## |                                |
## |            Github:             |
## |  https://github.com/rune004    |
## |--------------------------------|
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

# N8N CnC Menu
dialog --backtitle "$scriptname - Version $version" --msgbox "Please pick what n8n server you want to reboot" 10 30 ;


cmd=(dialog --keep-tite --backtitle "$scriptname - Version $version" --menu " $me " 22 76 16)

options=(1  "Restart N8N Backend"
         2  "Restart N8N Prod"
         3  "Restart N8N MySQL"
         4  "..."
         5  "..." 
         6  "..."
         7  "..."
         8  "..."
         9  "..."
         10 "Back To Main Menu"
#         11 "exit"
        )

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices 
    do    
        case $choice in
        1)
            dialog --backtitle "$scriptname - Version $version" --msgbox "$(curl -X GET https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-backend)" 10 30 ;
            ;;
        2)
            dialog --backtitle "$scriptname - Version $version" --msgbox "$(curl -X GET https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-prod)" 10 30 ;
            ;;
        3)
            dialog --backtitle "$scriptname - Version $version" --msgbox "$(curl -X GET https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-mysql)" 10 30 ;
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
            break 2
      esac
exec /bin/bash "$0" "$@"
      done