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

mkdir -p /mnt/user/appdata/cloudflared/ && chmod -R 777 /mnt/user/appdata/cloudflared/

docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel login

echo "Input a tunnel name for the cloudflare dashboard"
read -p 'Tunnel Name: ' TUNNELNAME

docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel create "$TUNNELNAME"

touch /mnt/user/appdata/cloudflared/config.yml

echo "Make config file"
read -p 'Tunnel UUID: ' UUID
read -p 'https://REVERSEPROXYIP:PORT ' REVERSEPROXYIP
read -p 'yourdomain.com ' YOURDOMAIN


echo "tunnel: $UUID" >> /mnt/user/appdata/cloudflared/config.yml
echo "credentials-file: /home/nonroot/.cloudflared/$UUID.json" >> /mnt/user/appdata/cloudflared/config.yml
echo " " >> /mnt/user/appdata/cloudflared/config.yml
echo "# forward all traffic to Reverse Proxy w/ SSL" >> /mnt/user/appdata/cloudflared/config.yml
echo "    ingress:" >> /mnt/user/appdata/cloudflared/config.yml
echo "      - service: https://$REVERSEPROXYIP" >> /mnt/user/appdata/cloudflared/config.yml
echo "        originRequest:" >> /mnt/user/appdata/cloudflared/config.yml
echo "          originServerName: $YOURDOMAIN" >> /mnt/user/appdata/cloudflared/config.yml

docker run -it -d -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel run -- "$UUID"
