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
# Variables
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
box1="Update the apt package index and install packages to allow apt to use a repository over HTTPS"
box2="Add Docker’s official GPG key:"
box3="Setting up the repository"
box4="Update the apt package index and Install Docker Engine, containerd, and Docker Compose."
#------------------------------------------------------------------------------------------------------------------------------

# Install Docker Engine, containerd, and Docker Compose.
#------------------------------------------------------------------------------------------------------------------------------
# Update the apt package index and install packages to allow apt to use a repository over HTTPS

dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box1" "apt-get update -y" 40 60

dialog --title "$me" --clear \
       --prgbox "$box1" "apt-get install ca-certificates curl gnupg -y" 40 60

#------------------------------------------------------------------------------------------------------------------------------
# Add Docker’s official GPG key:
dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box2" "install -m 0755 -d /etc/apt/keyrings" 40 60

dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box2" "curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg" 40 60

dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box2" "chmod a+r /etc/apt/keyrings/docker.gpg" 40 60

#------------------------------------------------------------------------------------------------------------------------------
# Setting up the repository


dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box3" "echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null" 40 60

#------------------------------------------------------------------------------------------------------------------------------
# Update the apt package index and Install Docker Engine, containerd, and Docker Compose.

dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box4" "apt-get update -y" 40 60

dialog --title "$me" --clear \
       --backtitle "$scriptname - Version $version" \
       --prgbox "$box4" "apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y" 40 60

#------------------------------------------------------------------------------------------------------------------------------
