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
#!/usr/bin/env bash
version="v0.0.5"
export version="$version"

scriptname="RPH BASH Menu"
export scriptname="$scriptname"

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"


# New Virtual Machine or Docker Menu
DIALOG=${DIALOG=dialog}

$DIALOG --title "$scriptname - Version $version - $me" --clear \
        --yesno "Is this a freshly made VM or Docker, then click yes to install extra software like Starship." 20 60

case $? in
  0)
    bash ./Scripts/Installers/install-starship.sh
    bash ./Scripts/Security/Login-Script.sh
    ;;
  1)
    bash ./Scripts/Security/Login-Script.sh;;
  255)
    echo "ESC pressed.";;
esac