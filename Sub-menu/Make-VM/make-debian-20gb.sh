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

dialog --infobox "Your Virtual Machine Is Now Being Made" 10 30 ; sleep 3

curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
dialog --gauge "5 mins left" 5 10 30 ; sleep 60
dialog --gauge "4 mins left" 15 10 30 ; sleep 60
dialog --gauge "3 mins left" 35 10 30 ; sleep 60
dialog --gauge "2 mins left" 55 10 30 ; sleep 60
dialog --gauge "1 mins left" 75 10 30 ; sleep 30
dialog --gauge "30 sekundes left" 85 10 30 ; sleep 10
dialog --gauge "20 sekundes left" 90 10 30 ; sleep 10
dialog --gauge "10 sekundes left" 95 10 30 ; sleep 5
dialog --gauge "5 sekundes left" 98 10 30 ; sleep 5

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