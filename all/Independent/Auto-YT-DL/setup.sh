mkdir -p ~/Auto-YT-DL

curl -o ~/Auto-YT-DL/cleanup.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/all/Independent/Auto-YT-DL/cleanup.sh
curl -o ~/Auto-YT-DL/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/all/Independent/Auto-YT-DL/add-url.sh
curl -o ~/Auto-YT-DL/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/all/Independent/Auto-YT-DL/setup-plex.sh
curl -o ~/Auto-YT-DL/download.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/Dev/all/Independent/Auto-YT-DL/download.sh

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library
fi

bash ~/Auto-YT-DL/add-url.sh

sleep 2

bash ~/Auto-YT-DL/setup-plex.sh

