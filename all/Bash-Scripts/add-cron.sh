#!/bin/bash
crontab -l > crontab_new 
echo "2 0 * * * ~/Scripts/all/Bash-Scripts/testing.sh" >> crontab_new
crontab crontab_new
rm crontab_new
chmod +x ~/Scripts/all/Bash-Scripts/testing.sh
./testing.sh
