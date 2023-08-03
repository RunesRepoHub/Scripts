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


echo -e "${GREEN}Script $SCRIPTNAME Update Completed${ENDCOLOR}"
echo -e "${YELLOW}Current Script Version $VERSION${ENDCOLOR}"

# Install Docker Engine, containerd, and Docker Compose.

echo -e "${YELLOW}Update the apt package index and install packages to allow apt to use a repository over HTTPS${ENDCOLOR}"
echo " "
sleep 2
apt-get update -y
apt-get install ca-certificates curl gnupg -y
sleep 2
clear

echo -e "${YELLOW}Add Docker’s official GPG key:${ENDCOLOR}"
echo " "
sleep 2
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sleep 2
clear

echo -e "${YELLOW}Setting up the repository${ENDCOLOR}"
echo " "
sleep 2

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2
clear

echo -e "${YELLOW}Update the apt package index and Install Docker Engine, containerd, and Docker Compose.${ENDCOLOR}"
echo " "
sleep 2
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sleep 2