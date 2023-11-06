#!/bin/bash

# Specify the parent folder path
parent_folder="~/plex/media/youtube"

# Create a directory to store the output files
output_folder="~/plex/media/youtube"
mkdir -p "$output_folder"

# Specify the blacklist file path
blacklist_file="~/plex/media/youtube/blacklist.txt"

# Iterate over the subfolders in the parent folder
for folder_path in "$parent_folder"/*; do
    # Get the folder name
    folder_name=$(basename "$folder_path")

    # Get the number of times each file has been accessed by plex
    access_count=$(grep -o "plex" /var/log/syslog | grep "$folder_path" | wc -l)

    # Check if the folder should be blacklisted
    if [ "$access_count" -gt 3 ]; then
        echo "$folder_name" >> "$blacklist_file"
    else
        # Create a text file for the folder and write the access count
        echo "The files in $folder_path have been accessed by plex $access_count times." > "$output_folder/$folder_name.txt"
    fi

    # Check if the file is not on the blacklist and is over 3 months old
    if ! grep -q "$folder_name" "$blacklist_file" && [ "$(find "$folder_path" -type f -mtime +"$days" | wc -l)" -gt 0 ]; then
        # Remove the file
        find "$folder_path" -type f -mtime +"$days" -exec rm {} \;
    fi
done

