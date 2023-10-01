# Scripts

**Testing**

### Support
Get support via Discord:
[Discord](https://discord.gg/UHd4tJg9Vm)

### Fix Download Access
- Step 1. `apt-get install git`
- Step 2. `git config --global hub.protocol https`
- Step 3. `git config --global credential.helper store`
- Step 4. `git clone https://Rune004:GithubToken@github.com/rune004/Scripts.git`

### If you only need a single script
- `curl -s -O https://GithubToken@raw.githubusercontent.com/rune004/Scripts/main/BASH-Script/Quick-Deploy-Script/Quick-Deployer.sh'`

# Command And Control "CnC"
All listed below is bash scripts and all other files used within this application to make it run. These can in some cases by used without any other scripts and files from this repo. Most of them will be secured and can therefore not used as a standalone services. 

-------------------------------------
## Quick-Deployer

Quick-Deployer is made for Debian 10 and 11 VM's, so that they can be brought up to speed a lot quick then manual installing the same software and programs, and also configure the VM's settings.


### Features:
- Update/Upgrade VM
- Change hostname via variables
- Change IP to static via variables
- Install Docker Engine, containerd, and Docker Compose.

Full Changelog: https://github.com/rune004/scripts/commits/v1.1


### Planned or Upcoming Features:

- Install and Configure Starship
- Install and Configure Checkmk
- Install and Configure Wazuh 
- Install and Configure Cloudflare Tunnel
- Add Nightly Reboot Cron
- Add Nightly Update Cron

-------------------------------------

## Quick-Auther 

Quick-Auther is made for any Linux OS, it functions by taking user inputs (Password/Username) and check them against a database hosted by my Proxmox Cluster.

### Features:
- Vaildates Username and Password


### Planned or Upcoming Features:
- Requests a session token 
- Vaildate session token between scripts
- Request server has basic authentication to improve security

-------------------------------------