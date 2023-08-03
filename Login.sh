user=$(\
  dialog --title "User" \
         --inputbox "User:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

pass=$(\
  dialog --title "Password" \
         --passwordbox "Password:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)
  
# Check Users Login With Database
userdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-user)
passdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-pass)
sessionid=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/sessionid)


# Check the username and password are valid or not
if (( $user == "$userdb" && $pass == "$passdb" ))
then
    touch /Scripts/.secrets
    echo "$sessionid" > .secret
    bash ./Scripts/Run-CnC.sh    
else 
    clear
    dialog --infobox "Unsuccessful login" 10 30 ; sleep 5
fi