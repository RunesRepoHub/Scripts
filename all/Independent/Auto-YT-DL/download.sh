#!/bin/bash

# Read the URLs from the txt file
input_urls=$(cat ~/plex/media/url_file.txt)

output_path=~/plex/media/youtube

# Loop over each URL
while read -r url; do
    # Set the video file path
    video_folder="${output_path}/$(echo "${url}" | awk -F '=' '{print $2}')"
    video_file="${video_folder}/$(echo "${url}" | awk -F '=' '{print $2}').mp4"

    # Check if the video file exists
    if [ -f "${video_file}" ]; then
        # Check if the video was last accessed more than 1 month ago
        last_access_time=$(stat -c %X "${video_file}")
        current_time=$(date +%s)
        one_month_ago=$((current_time - 30 * 24 * 60 * 60))

        if (( last_access_time < one_month_ago )); then
            # Remove the video file
            rm "${video_file}"
            echo "Video deleted successfully!"
        else
            echo "Video has already been downloaded!"
            continue
        fi
    fi

    # Create the video folder if it doesn't exist
    mkdir -p "${video_folder}"

    # Download video using docker run command
    docker run \
        --rm -i \
        -e PGID=$(id -g) \
        -e PUID=$(id -u) \
        -v "$(pwd)":/workdir:rw \
        -v "${video_folder}":/output:rw \
        mikenye/youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o '/output/%(title)s.%(ext)s' "${url}"

    echo "Video downloaded successfully!"
done <<< "$input_urls"

