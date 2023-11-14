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
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
hostname="$(hostname)"

# Run apt-get update/upgrade
echo "Run apt-get update/upgrade"
sleep 2

# apt-get update
apt-get update -y
sleep 2

# apt-get upgrade
apt-get upgrade -y
sleep 2


curl \
  -H "Title: $hostname Now Rebooting" \
  -H "Priority: min" \
  -H "Tags: warning" \
  -d "$hostname has been updated and is now rebooting" \
  https://ntfy.rp-helpdesk.com/Servers

reboot now