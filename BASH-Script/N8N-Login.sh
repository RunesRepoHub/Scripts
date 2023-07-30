!/bin/bash
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
else
    clear
    echo -e "\nUnsuccessful login"
fi