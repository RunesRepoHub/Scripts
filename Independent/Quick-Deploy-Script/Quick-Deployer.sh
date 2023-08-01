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
clear 

# Bash Text Variables
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# Script Auto Self Update
echo -e "${BLUE}Script Self Updating${ENDCOLOR}"
VERSION="0.1.7"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Quick-Deploy-Script/Quick-Deployer.sh'
SCRIPT_DESCRIPTION=""
SCRIPT_LOCATION="${BASH_SOURCE[@]}"

rm -f updater.sh

function update()
{
    TMP_FILE=$(mktemp -p "" "XXXXX.sh")
    curl -s -O "$SCRIPT_URL" > "$TMP_FILE"
    NEW_VER=$(grep "^VERSION" "$TMP_FILE" | awk -F'[="]' '{print $3}')
    ABS_SCRIPT_PATH=$(readlink -f "$SCRIPT_LOCATION")
    if [ "$VERSION" \< "$NEW_VER" ]
    then
        printf "Updating script \e[31;1m%s\e[0m -> \e[32;1m%s\e[0m\n" "$VERSION" "$NEW_VER"

        echo "cp \"$TMP_FILE\" \"$ABS_SCRIPT_PATH\"" > updater.sh
        echo "rm -f \"$TMP_FILE\"" >> updater.sh
        echo "echo Running script again: `basename ${BASH_SOURCE[@]}` $@" >> updater.sh
        echo "exec \"$ABS_SCRIPT_PATH\" \"$@\"" >> updater.sh

        chmod +x updater.sh
        chmod +x "$TMP_FILE"
        exec updater.sh
    else
        rm -f "$TMP_FILE"
    fi
}

update "$@"

echo "$@"

echo -e "${GREEN}Script Self Updating Complete${ENDCOLOR}"
echo -e "${YELLOW}Current Script Version $VERSION${ENDCOLOR}"

# Run apt-get update/upgrade
echo "Run apt-get update/upgrade"
echo " "
sleep 2

# apt-get update
apt-get update -y
sleep 2

# apt-get upgrade
apt-get upgrade -y
sleep 2
clear

# Install and Configure Starship
bash ./Scripts/Installers/install-starship.sh

# Install and Configure Checkmk
echo -e "${YELLOW}Do you want to Install and Configure Checkmk?${ENDCOLOR}"
read -p " (yes/no) " checkmk

case $checkmk in 
	yes ) 
  echo ok, we will proceed
  sleep 2
  ;;
	no ) echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Install and Configure Wazuh 
echo -e "${YELLOW}Do you want to Install and Configure Wazuh?${ENDCOLOR}"
read -p " (yes/no) " wazuh

case $wazuh in 
	yes ) 
  echo ok, we will proceed
  sleep 2
  ;;
	no ) echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Install and Configure Cloudflare Tunnel
echo -e "${YELLOW}Do you want to Install and Configure Cloudflare Tunnel?${ENDCOLOR}"
read -p " (yes/no) " cloudflare

case $cloudflare in 
	yes ) 
  echo ok, we will proceed
  ;;
	no ) echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Add Nightly Reboot Cron
echo -e "${YELLOW}Do you want to Add Nightly Reboot Cron?${ENDCOLOR}"
read -p " (yes/no) " nrc

case $nrc in 
	yes ) 
  echo ok, we will proceed
  ;;
	no ) echo skipping...;
		break;;
	* ) 
    echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Add Nightly Update Cron
echo -e "${YELLOW}Do you want to Add Nightly Update Cron?${ENDCOLOR}"
read -p " (yes/no) " nuc

case $nuc in 
	yes ) 
  echo ok, we will proceed
  ;;
	no ) 
    echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Change hostname via variables
echo -e "${YELLOW}Do you want to Change hostname via variables?${ENDCOLOR}"
read -p " (yes/no) " nuc

case $nuc in 
	yes ) 
    echo -e "${YELLOW}Change Hostname Via Hostnamectl${ENDCOLOR}"
    echo " "
    read -p 'Hostname: ' Hostname
    sleep 2
    hostnamectl set-hostname $Hostname
    echo " "
    echo -e "${GREEN}The Hostname Has Been Change To $Hostname${ENDCOLOR}"
    sleep 2
    clear
  ;;
	no ) 
    echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear

# Change IP to static via variables
echo -e "${YELLOW}Do you want to Change IP to static via variables?${ENDCOLOR}"
read -p " (yes/no) " nuc

case $nuc in 
	yes ) 
    echo -e "${YELLOW}Change IP To Static${ENDCOLOR}"
    echo " "
    read -p 'New IP Address: ' IP
    echo " "
    echo "${GREEN}The IP Has Been Change To $IP${ENDCOLOR}"
    sleep 2
    clear

    # Overwrite the /etc/network/interfaces file with new settings
    echo -e "${YELLOW}Overwrite the /etc/network/interfaces file with new settings${ENDCOLOR}"
    echo " "
    sleep 2
    echo "# This file describes the network interfaces available on your system" > /etc/network/interfaces
    echo "# and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
    echo " " >> /etc/network/interfaces
    echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
    echo " " >> /etc/network/interfaces
    echo "# The loopback network interface" >> /etc/network/interfaces
    echo "auto lo" >> /etc/network/interfaces
    echo "iface lo inet loopback" >> /etc/network/interfaces
    echo " " >> /etc/network/interfaces
    echo "# The primary network interface" >> /etc/network/interfaces
    echo "allow-hotplug ens18" >> /etc/network/interfaces
    echo "iface ens18 inet static" >> /etc/network/interfaces
    echo " address $IP" >> /etc/network/interfaces
    echo " netmask 255.255.255.0" >> /etc/network/interfaces
    echo " gateway 192.168.1.1" >> /etc/network/interfaces
    echo " dns-nameservers 192.168.1.1 1.1.1.1" >> /etc/network/interfaces
    chmod 644 /etc/network/interfaces
    sleep 2
    clear
  ;;
	no ) 
    echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear


# Install Docker Engine, containerd, and Docker Compose.
bash ./Scripts/Installers/install-docker.sh

# Apply changes made to VM
reboot now