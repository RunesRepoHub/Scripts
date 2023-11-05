#!/bin/bash

# Prompt the user to enter the URLs
read -p "Enter the URLs (separated by spaces): " input_urls

# Save the URLs to a file
echo "$input_urls" > ~/plex/media/url_file.txt

bash ~/Auto-YT-DL/download.sh