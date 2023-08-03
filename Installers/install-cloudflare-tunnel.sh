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

dialog --prgbox "Cloudflare Docker Login" "docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel login" 20 60 

TUNNELNAME=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "Tunnel Name:" 10 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --prgbox "Docker Create Tunnel" "docker run -it --rm -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel create $TUNNELNAME" 20 60 

touch /mnt/user/appdata/cloudflared/config.yml

UUID=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "Tunnel UUID:" 10 40 \
  3>&1 1>&2 2>&3 3>&- \
)

REVERSEPROXYIP=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "https://" 10 40 \
  3>&1 1>&2 2>&3 3>&- \
)

YOURDOMAIN=$(\
  dialog --title "$scriptname - Install Cloudflare Tunnel" \
         --inputbox "yourdomain.com:" 10 40 \
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

dialog --prgbox "Docker Run Cloudflare" "docker run -it -d -v /mnt/user/appdata/cloudflared:/home/nonroot/.cloudflared/ cloudflare/cloudflared:latest tunnel run -- $UUID" 20 60
