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

# Script Auto Self Update
echo "Script Self Updating"
sleep 2
VERSION="0.0.2"
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

# Install and Configure Checkmk

# Install and Configure Wazuh 

# Install and Configure Cloudflare Tunnel

# Add Nightly Reboot Cron

# Add Nightly Update Cron

# Change hostname via variables
echo "Change Hostname Via Hostnamectl"
echo " "
read -p 'Hostname: ' Hostname
sleep 2
hostnamectl set-hostname $Hostname
echo " "
echo "The Hostname Has Been Change To $Hostname"
sleep 2
clear


# Change IP to static via variables
echo "Change IP To Static"
echo " "
read -p 'New IP Address: ' IP
echo " "
echo "The IP Has Been Change To $IP"
sleep 2
clear

# Overwrite the /etc/network/interfaces file with new settings
echo "Overwrite the /etc/network/interfaces file with new settings"
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
sudo chmod 644 /etc/network/interfaces
systemctl restart networking.service
sleep 2
clear

# Install Docker Engine, containerd, and Docker Compose.

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
echo " "
sleep 2
apt-get update -y
apt-get install ca-certificates curl gnupg -y
sleep 2
clear

echo "Add Docker’s official GPG key:"
echo " "
sleep 2
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sleep 2
clear

echo "Setting up the repository"
echo " "
sleep 2
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2
clear

echo "Update the apt package index and Install Docker Engine, containerd, and Docker Compose."
echo " "
sleep 2
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sleep 2
