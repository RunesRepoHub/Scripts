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



# Make Debian VM Automation Script With IP Pull  

hostname=$(\
  dialog --title "VM Hostname" \
         --inputbox "Enter the hostname:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --infobox "Your Virtual Machine Is Now Being Made" 10 30 ; sleep 5

curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
sleep 180

IP="$(curl -s GET https://n8n-prod.rp-helpdesk.com/webhook/ip)"

#!/bin/bash
# dynbox.sh - Yes/No box demo
dialog --title "SSH" \
--yesno "Do you want to ssh into $IP" 7 60

# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) 
   
   ssh root@$IP
   ;;
   1) 
   break ;;
   255) echo "[ESC] key pressed.";;
esac