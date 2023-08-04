user=$(\
  dialog --title "Login" \
         --backtitle "$scriptname - Version $version" \
         --inputbox "User:" 10 60 \
  3>&1 1>&2 2>&3 3>&- \
)

pass=$(\
  dialog --title "Login" \
         --backtitle "$scriptname - Version $version" \
         --passwordbox "Password:" 10 60 \
  3>&1 1>&2 2>&3 3>&- \
)
  
# Check Users Login With Database
userdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-user)
passdb=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/login-pass)
token=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/token)
sessionid=$(curl -s --user $user:$pass https://n8n-b.rp-helpdesk.com/webhook/sessionid)

export user="$user"
export pass="$pass"
export userdb="$userdb"
export passdb="$passdb"
export token="$token"
export sessionid="$sessionid"

# Check the username and password are valid or not
if (( $user == "$userdb" && $pass == "$passdb" && $sessionid == "$sessionid" ))
then
    bash ./Scripts/Menu/Main-Menu.sh
else 
    clear
    dialog --title "Login" --backtitle "$scriptname - Version $version" --infobox "Unsuccessful login" 10 60 ; sleep 5
fi