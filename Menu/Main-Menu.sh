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

cmd=(dialog --keep-tite --cancel-label "Exit" --backtitle "$scriptname - Version $version" --menu " $me " 22 76 16)

options=(1  "Webscrapers"
         2  "Make a Virtual Machine"
         3  "Reboot N8N Servers"
         4  "Docker Testing"
         5  "Add Midnight Cron" 
         6  "Install Dockers"
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
            bash ./Scripts/Sub-menu/Webscrapers/Webscrapers.sh 
            ;;
        2)
            bash ./Scripts/Sub-menu/Make-VM/Make-A-VM.sh
            ;;
        3)
            bash ./Scripts/Sub-menu/N8N/n8n.sh
            ;;
        4)
            dialog --backtitle "$scriptname - Version $version" --msgbox "Make sure you are in the same folder as the script" 10 30
            bash ./Scripts/Sub-menu/Docker-Testing/Docker-Testing.sh
            ;;
        5)
            bash ./Scripts/Cron/Add-Midnight-Cron.sh
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
            exit || break; done
      esac
exec /bin/bash "$0" "$@"
      done