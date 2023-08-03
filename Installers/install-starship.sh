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


cmd=(dialog --keep-tite --cancel-label "Exit" --menu "$scriptname - Version $version - $me " 22 76 16)

options=(1  "Install Starship"
         2  "Don't Install Starship"
#         11 "exit"
        )

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices 
    do    
        case $choice in
        1)
            curl -sS https://starship.rs/install.sh | sh
            echo 'eval "$(starship init bash)"' >> ~/.bashrc
            ;;
        2)
            break 2
            ;;
         *)
            exit
      esac
exec /bin/bash "$0" "$@"
      done