#################################################################################################################################

#████████╗███████╗░██████╗████████╗
#╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
#░░░██║░░░█████╗░░╚█████╗░░░░██║░░░
#░░░██║░░░██╔══╝░░░╚═══██╗░░░██║░░░
#░░░██║░░░███████╗██████╔╝░░░██║░░░
#░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░


# Define the file where you want to save the date and time
output_file="date_time.txt"

# Use the date command to get the current date and time
current_datetime=$(date)

# Append the date and time to the file
echo "$current_datetime" >> "$output_file"

# Optionally, you can also print the date and time to the terminal
echo "Current date and time: $current_datetime"

# Exit the script
exit 0