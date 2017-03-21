#!/bin/bash
# Nombre: main.sh
# Description: Main Script
#############################

# Global Parameters
set -e # No errors allowed

#############################

OPTION=$(whiptail --title "BashTool_ROPI_RCA" --menu "Choose an option" 15 55 5 --cancel-button Finish --ok-button Select \
	"0"   "Set RCA Video & Audio Output, Disable HDMI" \
	"1"   "Set HDMI Video & Audio Output, Disable RCA" \
	"2"   "Exit" \
	3>&1 1>&2 2>&3)

if [ $OPTION = "0" ]; then # Set RCA
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/rca/script.bin /boot/script.bin
	echo "tv" >> /etc/modules
	
	# Audio setup
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc ~/.asoundrc
	amixer -c 0 set "Audio lineout" unmute
	
elif [ $OPTION = "1" ]; then # Set HDMI
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/hdmi/script.bin /boot/script.bin
	
	# Audio setup
	cp -a files/hdmi/bgmusic.py /home/pi/RetroPie/music/bgmusic.py
	cp -a files/hdmi/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/hdmi/asound.conf /etc/asound.conf
	cp -a files/hdmi/asoundrc ~/.asoundrc
	
elif [ $OPTION = "2" ]; then
	exit
else
	echo "Tool Error"
	exit
fi

whiptail --title "BashTool_ROPI_RCA" --msgbox "Configuration applied" 10 55 5
if (whiptail --title "BashTool_ROPI_RCA" --yesno "It is necessary reboot the system. Reboot now?" 8 78) then
    # Yes
	reboot
else
	# No
    exit
fi
