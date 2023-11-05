#!/bin/bash

# Read the URLs from the txt file
input_urls=$(cat ~/plex/media/url_file.txt)

output_path=~/plex/media/youtube

# Define the maximum number of running containers
max_containers=3

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

    # Check the number of running youtube-dl Docker containers
    while [ "$(docker ps | grep mikenye/youtube-dl | wc -l)" -ge "$max_containers" ]; do
        echo "Waiting for available youtube-dl container..."
        sleep 5
    done

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
        mikenye/youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' -o '/output/%(title)s.%(ext)s' "${url}"

    echo "Video downloaded successfully!"
done <<< "$input_urls"

