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


# New Virtual Machine or Docker Menu
DIALOG=${DIALOG=dialog}

$DIALOG --title "$scriptname - Version $version" --clear \
        --yesno "Is this a freshly made VM or Docker, then click yes to install all the software needed for these script menu to work." 10 30

case $? in
  0)
    bash ./Scripts/Installers/apt-get-install.sh
    bash ./Scripts/Installers/install-starship.sh
    bash ./Scripts/Security/Login-Script.sh
    ;;
  1)
    bash ./Scripts/Security/Login-Script.sh;;
  255)
    echo "ESC pressed.";;
esac