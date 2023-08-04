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

echo -e "${GREEN}Add a Cron job for apt-get update/upgrade and reboot at midnight${ENDCOLOR}"

# Make the file directory if it dosen't exist
mkdir /opt/Scripts

# Copy file midnight-midget.sh to a "commen" system location
curl -s -O https://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@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Cron/midnight-midget.sh
cp midnight-midget.sh /opt/Scripts/midnight-midget.sh
rm midnight-midget.sh

# Command to add a symbolic link in /usr/bin/
ln -s /opt/Scripts/midnight-midget.sh /usr/bin/

# Setup cron settings
crontab -l > file; echo '00 00 * * * ruby /opt/Scripts/midnight-midget.sh >/dev/null 2>&1' >> file; crontab file