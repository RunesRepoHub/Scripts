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
         --backtitle "$scriptname - Version $version" \
         --inputbox "Enter the hostname:" 10 60 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --backtitle "$scriptname - Version $version" --infobox "Your Virtual Machine $hostname Is Now Being Made" 10 60 || break; done ; sleep 3 

if (( $? = 1 ))
then
    break 
else 
    curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
fi

declare -i COUNTER=1
{
while test $COUNTER -le 100
do
   echo $COUNTER
   COUNTER=COUNTER+1
   # do some task here
   sleep 3
done
} | dialog --title "Baking VM" --backtitle "$scriptname - Version $version" --gauge "Your Virtual Machine $hostname Is Now Being Made" 10 60 0


IP="$(curl -s GET https://n8n-prod.rp-helpdesk.com/webhook/ip)"

#!/bin/bash
# dynbox.sh - Yes/No box demo
dialog --title "SSH Into $IP" \
--backtitle "$scriptname - Version $version" \
--yesno "Do you want to ssh into $IP" 10 60

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