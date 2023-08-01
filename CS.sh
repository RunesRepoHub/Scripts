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
sleep 2
#!/bin/bash
clear

# Type your Login Information
echo "Login In To Get Started"
echo "--------------------------"
read -p 'Username: ' user
read -sp 'Password: ' pass
echo " "
echo "Logging In..."


# Check Users Login With Database
userdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-user)
passdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-pass)


# Check the username and password are valid or not
if (( $user == "$userdb" && $pass == "$passdb" ))
then
    clear
    echo -e "\nSuccessful login"
    echo "--------------------------"
    PS3='Please enter your choice: '
    options=("Webscrapers" "Make a Virtual Machine" "Reboot Restart N8N" "Docker Testing" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Webscrapers")
                # Export User/Pass for auth header in webscrapers
                export user="$userdb"
                export pass="$passdb"
                bash ./scripts/webscrapers/webscrapers.sh
                break
                ;;
            "Make a Virtual Machine")
                bash ./scripts/makevm/makevm.sh
                break
                ;;
            "Reboot Restart N8N")
                bash ./scripts/CnC/n8n-CnC.sh
                break
                ;;
            "Docker Testing")
                bash ./scripts/CnC/docker-testing.sh
                break
                ;;
            "Quit")
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
else
    clear
    echo -e "\nUnsuccessful login"
fi