#!/bin/bash
# Nombre: main.sh
# Description: Main Script
#############################

# Global Parameters
set -e # No errors allowed

#############################

## Usage: FexChange <fexfile> <section> <key> <value> 
## Description: Changes the value of a given key (or adds key=value) to a specific section of FEX file
FexChange()
{
	# Search in file ($1) in section ($2) for key ($3)
	found=$(sed -n -e "/^\[$2\]/,/^\[/{/^$3\s*=/p}" "$1")
  
	if [ -n "$found" ]; then
		# Replace in file ($1) in section ($2) key ($3) with value ($4)
		sed -i -e "/^\[$2\]/,/^\[/{s/^\($3\s*=\s*\).*/\1$4/}" "$1"
	else
		# Append in file ($1) in section ($2) key ($3) with value ($4)
		sed -i -e "/^\[$2\]/,/^\[/{/^\[/i$3 = $4\n" -e "}" "$1"
	fi
}

## Usage: RetrocfgChange <file_path> <key> <value> 
## Description: Changes the value of a given key (or adds key=value) of retroarch.cfg file
RetrocfgChange()
{
	# Search in file ($1) for key ($2)
	found=$(sed -n -e "/^$2\s*=/p" "$1")
  
	if [ -n "$found" ]; then
		# Replace in file ($1) key ($2) with value ($3)
		sed -i -e "s/^\($2\s*=\s*\).*/\1$3/" "$1"
	else
		# Append in file ($1) key ($2) with value ($3)
		sed -i -e "\$a$2 = $3" "$1"
	fi
}

#############################

# Menu Screen. Select option
OPTION=$(whiptail --title "BashTool_ROPI_RCA" --menu "Choose an option" 15 60 0 --cancel-button Exit --ok-button Select \
	"1" "HDMI Video & Audio. RCA Disabled" \
	"2" "RCA Video (PAL) & Audio. HDMI Disabled" \
	"3" "RCA Video (NTSC) & Audio. HDMI Disabled" \
	"4" "HDMI Video. RCA Audio" \
	3>&1 1>&2 2>&3)

# Manage Option Selected. Configure System Video & Audio Output
if [ $OPTION = "1" ]; then # Set: HDMI Video & Audio
	echo "Configuring, please wait..."
	sleep 2
	
	######## Video setup
	
	# Script.bin modification
	bin2fex /boot/script.bin /boot/script.fex
	FexChange "/boot/script.fex" "disp_init" "disp_mode" "0" # Use Screen0 configs
	FexChange "/boot/script.fex" "disp_init" "screen0_output_type" "3" # HDMI
	FexChange "/boot/script.fex" "disp_init" "screen0_output_mode" "5" # 720p
	FexChange "/boot/script.fex" "hdmi_para" "hdmi_used" "1" # Turn on HDMI
	FexChange "/boot/script.fex" "tv_para" "tv_used" "0" # Turn off RCA
	FexChange "/boot/script.fex" "audiohub" "hub_used" "0" # Disable Audio HUB
	FexChange "/boot/script.fex" "audiohub" "spdif_used" "0" # Disable SPDIF
	fex2bin /boot/script.fex /boot/script.bin
	
	# TV module load
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	
	######## Audio setup
	RetrocfgChange '/opt/retropie/configs/all/retroarch.cfg' 'audio_device' '""'
	cp -a files/hdmi/bgmusic.py /home/pi/RetroPie/music/bgmusic.py
	cp -a files/hdmi/asound.conf /etc/asound.conf
	cp -a files/hdmi/asoundrc /home/pi/.asoundrc
	
elif [ $OPTION = "2" ]; then # Set: RCA Video (PAL) & Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	
	# Script.bin modification
	bin2fex /boot/script.bin /boot/script.fex
	FexChange "/boot/script.fex" "disp_init" "disp_mode" "1" # Use Screen1 configs
	FexChange "/boot/script.fex" "disp_init" "screen1_output_type" "2" # TV
	FexChange "/boot/script.fex" "disp_init" "screen1_output_mode" "11" # PAL
	FexChange "/boot/script.fex" "hdmi_para" "hdmi_used" "0" # Turn off HDMI
	FexChange "/boot/script.fex" "tv_para" "tv_used" "1" # Turn on RCA
	FexChange "/boot/script.fex" "audiohub" "hub_used" "1" # Enable Audio HUB
	FexChange "/boot/script.fex" "audiohub" "spdif_used" "0" # Disable SPDIF
	fex2bin /boot/script.fex /boot/script.bin

	# TV module unload
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	echo "tv" >> /etc/modules
	
	# Audio setup
	RetrocfgChange '/opt/retropie/configs/all/retroarch.cfg' 'audio_device' '"hw:0,0"'
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc /home/pi/.asoundrc
	amixer -c 0 set "Audio lineout" unmute

elif [ $OPTION = "3" ]; then # Set: RCA Video (NTSC) & Audio
	echo "Configuring, please wait..."
	sleep 2
	
	# Video setup
	
	# Script.bin modification
	bin2fex /boot/script.bin /boot/script.fex
	FexChange "/boot/script.fex" "disp_init" "disp_mode" "1" # Use Screen1 configs
	FexChange "/boot/script.fex" "disp_init" "screen1_output_type" "2" # TV
	FexChange "/boot/script.fex" "disp_init" "screen1_output_mode" "14" # NTSC
	FexChange "/boot/script.fex" "hdmi_para" "hdmi_used" "0" # Turn off HDMI
	FexChange "/boot/script.fex" "tv_para" "tv_used" "1" # Turn on RCA
	FexChange "/boot/script.fex" "audiohub" "hub_used" "1" # Enable Audio HUB
	FexChange "/boot/script.fex" "audiohub" "spdif_used" "0" # Disable SPDIF
	fex2bin /boot/script.fex /boot/script.bin

	# TV module unload
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	echo "tv" >> /etc/modules
	
	# Audio setup
	RetrocfgChange '/opt/retropie/configs/all/retroarch.cfg' 'audio_device' '"hw:0,0"'
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc /home/pi/.asoundrc
	amixer -c 0 set "Audio lineout" unmute

elif [ $OPTION = "4" ]; then # Set: HDMI Video. RCA Audio
	echo "Configuring, please wait..."
	sleep 2
	
	######## Video setup

	# Script.bin modification
	bin2fex /boot/script.bin /boot/script.fex
	FexChange "/boot/script.fex" "disp_init" "disp_mode" "0" # Use Screen0 configs
	FexChange "/boot/script.fex" "disp_init" "screen0_output_type" "3" # HDMI
	FexChange "/boot/script.fex" "disp_init" "screen0_output_mode" "5" # 720p
	FexChange "/boot/script.fex" "hdmi_para" "hdmi_used" "1" # Turn on HDMI
	FexChange "/boot/script.fex" "tv_para" "tv_used" "0" # Turn off RCA
	FexChange "/boot/script.fex" "audiohub" "hub_used" "1" # Enable Audio HUB
	FexChange "/boot/script.fex" "audiohub" "spdif_used" "0" # Disable SPDIF
	fex2bin /boot/script.fex /boot/script.bin

	# TV module unload
	sed -i '/tv/d' /etc/modules # Delete "tv" line
	sed -i '/^ *$/d' /etc/modules # Delete empty lines
	
	######## Audio setup
	RetrocfgChange '/opt/retropie/configs/all/retroarch.cfg' 'audio_device' '"hw:0,0"'
	cp -a /home/pi/RetroPie/music/bgmusic.py /home/pi/RetroPie/music/bgmusic_disable.py
	rm -rf /home/pi/RetroPie/music/bgmusic.py
	cp -a files/rca/asound.conf /etc/asound.conf
	cp -a files/rca/asoundrc /home/pi/.asoundrc
	amixer -c 0 set "Audio lineout" unmute

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
