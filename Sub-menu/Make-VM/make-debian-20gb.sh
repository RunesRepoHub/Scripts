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
VERSION="0.0.1"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/'
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


# Make Debian VM Automation Script With IP Pull  

dialog --msgbox "Pick The Settings For Setting Up A VM" 10 30 ;

hostname=$(\
  dialog --title "VM Hostname" \
         --inputbox "Enter the hostname:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --infobox "Your Virtual Machine Is Now Being Made" 10 30 ; sleep 5

curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
sleep 180

exit

dialog --msgbox "curl -X GET "$(https://n8n-prod.rp-helpdesk.com/webhook/ip")" 10 30 ;