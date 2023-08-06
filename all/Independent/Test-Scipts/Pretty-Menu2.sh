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



DIALOG=${DIALOG=dialog}

$DIALOG --title " $SCRIPTNAME   -   Version$VERSION " --clear \
        --yesno "New or Old Virtual Machine/Docker" 10 30

case $? in
  0)
    bash ./Scripts/Installers/apt-get-install.sh
    bash ./Scripts/Installers/install-starship.sh
    ;;
  1)
    bash ./Scripts/Login.sh;;
  255)
    echo "ESC pressed.";;
esac