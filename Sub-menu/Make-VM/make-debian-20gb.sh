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
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"


# Make Debian VM Automation Script With IP Pull  

hostname=$(\
  dialog --title "VM Hostname" \
         --inputbox "Enter the hostname:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --infobox "Your Virtual Machine Is Now Being Made" 10 30 ; sleep 3

curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"

dialog --title "$me" \
       --gauge "5 mins left" 10 30 5 ; 
sleep 60
clear

dialog --title "$me" \
       --gauge "4 mins left" 10 30 15 ; 
sleep 60
clear

dialog --title "$me" \
       --gauge "3 mins left" 10 30 35 ; 
sleep 60
clear

dialog --title "$me" \
       --gauge "2 mins left" 10 30 55 ; 
sleep 60
clear

dialog --title "$me" \
       --gauge "1 mins left" 10 30 75 ; 
sleep 30
clear

dialog --title "$me" \
       --gauge "30 sekundes left" 10 30 85 ; 
sleep 10
clear

dialog --title "$me" \
       --gauge "20 sekundes left" 10 30 90 ; 
sleep 10
clear

dialog --title "$me" \
       --gauge "10 sekundes left" 10 30 95 ; 
sleep 5
clear

dialog --title "$me" \
       --gauge "5 sekundes left" 10 30 98 ; 
sleep 5
clear

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