# New Virtual Machine or Docker Menu
echo "--------------------------"
echo -e "${YELLOW}New or Old Virtual Machine/Docker:${ENDCOLOR} "
PS3='Please enter your choice: '
options=("New" "Old")
select opt in "${options[@]}"
do
    case $opt in
        "New")
            bash ./Scripts/Installers/apt-get-install.sh
            bash ./Scripts/Installers/install-starship.sh
            break
            ;;
        "Old")
            break
            ;;
        *) echo -e "${RED}invalid option $REPLY${ENDCOLOR}";;
    esac
done
clear