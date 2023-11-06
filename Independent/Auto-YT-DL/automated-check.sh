#!/bin/bash

# Read the URLs from the txt file
input_urls=$(cat ~/plex/media/url_file.txt)

output_path=~/plex/media/youtube

# Define the maximum number of running containers
max_containers=3


# Loop through each URL in the input_urls
while read -r url; do
    # Set the video file path
    video_folder="${output_path}/$(echo "${url}" | awk -F '=' '{print $2}')"
    video_file="${video_folder}/$(echo "${url}" | awk -F '=' '{print $2}').mp4"

    # Create the video folder if it doesn't exist
    mkdir -p "${video_folder}"

    # Check if the video file already exists using the archive function in youtube-dl
    if docker run --rm \
        -e PGID=$(id -g) \
        -e PUID=$(id -u) \
        -v "$(pwd)":/workdir:rw \
        -v "${video_folder}":/output:rw \
        mikenye/youtube-dl \
        --get-filename \
        --skip-download \
        --write-archive /output/archive.txt \
        --output '/output/%(title)s.%(ext)s' \
        "${url}" | grep -qF "$video_file"; then

        echo "Video already downloaded: $video_file"
    else
        # Download video using docker run command in detached mode and delete the container when finished
        docker run \
            --rm -d \
            -e PGID=$(id -g) \
            -e PUID=$(id -u) \
            -v "$(pwd)":/workdir:rw \
            -v "${video_folder}":/output:rw \
            --name "$(echo "${url}" | awk -F '=' '{print $2}')" \
            --cpus 1 \
            --memory 2g \
            mikenye/youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' \
            --write-info-json \
            --write-thumbnail \
            --write-description \
            --write-sub \
            --embed-subs \
            --convert-subs srt \
            --write-auto-sub \
            --write-archive /output/archive.txt \
            --output '/output/%(title)s.%(ext)s' \
            "${url}"

        if [ -f "$video_file" ]; then
            echo "Video downloaded successfully: $video_file"
        else
            echo "Failed to download video: $video_file"
        fi
    fi
done <<< "$input_urls"

