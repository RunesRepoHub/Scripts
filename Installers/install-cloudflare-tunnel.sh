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


mkdir -p /mnt/user/appdata/cloudflared/ && chmod -R 777 /mnt/user/appdata/cloudflared/

docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel login

TUNNELNAME=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "User:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --programbox "docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel create "$TUNNELNAME""

touch /mnt/user/appdata/cloudflared/config.yml

UUID=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "Tunnel UUID:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

REVERSEPROXYIP=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "https://" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

YOURDOMAIN=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "yourdomain.com:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

echo "tunnel: $UUID" >> /mnt/user/appdata/cloudflared/config.yml
echo "credentials-file: /home/nonroot/.cloudflared/$UUID.json" >> /mnt/user/appdata/cloudflared/config.yml
echo " " >> /mnt/user/appdata/cloudflared/config.yml
echo "# forward all traffic to Reverse Proxy w/ SSL" >> /mnt/user/appdata/cloudflared/config.yml
echo "    ingress:" >> /mnt/user/appdata/cloudflared/config.yml
echo "      - service: https://$REVERSEPROXYIP" >> /mnt/user/appdata/cloudflared/config.yml
echo "        originRequest:" >> /mnt/user/appdata/cloudflared/config.yml
echo "          originServerName: $YOURDOMAIN" >> /mnt/user/appdata/cloudflared/config.yml

docker run -it -d -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel run -- "$UUID"
