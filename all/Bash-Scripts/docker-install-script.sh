#!/bin/bash

# Check if the script is run as root or with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

# Update the package manager
apt update

# Install prerequisites
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the package manager again to refresh the package cache
apt update

# Install Docker
apt install -y docker-ce

# Install Docker Compose
if [ ! -f /usr/local/bin/docker-compose ]; then
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

# Add your user to the 'docker' group to run Docker without sudo
usermod -aG docker $USER

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Output Docker version and Docker Compose version
docker --version
docker-compose --version

echo "Docker and Docker Compose have been installed and configured."

# You may need to log out and log back in for the user group changes to take effect.
