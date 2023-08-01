#!/bin/bash
# Webscraper Menu
echo "--------------------------"
PS3='Please pick what store you want to add a link to: '
options=("Add Proshop Link" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add Proshop Link")
            bash ./scripts/webscrapers/proshop-pull.sh
            break
            ;;
        "Option 2")
            echo "$user:$pass"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done