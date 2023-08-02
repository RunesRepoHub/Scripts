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
SCRIPTNAME="n8n-CnC.sh"

# Script Auto Self Update
VERSION="0.0.2"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/Sub-menu/N8N/n8n-CnC.sh'
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


# N8N CnC Menu
echo "--------------------------"
while true; do
    PS3='Please pick what n8n server you want to reboot: '
    options=("Restart N8N Backend" "Restart N8N Prod" "Restart N8N MySQL" "Quit")
    clear
    echo "Choose an option by input a nummer:"
    select opt in "${options[@]}"; do
        case $REPLY in
        1)
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-backend"
            echo " "
            break
            ;;
        2)
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-prod"
            echo " "
            break
            ;;
        3)
            curl -s GET "https://n8n-b.rp-helpdesk.com/webhook/reboot-N8N-mysql"
            echo " "
            break
            ;;
        4)
            break 2
            ;;
        *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
        esac
    done
done