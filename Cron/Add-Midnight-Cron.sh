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

set -e

YUM_PACKAGE_NAME="python python-devl python-pip openssl-devel"
DEB_PACKAGE_NAME="python2.7 python-dev libssl-dev"

 if cat /etc/*release | grep ^NAME | grep CentOS; then
    yum install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Red; then
    yum install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Fedora; then
    yum install -y $YUM_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    dialog --backtitle "$scriptname - Version $version" --title " $me " --msgbox "Add a Cron job for apt-get update/upgrade and reboot at midnight" 30 60
    # Make the file directory if it dosen't exist
    if [ ! -f /opt/Scripts ]; then
    sudo mkdir /opt/Scripts
    fi
    # Copy file midnight-midget.sh to a "commen" system location
    curl -s -O https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Cron/midnight-midget.sh
    sudo cp midnight-midget.sh /opt/Scripts/midnight-midget.sh
    sudo rm midnight-midget.sh
    # Command to add a symbolic link in /usr/bin/
    sudo ln -s /opt/Scripts/midnight-midget.sh /usr/bin/
    # Setup cron settings
    dialog --backtitle "$scriptname - Version $version" --title " $me " --prgbox "Crontab" "sudo crontab -l > file; echo '00 00 * * * ruby /opt/Scripts/midnight-midget.sh >/dev/null 2>&1' >> file; crontab file" 30 60
 elif cat /etc/*release | grep ^NAME | grep Debian ; then
    apt-get update
    apt-get install -y $DEB_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Mint ; then
    apt-get update
    apt-get install -y $DEB_PACKAGE_NAME
 elif cat /etc/*release | grep ^NAME | grep Knoppix ; then
    apt-get update
    apt-get install -y $DEB_PACKAGE_NAME
 else
    echo "OS NOT DETECTED, couldn't install package $PACKAGE"
    exit 1;
 fi



