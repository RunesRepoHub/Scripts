##### Styles ######
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
BrownOrange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m'
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'
White='\e[1;37m'
NC='\e[0m'  # Reset to default
###################

# Make the folder
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"
echo -e "${Yellow}Make the folder ~/Auto-YT-DL${NC}"
mkdir -p ~/Auto-YT-DL/

sleep 2

echo -e "${Purple}Downloading files...${NC}"

curl -s -o ~/Auto-YT-DL/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/automated-check.sh > /dev/null

curl -s -o ~/Auto-YT-DL/cleanup.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/cleanup.sh > /dev/null

curl -s -o ~/Auto-YT-DL/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/add-url.sh > /dev/null

curl -s -o ~/Auto-YT-DL/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/setup-plex.sh > /dev/null

curl -s -o ~/Auto-YT-DL/download.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/download.sh > /dev/null

sleep 2

echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library
fi

bash ~/Auto-YT-DL/add-url.sh

sleep 2

echo -e "${Purple}Setting up plex...${NC}"

bash ~/Auto-YT-DL/setup-plex.sh


echo -e "${Purple}Setup cronjob and alias${NC}"

alias add-url="bash ~/Auto-YT-DL/add-url.sh"

echo -e "${Green}Done!${NC}"