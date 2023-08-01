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
SCRIPTNAME="Run-CnC.sh"

# Script Auto Self Update
echo -e "${BLUE}Script $SCRIPTNAME Updating${ENDCOLOR}"
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

echo -e "${GREEN}Script $SCRIPTNAME Updating Complete${ENDCOLOR}"
echo -e "${YELLOW}Current Script Version $VERSION${ENDCOLOR}"

# New Virtual Machine or Docker Menu
echo "--------------------------"
PS3='New Virtual Machine or Docker: '
options=("New" "Old")
select opt in "${options[@]}"
do
    case $opt in
        "New")
            bash ./Scripts/CnC/apt-get-install.sh
            bash ./Scripts/installers/install-starship.sh
            break
            ;;
        "Old")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear

# Type your Login Information
echo -e "${GREEN}Login In To Get Started${ENDCOLOR}"
echo -e "${GREEN}--------------------------${ENDCOLOR}"
read -p 'Username: ' user
read -sp 'Password: ' pass
echo -e "${GREEN}\n--------------------------${ENDCOLOR}"
echo " "
echo -e "${GREEN}\nLogging In...${ENDCOLOR}"


# Check Users Login With Database
userdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-user)
passdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-pass)


# Check the username and password are valid or not
if (( $user == "$userdb" && $pass == "$passdb" ))
then 
    while true; do
    options=("Check for update" "Reinstall theme")

    echo "Choose an option:"
    select opt in "${options[@]}"; do
        case $REPLY in
            1) check_update; break ;;
            2) reinstall_theme; break ;;
            *) echo "What's that?" >&2
        esac
    done

    echo "Doing other things..."

    echo "Are we done?"
    select opt in "Yes" "No"; do
        case $REPLY in
            1) break 2 ;;
            2) break ;;
            *) echo "Look, it's a simple question..." >&2
        esac
    done
done
else 
    clear
    echo -e "${GREEN}\nUnsuccessful login${ENDCOLOR}"
fi