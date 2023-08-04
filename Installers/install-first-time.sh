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

set -e

YUM_PACKAGE_NAME="python python-devl python-pip openssl-devel"
DEB_PACKAGE_NAME="python2.7 python-dev libssl-dev"

 if cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Ubuntu"
    echo "==============================================="
    sudo apt-get update
    sudo apt-get install -y $DEB_PACKAGE_NAME
    sudo apt-get install curl -y
    sudo apt-get install nano -y
    sudo apt-get install sudo -y
    sudo apt-get install wget -y 
    sudo apt-get install cron -y
    sudo apt-get install dialog
    sudo dialog --create-rc ~/.dialogrc
    sudo cat ~/CnC-Public/dialog.txt > ~/.dialogrc
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Debian"
    echo "==============================================="
    apt-get update
    apt-get install -y $DEB_PACKAGE_NAME
    apt-get install curl -y
    apt-get install nano -y
    apt-get install wget -y 
    apt-get install sudo -y
    apt-get install cron -y
    apt-get install dialog
    dialog --create-rc ~/.dialogrc
    cat ~/CnC-Public/dialog.txt > ~/.dialogrc
 else
    echo "OS NOT DETECTED, couldn't install package $PACKAGE"
    exit 1;
 fi
 


