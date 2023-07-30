# Install sudo
apt-get install sudo -y
sleep 2

# apt-get update
sudo apt-get update -y
sleep 2

# apt-get upgrade
sudo apt-get upgrade -y

# Change hostname via variables
echo "Change Hostname Via Hostnamectl"
read -p 'Hostname: ' Hostname
sleep 2
hostnamectl set-hostname $Hostname
echo "The Hostname Has Been Change To $Hostname"
sleep 2

# Change IP to static via variables
echo "Change IP To Static"
read -p 'New IP Address: ' IP
sleep 2

# Overwrite the /etc/network/interfaces file with new settings
echo "# This file describes the network interfaces available on your system" > </etc/network/interfaces>
echo "# and how to activate them. For more information, see interfaces(5)." > </etc/network/interfaces>
echo " " > </etc/network/interfaces>
echo "source /etc/network/interfaces.d/*" > </etc/network/interfaces>
echo " " > </etc/network/interfaces>
echo "# The loopback network interface" > </etc/network/interfaces>
echo "auto lo" > </etc/network/interfaces>
echo "iface lo inet loopback" > </etc/network/interfaces>
echo " " > </etc/network/interfaces>
echo "# The primary network interface" > </etc/network/interfaces>
echo "allow-hotplug ens18" > </etc/network/interfaces>
echo "iface ens18 inet static" > </etc/network/interfaces>
echo " address $IP" > </etc/network/interfaces>
echo " netmask 255.255.255.0" > </etc/network/interfaces>
echo " gateway 192.168.1.1" > </etc/network/interfaces>
echo " dns-nameservers 192.168.1.1 1.1.1.1" > </etc/network/interfaces>
sleep 2

# Install Docker Engine, containerd, and Docker Compose.

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sleep 2

echo "Add Docker’s official GPG key:"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sleep 2

echo "Setting up the repository"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2

echo "Update the apt package index and Install Docker Engine, containerd, and Docker Compose."
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sleep 2
