mkdir -p ~/Auto-YT-DL/

sleep 2

curl -o ~/Auto-YT-DL/cleanup.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/cleanup.sh
curl -o ~/Auto-YT-DL/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/add-url.sh
curl -o ~/Auto-YT-DL/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/setup-plex.sh
curl -o ~/Auto-YT-DL/download.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/Independent/Auto-YT-DL/download.sh

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library
fi

bash ~/Auto-YT-DL/add-url.sh

sleep 2

bash ~/Auto-YT-DL/setup-plex.sh

0 0 * * * bash ~/Auto-YT-DL/automated-check.sh

touch ~/.bash_aliases
touch ~/.bashrc

add_url_command="alias add-url='bash ~/Auto-YT-DL/add-url.sh'"

# Add the command to .bash_aliases if not already present
if ! grep -q "$add_url_command" ~/.bash_aliases; then
    echo "$add_url_command" >> ~/.bash_aliases
fi

# Add the command to .bashrc if not already present
if ! grep -q "$add_url_command" ~/.bashrc; then
    echo "$add_url_command" >> ~/.bashrc
fi

# Reload the .bash_aliases and .bashrc files
source ~/.bash_aliases
source ~/.bashrc
