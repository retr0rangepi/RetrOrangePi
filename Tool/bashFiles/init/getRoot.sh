#!/bin/bash
# Nombre: run.sh
# Description: Script to ask for root permissions
#############################
set -e # Don't allow any error

while : ; do # Loop until root password is correct or Cancel button is pressed
	PASSWD=$(whiptail --title "BashTool_ROPI_RCA" --passwordbox "The Tool needs root privileges.\nEnter the root password:" 10 60 3>&1 1>&2 2>&3) # Password screen

	sudo -k # Reset credential petition
	if sudo -lS &> /dev/null << EOF # Check the password
$PASSWD
EOF
	then
		whiptail --title "BashTool_ROPI_RCA" --msgbox "Root password verified, the script has obtained permissions" 10 60 0 --cancel-button Exit --ok-button Ok # Correct Password screen
		break 
	else
		whiptail --title "BashTool_ROPI_RCA" --msgbox "Invalid password, try again..." 10 60 0 --cancel-button Exit --ok-button Retry # Bad Password screen
	fi
done

echo $PASSWD | sudo ls &> /dev/null 2>&1 # Show any error as output. Redirect stderr descriptor to stdout descriptor (1>&2 redirect stdout to stderr)