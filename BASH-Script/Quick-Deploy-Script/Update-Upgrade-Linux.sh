# Install sudo
apt-get install sudo -y
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
read -p 'Hostname: ' Hostname
sleep 2
hostnamectl set-hostname $Hostname
echo "The Hostname Has Been Change To $Hostname"
sleep 2
clear
sleep 10

# Change IP to static via variables
echo "Change IP To Static"
read -p 'New IP Address: ' IP
echo "The IP Has Been Change To $IP"
sleep 2
clear
sleep 10

# Overwrite the /etc/network/interfaces file with new settings
echo "Overwrite the /etc/network/interfaces file with new settings"
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
sleep 10

# Install Docker Engine, containerd, and Docker Compose.

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
apt-get update -y
apt-get install ca-certificates curl gnupg -y
sleep 2
clear
sleep 10

echo "Add Docker’s official GPG key:"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sleep 2
clear
sleep 10

echo "Setting up the repository"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2
clear
sleep 10

echo "Update the apt package index and Install Docker Engine, containerd, and Docker Compose."
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sleep 2
