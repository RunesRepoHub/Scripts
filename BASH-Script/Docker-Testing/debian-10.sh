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

# Script Auto Self Update
echo -e "${BLUE}Script Self Updating${ENDCOLOR}"
VERSION="0.0.9"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Docker-Testing/debian-10.sh'
SCRIPT_DESCRIPTION=""
SCRIPT_LOCATION="${BASH_SOURCE[@]}"

rm -f updater.sh

function update()
{
    TMP_FILE=$(mktemp -p "" "XXXXX.sh")
    curl -s -O "$SCRIPT_URL" > "$TMP_FILE"
    NEW_VER=$(grep "^VERSION" "$TMP_FILE" | awk -F'[="]' '{print $3}')
    ABS_SCRIPT_PATH=$(readlink -f "$SCRIPT_LOCATION")
    if [ "$VERSION" \< "$NEW_VER" ]
    then
        printf "Updating script \e[31;1m%s\e[0m -> \e[32;1m%s\e[0m\n" "$VERSION" "$NEW_VER"

        echo "cp \"$TMP_FILE\" \"$ABS_SCRIPT_PATH\"" > updater.sh
        echo "rm -f \"$TMP_FILE\"" >> updater.sh
        echo "echo Running script again: `basename ${BASH_SOURCE[@]}` $@" >> updater.sh
        echo "exec \"$ABS_SCRIPT_PATH\" \"$@\"" >> updater.sh

        chmod +x updater.sh
        chmod +x "$TMP_FILE"
        exec updater.sh
    else
        rm -f "$TMP_FILE"
    fi
}

update "$@"

echo "$@"

echo -e "${GREEN}Script Self Updating Complete${ENDCOLOR}"
echo -e "${YELLOW}Current Script Version $VERSION${ENDCOLOR}"

docker stop Debian-10
docker rm Debian-10

docker run -i -d --name="Debian-10" debian:10
docker exec -i Debian-10 /bin/bash
apt-get update
apt-get upgrade -y
apt-get install curl -y
curl -s -O https://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@github.com/rune004/Scripts/tree/main