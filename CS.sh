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