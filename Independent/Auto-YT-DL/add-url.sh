#!/bin/bash

# Prompt the user to enter the URLs
read -p "Enter the URL: " input_urls

# Read the existing URLs from the file
existing_urls=$(cat ~/plex/media/url_file.txt)

# Loop over each URL entered by the user
for url in $input_urls; do
    # Check if the URL already exists in the file
    if [[ $existing_urls =~ (^|[[:space:]])$url($|[[:space:]]) ]]; then
        echo "URL $url already exists, skipping..."
    else
        # Append the new URL to the file
        echo "$url" >> ~/plex/media/url_file.txt
    fi
done

bash ~/Auto-YT-DL/download.sh
