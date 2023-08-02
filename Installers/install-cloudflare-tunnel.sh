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
#!/usr/bin/env bash
clear 

# Bash Text Variables
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
SCRIPTNAME=""

# Script Auto Self Update
VERSION="0.0.3"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/Installers/install-cloudflare-tunnel.sh'
SCRIPT_DESCRIPTION=""
SCRIPT_LOCATION="${BASH_SOURCE[@]}"
FILE_UPDATER=updater.sh

rm -f "$FILE_UPDATER"

function update()
{
    TMP_FILE=$(mktemp -p "" "XXXXX.sh")
    curl -s -O "$SCRIPT_URL" > "$TMP_FILE"
    NEW_VER=$(grep "^VERSION" "$TMP_FILE" | awk -F'[="]' '{print $3}')
    ABS_SCRIPT_PATH=$(readlink -f "$SCRIPT_LOCATION")
    if [ "$VERSION" \< "$NEW_VER" ]
    then
        printf "Updating script \e[31;1m%s\e[0m -> \e[32;1m%s\e[0m\n" "$VERSION" "$NEW_VER"

        echo "cp \"$TMP_FILE\" \"$ABS_SCRIPT_PATH\"" > "$FILE_UPDATER"
        echo "rm -f \"$TMP_FILE\"" >> "$FILE_UPDATER"
        echo "echo Running script again: `basename ${BASH_SOURCE[@]}` $@" >> "$FILE_UPDATER"
        echo "exec \"$ABS_SCRIPT_PATH\" \"$@\"" >> "$FILE_UPDATER"

        chmod +x "$FILE_UPDATER"
        chmod +x "$TMP_FILE"
        exec "$FILE_UPDATER"
    else
        rm -f "$TMP_FILE"
    fi
}

update "$@"
echo "$@"
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
