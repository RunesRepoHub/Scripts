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
version="$(cat /Scripts/Version)"
Scriptname="$(cat /Scripts/Scriptname)"


# Make Debian VM Automation Script With IP Pull  

dialog --msgbox "Pick The Settings For Setting Up A VM" 10 30 ;

hostname=$(\
  dialog --title "VM Hostname" \
         --inputbox "Enter the hostname:" 8 40 \
  3>&1 1>&2 2>&3 3>&- \
)

dialog --infobox "Your Virtual Machine Is Now Being Made" 10 30 ; sleep 5

curl -X POST "https://n8n-prod.rp-helpdesk.com/webhook/K3s-boot-linux?hostname=$hostname"
sleep 180

dialog --msgbox "$(curl -X GET https://n8n-prod.rp-helpdesk.com/webhook/ip)" 10 30 ;