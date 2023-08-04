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
#!/usr/bin/env bash


# Take input without defining variable  
reply=$(\
  dialog --title "Kopier dit proshop link her" \
         --backtitle "$scriptname - Version $version" \
         --inputbox "Proshop Link:" 10 60 \
  3>&1 1>&2 2>&3 3>&- \
)


# Print the input value
dialog --backtitle "$scriptname - Version $version" --prgbox "Reply from Server" "curl -X GET https://n8n-b.rp-helpdesk.com/webhook/proshop-pull-link/?url=$reply" 10 60
