#!/bin/sh
dialog --menu "Choose an option" 10 30 3 1 Webscrapers 2 Make a Virtual Machine 3 Reboot Restart N8N 4 Docker Testing 5 Add Midnight Cron 6 Install Dockers 7 Quit 2>temp
 
 
# OK is pressed
if [ "$?" = "0" ]
then
        _return=$(cat temp)
 
        # /home is selected
        if [ "$_return" = "1" ]
        then
                bash ./Scripts/Sub-menu/Webscrapers/webscrapers.sh
        fi
 
         # /root is selected
        if [ "$_return" = "2" ]
        then
                bash ./Scripts/Sub-menu/Make-VM/makevm.sh
        fi
 
         # /tmp is selected
        if [ "$_return" = "3" ]
        then
                bash ./Scripts/Sub-menu/N8N/n8n-CnC.sh
        fi

        # /tmp is selected
        if [ "$_return" = "3" ]
        then
                bash ./Scripts/Sub-menu/Docker-Testing/docker-testing.sh
        fi

        # /tmp is selected
        if [ "$_return" = "3" ]
        then
                bash ./Scripts/CnC/add-midnight-cron.sh
        fi

        # /tmp is selected
        if [ "$_return" = "3" ]
        then
                bash ./Scripts/Sub-menu/Install-Dockers/Install-Dockers.sh
        fi

        # /tmp is selected
        if [ "$_return" = "3" ]
        then
                break
        fi
 
# Cancel is pressed
else
        echo "Cancel is pressed"
fi
 
# remove the temp file
rm -f temp