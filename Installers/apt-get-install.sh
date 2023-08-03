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


# Need software for script to work
set -e

YUM_PACKAGE_NAME="python python-devl python-pip openssl-devel"
DEB_PACKAGE_NAME="python2.7 python-pip libssl-dev"

 if cat /etc/*release | grep ^NAME | grep Ubuntu; then
    sudo apt-get update 
    sudo apt-get install -y $DEB_PACKAGE_NAME
    sudo apt-get install curl -s -y
    sudo apt-get install nano -y
    sudo apt-get install wget -y  
    sudo apt-get install cron -y
    sudo apt-get install dialog 
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    apt-get update 
    apt-get install -y $DEB_PACKAGE_NAME 
    apt-get install curl -y
    apt-get install nano -y
    apt-get install wget -y 
    apt-get install cron -y
    apt-get install dialog
 else
    echo "OS NOT DETECTED, couldn't install package $PACKAGE"
    exit 1;
 fi
clear