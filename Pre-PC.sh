# New Virtual Machine or Docker Menu
#!/bin/bash
DIALOG=${DIALOG=dialog}

$DIALOG --title " Please enter your choice " --clear \
        --yesno "New or Old Virtual Machine/Docker" 10 30

case $? in
  0)
    bash ./Scripts/Installers/apt-get-install.sh
    bash ./Scripts/Installers/install-starship.sh
    bash ./Scripts/Login.sh
    ;;
  1)
    bash ./Scripts/Login.sh;;
  255)
    echo "ESC pressed.";;
esac