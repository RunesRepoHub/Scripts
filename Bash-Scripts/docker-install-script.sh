#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Check if lsb_release command is available (Ubuntu/Debian)
if [ -x "$(command -v lsb_release)" ]; then
    DISTRO=$(lsb_release -is)
else
    # If lsb_release is not available, try to identify the distribution based on files
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi
fi

# Install Docker and Docker Compose on Ubuntu
install_docker_ubuntu() {
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker GPG key and repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
}

# Install Docker and Docker Compose on Debian
install_docker_debian() {
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

    # Add Docker GPG key and repository
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
}

# Install Docker Compose
install_docker_compose() {
    if [ ! -f /usr/local/bin/docker-compose ]; then
        curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    fi
}

# Check if Docker is already installed
if [ -x "$(command -v docker)" ]; then
    echo "Docker is already installed."
    echo "Updating Docker..."
    apt-get update
    apt-get upgrade -y
else
    echo "Docker is not installed. Installing..."
    case $DISTRO in
        "Ubuntu") install_docker_ubuntu ;;
        "Debian") install_docker_debian ;;
        *) echo "Unsupported distribution. Exiting."; exit 1 ;;
    esac
fi

# Install Docker Compose
install_docker_compose

# Check Docker and Docker Compose versions
docker --version
docker-compose --version

echo "Docker and Docker Compose installation completed."

exit 0
