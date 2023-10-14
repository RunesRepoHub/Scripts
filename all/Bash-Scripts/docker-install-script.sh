#!/bin/bash

# Check if the user has root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Check if the system is Ubuntu or Debian
if [ -f /etc/lsb-release ]; then
  # Ubuntu
  DISTRO=$(lsb_release -cs)
elif [ -f /etc/debian_version ]; then
  # Debian
  DISTRO="debian"
else
  echo "Unsupported distribution. This script only supports Ubuntu and Debian."
  exit 1
fi

# Install Docker
echo "Installing Docker for $DISTRO"
if [ "$DISTRO" = "debian" ]; then
  # Debian installation
  apt-get update
  apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $DISTRO stable"
  apt-get update
  apt-get install -y docker-ce
else
  # Ubuntu installation
  apt-get update
  apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DISTRO stable"
  apt-get update
  apt-get install -y docker-ce
fi

# Install Docker Compose
echo "Installing Docker Compose"
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Docker CLI
echo "Installing Docker CLI"
apt-get install -y docker-ce-cli

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Print Docker, Docker CLI, and Docker Compose versions
docker --version
docker-compose --version

echo "Docker, Docker CLI, and Docker Compose have been successfully installed."

