apt-get install sudo
sleep 2
sudo apt-get update
sleep 2
sudo apt-get upgrade
echo "Change Hostname Via Hostnamectl"
read -p 'Hostname: ' Hostname
sleep 2
hostnamectl set-hostname $Hostname
echo "The Hostname Has Been Change To $Hostname"
sleep 2

