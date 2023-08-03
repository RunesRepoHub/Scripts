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

cmd=(dialog --keep-tite --menu "$scriptname - Version $version - $me" 22 76 16)

options=(1  "Debian 10"
         2  "Debian 11"
         3  "Ubuntu 22.04"
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
            curl -s -O https://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@raw.githubusercontent.com/rune004/Scripts/main/Sub-menu/Docker-Testing/debian-10.sh
            sleep 2
            ssh root@192.168.1.191 'bash -s' < debian-10.sh
            ssh root@192.168.1.191
            ;;
        2)
            curl -s -O https://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@raw.githubusercontent.com/rune004/Scripts/main/Sub-menu/Docker-Testing/debian-11.sh
            sleep 2
            ssh root@192.168.1.191 'bash -s' < debian-11.sh
            ssh root@192.168.1.191
            ;;
        3)
            curl -s -O https://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@raw.githubusercontent.com/rune004/Scripts/main/Sub-menu/Docker-Testing/Ubuntu-22-04.sh
            sleep 2
            ssh root@192.168.1.191 'bash -s' < Ubuntu-22-04.sh
            ssh root@192.168.1.191
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