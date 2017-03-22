#!/bin/bash
# Nombre: main.sh
# Description: Main Script
#############################

# Global Parameters
set -e # No errors allowed

#############################

# Menu Screen. Select option
OPTION=$(whiptail --title "BashTool_ROPI_RCA" --menu "Choose an option" 15 60 0 --cancel-button Exit --ok-button Select \
	"1" "HDMI Video & Audio. RCA Disabled" \
	"2" "RCA Video & Audio. HDMI Disabled" \
	"3" "HDMI Video. RCA Audio" \
	"4" "RCA Video. HDMI Audio" \
	3>&1 1>&2 2>&3)

# Manage Option Selected. Configure System Video & Audio Output
if [ $OPTION = "1" ]; then # Set: HDMI Video & Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/hdmi/script.bin /boot/script.bin
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	
	# Audio setup
	cp -a files/hdmi/bgmusic.py /home/pi/RetroPie/music/bgmusic.py
	cp -a files/hdmi/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/hdmi/asound.conf /etc/asound.conf
	cp -a files/hdmi/asoundrc /home/pi/.asoundrc
	
elif [ $OPTION = "2" ]; then # Set: RCA Video & Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/rca/script.bin /boot/script.bin
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	echo "tv" >> /etc/modules
	
	# Audio setup
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc /home/pi/.asoundrc
	amixer -c 0 set "Audio lineout" unmute

elif [ $OPTION = "3" ]; then # Set: HDMI Video. RCA Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/hdmi/script.bin /boot/script.bin
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	
	# Audio setup
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc /home/pi/.asoundrc
	amixer -c 0 set "Audio lineout" unmute

elif [ $OPTION = "4" ]; then # Set: RCA Video. HDMI Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	cp -a files/rca/script.bin /boot/script.bin
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	echo "tv" >> /etc/modules
	
	# Audio setup
	cp -a files/hdmi/bgmusic.py /home/pi/RetroPie/music/bgmusic.py
	cp -a files/hdmi/retroarch.cfg /opt/retropie/configs/all/retroarch.cfg
	cp -a files/hdmi/asound.conf /etc/asound.conf
	cp -a files/hdmi/asoundrc /home/pi/.asoundrc
	
else
	echo "Tool Error"
	exit
fi

# Need Reboot Screen. Do It?
whiptail --title "BashTool_ROPI_RCA" --msgbox "Configuration applied" 10 55 5
if (whiptail --title "BashTool_ROPI_RCA" --yesno "It is necessary reboot the system. Reboot now?" 8 78) then
	# Yes
	reboot
else
	# No
	exit
fi
