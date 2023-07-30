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
!/bin/bash
clear 

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
echo "# and how to activate them. For more information, see interfaces(5)." > /etc/network/interfaces
echo " " > /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" > /etc/network/interfaces
echo " " > /etc/network/interfaces
echo "# The loopback network interface" > /etc/network/interfaces
echo "auto lo" > /etc/network/interfaces
echo "iface lo inet loopback" > /etc/network/interfaces
echo " " > /etc/network/interfaces
echo "# The primary network interface" > /etc/network/interfaces
echo "allow-hotplug ens18" > /etc/network/interfaces
echo "iface ens18 inet static" > /etc/network/interfaces
echo " address $IP" > /etc/network/interfaces
echo " netmask 255.255.255.0" > /etc/network/interfaces
echo " gateway 192.168.1.1" > /etc/network/interfaces
echo " dns-nameservers 192.168.1.1 1.1.1.1" > /etc/network/interfaces
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
