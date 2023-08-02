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
VERSION="0.0.3"
SCRIPT_URL='https://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@raw.githubusercontent.com/rune004/Scripts/main/Run-CnC.sh'
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

# New Virtual Machine or Docker Menu
echo "--------------------------"
echo -e "${YELLOW}New or Old Virtual Machine/Docker:${ENDCOLOR} "
PS3='Please enter your choice: '
options=("New" "Old")
select opt in "${options[@]}"
do
    case $opt in
        "New")
            bash ./Scripts/Installers/apt-get-install.sh
            bash ./Scripts/Installers/install-starship.sh
            break
            ;;
        "Old")
            break
            ;;
        *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
    esac
done
clear

# Type your Login Information
echo -e "${GREEN}Login In To Get Started${ENDCOLOR}"
echo -e "${GREEN}--------------------------${ENDCOLOR}"
read -p 'Username: ' user
read -sp 'Password: ' pass
echo -e "${GREEN}\n--------------------------${ENDCOLOR}"
echo -e "${GREEN}\nLogging In...${ENDCOLOR}"
sleep 2
clear

# Check Users Login With Database
userdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-user)
passdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-pass)


# Check the username and password are valid or not
if (( $user == "$userdb" && $pass == "$passdb" ))
then 
    while true; do
    options=("Webscrapers" "Make a Virtual Machine" "Reboot Restart N8N" "Docker Testing" "Add Midnight Cron" "Install Dockers" "Quit")
    clear
    echo -e "${YELLOW}Choose an option by input a nummer:${ENDCOLOR}"
    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                # Export User/Pass for auth header in webscrapers
                export user="$userdb"
                export pass="$passdb"
                bash ./Scripts/Sub-menu/Webscrapers/webscrapers.sh
                break
                ;;
            2)
                bash ./Scripts/Sub-menu/Make-VM/makevm.sh
                break
                ;;
            3)
                bash ./Scripts/Sub-menu/N8N/n8n-CnC.sh
                break
                ;;
            4)
                bash ./Scripts/Sub-menu/Docker-Testing/docker-testing.sh
                break
                ;;
            5)
                bash ./Scripts/CnC/add-midnight-cron.sh
                break
                ;;
            6)
                bash ./Scripts/CnC/add-midnight-cron.sh
                break
                ;;
            7)
                break
                ;;
            *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
        esac
    done

    clear
    echo -e "${RED}Are you done?${ENDCOLOR}"
    select opt in "Yes" "No"; do
        case $REPLY in
            1) break 2 ;;
            2) clear 
            break ;;
            *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
        esac
    done
done
else 
    clear
    echo -e "${RED}\nUnsuccessful login${ENDCOLOR}"
fi
