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
    bash ./Scripts/Run-CnC.sh
else 
    clear
    dialog --infobox "Unsuccessful login" 10 30 ; sleep 5
fi
