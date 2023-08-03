## |--------------------------------|
## |       Made By Rune004          |
## |    Need Support or Help?       |
## |    It can be found below.      |
## |                                |
## |            Discord:            |
## | https://discord.gg/UHd4tJg9Vm  |
## |                                |
## |            Github:             |
## |  https://github.com/rune004    |
## |--------------------------------|


echo -e "${GREEN}Script $SCRIPTNAME Updating Complete${ENDCOLOR}"
echo -e "${YELLOW}Current Script Version $VERSION${ENDCOLOR}"

# Install and Configure Starship
echo -e "${YELLOW}Do you want to Install and Configure Starship?${ENDCOLOR}"
read -p "(yes/no) " starship

case $starship in 
	yes ) 
  echo -e "${GREEN}Beginning installation${ENDCOLOR}"
  curl -sS https://starship.rs/install.sh | sh
  sleep 2
  echo 'eval "$(starship init bash)"' >> ~/.bashrc
  ;;
	no ) echo skipping...;
		break;;
	* ) echo invalid response;
    sleep 2
		exit 1;;
esac
clear