#!/bin/bash
sudo /bin/bash -c 'echo "30 4 * * * root ~/Scripts/all/Bash-Scripts/midnight-midget.sh" >> /etc/crontab'
chmod +x ~/Scripts/all/Bash-Scripts/midnight-midget.sh
