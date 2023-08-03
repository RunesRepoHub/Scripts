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
SCRIPT="Ubuntu-22-04"

docker stop $SCRIPT
docker rm $SCRIPT
docker volume prune -y

docker run -i -d --name="$SCRIPT" ubuntu:22.04
docker exec -i $SCRIPT /bin/bash
apt-get update
apt-get upgrade -y
apt-get install curl -y
apt-get install git -y
cd root
git clone https://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@github.com/rune004/Scripts.git