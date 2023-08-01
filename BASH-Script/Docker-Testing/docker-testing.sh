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
VERSION="0.0.3"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Docker-Testing/docker-testing.sh'
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

echo -e "${YELLOW}Make sure you are in the same folder as the script${ENDCOLOR}"
PS3='Please pick what docker you want for testing: '
options=("Debian 10" "Debian 11" "Ubuntu 22.04" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Debian 10")
            ssh -t root@192.168.1.191 ksh bash -l
            sleep 2
            docker run -td --name="Debian-10" debian:10
            sleep 2
            read -p 'URL: ' url
            id=$(docker ps -aqf "name=Debian-10")
            docker exec -it $id /bin/bash
            curl -s -O https://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@$url
            break
            ;;
        "Debian 11")
            echo "$user:$pass"
            ;;
        "Ubuntu 22.04")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done