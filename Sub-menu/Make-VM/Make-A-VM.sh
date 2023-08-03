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

#!/bin/bash
cmd=(dialog --keep-tite --menu "$scriptname - Version $version - $me" 22 76 16)

options=(1  "Debian 20GB"
         2  "..."
         3  "..."
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
            break 2
            ;;
         *)
            exit
      esac
exec /bin/bash "$0" "$@"
      done