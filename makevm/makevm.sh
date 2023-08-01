#!/bin/bash
# Bash Menu Script Example
echo "--------------------------"
PS3='Please enter your choice of OS and Disk Storage: '
options=("Debian 20GB" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Debian 20GB")
            bash ./scripts/makevm/make-debian-20gb.sh
            break
            ;;
        "Option 2")
            echo "you chose choice 2"
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
echo " "
echo "--------------------------"