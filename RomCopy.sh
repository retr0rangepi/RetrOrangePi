#!/bin/bash

# 2018.08.31
# small script to automate/simplify copying roms from an inserted usb drive to internal storage within emulationstation/retropie
# place RomCopy.sh in /home/pi/RetroPie/retropiemenu/ and set permissions - chmod +x RomCopy.sh
# restart emulationstation and you now see it as an option when opening the retropie menu
# it expects the usb drive to have the following folder/file layout
# usbdrive: roms-folder:-> nes,snes,megadrive,etc with rom files contained within those directories.
# format usb as fat32, and create your layout like i mentioned above, insert usb drive, and navigate/click on RomCopy.
# i hope this helps someone.
# outz/dereck

# 2018.09.01
# added the ability to backup current roms, bios scraped coverart, gamelist data to USB, as well as the ability to
# restore those backups all from the RomCopy menu system. This should alleviate some of the pain when installing new
# RetrOrange releases.
# outz/dereck

# 2018.09.08
# added functionality to auto create folders on the usb drive for all emulators that show up within the retropie folder
# outz/dereck

mainfunc() {
	menufunc
}

mountfunc() {
	/usr/bin/sudo /bin/umount /media > /dev/null 2>&1

	MOUNT=$(/usr/bin/sudo /bin/mount /dev/sda1 /media -o uid=pi,gid=pi> /dev/null 2>&1)
	MOUNTEC=$?

	if [ $MOUNTEC -eq 0 ]; then
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Successfully mounted the USB drive \n\n...Please wait" 5 40
		sleep 4
		return
	else
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Unable to mount USB drive \n\n...Exiting" 5 40
		sleep 4
		exit 1
	fi
}

umountfunc() {
	UMOUNT=$(/usr/bin/sudo /bin/umount /media > /dev/null 2>&1)
	UMOUNTEC=$?

	if [ $UMOUNTEC -eq 0 ]; then
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Successfully unmounted the USB drive \n\n...Please wait" 5 40
		sleep 4
		return
	else
		dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Unable to unmount USB drive \n\n...Exiting" 5 40
		sleep 4
		exit 1
	fi
}

menufunc() {
	rcbkup="/media/rcbackup"
	rcmcmd=(dialog --keep-tite --no-shadow --cr-wrap --keep-window --menu "RomCopy Menu System (Insert USB Drive Now)" 22 101 16)

	rcmoptions=(
	1 "Create rom folders on USB"
	2 "Copy roms from USB to internal"
	3 "Backup current roms to USB"
	4 "Restore rom backup from USB"
	253 "Help"
	254 "Reboot"
	255 "Exit"
	)

	rcmchoices=$("${rcmcmd[@]}" "${rcmoptions[@]}" 2>&1 >/dev/tty)

for rcmchoice in $rcmchoices
do
	case $rcmchoice in
                1)
                        mountfunc
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Creating rom folder structure\n\n...Please wait" 5 40
			sleep 4
			ARRROMDIR=($(/bin/ls -1 /home/pi/RetroPie/roms))
			/bin/mkdir -p /media/retropie/roms &>/dev/null
			/bin/mkdir /media/retropie/BIOS &>/dev/null
			for romdir in "${ARRROMDIR[@]}"
			do
				/bin/mkdir /media/retropie/roms/$romdir &>/dev/null
			done
			umountfunc
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Creation of rom folder structure is complete\n\nPlug the USB drive into your PC\n\nYou will see retropie/roms and retropie/BIOS\n\ncopy your roms and bios files to these locations and then reinsert and choose option 2" 10 80
			sleep 12
			mainfunc
			;;
		2)
			mountfunc
			if [ ! -d "/media/retropie/roms" ] && [ ! -d "/media/retropie/BIOS" ]; then
				umountfunc
                                dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: retropie/rom retropie/BIOS folders not fonund on USB drive\n\nRun option 1 first\n\n...Exiting" 10 80
                                sleep 8
                                mainfunc
			fi
			ARRROMSRC=(/media/retropie/roms/*/*)
			ROMDST="/home/pi/RetroPie/roms/"
			BIOSDST="/home/pi/RetroPie/BIOS/"
			dialog --keep-tite --no-shadow --cr-wrap --title "Rom copy" --gauge "Copying rom files..." 15 80 < <(
				nr=${#ARRROMSRC[*]};
				ir=0
				for fromsrc in "${ARRROMSRC[@]}"
				do
					fromdst=$(echo $fromsrc | sed s+media/retropie+home/pi/RetroPie+)
					PCTROM=$(( 100*(++ir)/nr ))
cat <<EOF
XXX
$PCTROM
Copying rom \
\n\nSRC: "$fromsrc" \
\n\nDST: "$fromdst"
XXX
EOF
					/bin/cp "$fromsrc" "$fromdst" &>/dev/null
				done
			)
			/bin/chown -R pi.pi $ROMDST
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Rom copy complete.\n\n...Please wait" 5 40
			sleep 4

                        ARRBIOSSRC=(/media/retropie/BIOS/*)
                        BIOSDST="/home/pi/RetroPie/BIOS/"
                        dialog --keep-tite --no-shadow --cr-wrap --title "BIOS copy" --gauge "Copying BIOS files..." 15 80 < <(
                                nb=${#ARRBIOSSRC[*]};
                                ib=0

                                for fbiossrc in "${ARRBIOSSRC[@]}"
                                do
                                        fbiosdst=$(echo $fbiossrc | sed s+media/retropie+home/pi/RetroPie+)
                                        PCTBIOS=$(( 100*(++ib)/nb ))
cat <<EOF
XXX
$PCTBIOS
Copying bios \
\n\nSRC: "$fbiossrc" \
\n\nDST: "$fbiosdst"
XXX
EOF
                                        /bin/cp -R "$fbiossrc" "$fbiosdst" &>/dev/null
                                done
                        )

                        /bin/chown -R pi.pi $BIOSDST
                        umountfunc
                        dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "BIOS copy complete.\n\n...Please wait" 5 40
                        sleep 4
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "It is recommended you reboot your device from the RomCopy menu\nfor the new roms to become available" 5 40
			sleep 8
			mainfunc
			;;
		3)
			mountfunc
			/bin/mkdir "$rcbkup" > /dev/null 2>&1
			dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Backing up data to USB\n\n...Please wait" 10 80
			echo "0" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/home/pi/RetroPie/roms\n\n...Please wait" 10 80 0
			cd /home/pi/RetroPie/
			/bin/tar cfz "$rcbkup"/roms.tar.gz ./roms
			echo "33" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/home/pi/RetroPie/BIOS\n\n...Please wait" 10 80 0
			cd /home/pi/RetroPie/
			/bin/tar cfz "$rcbkup"/bios.tar.gz ./BIOS
                        echo "75" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/opt/retropie/configs/all/emulationstation/downloaded)images\n\n...Please wait" 10 80 0
			cd /opt/retropie/configs/all/emulationstation/
			/bin/tar cfz "$rcbkup"/downloaded_images.tar.gz ./downloaded_images
			echo "99" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup in progress \n\n/opt/retropie/configs/all/emulationstation/gamelists\n\n...Please wait" 10 80 0
			cd /opt/retropie/configs/all/emulationstation/
			/bin/tar cfz "$rcbkup"/gamelists.tar.gz ./gamelists
			if [ -f "$rcbkup"/roms.tar.gz ] && [ -f "$rcbkup"/downloaded_images.tar.gz ] && [ -f "$rcbkup"/gamelists.tar.gz ] && [ -f "$rcbkup"/bios.tar.gz ]; then
				umountfunc
	            		echo "100" | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Backup roms to USB complete" 10 80 0
				sleep 4
				mainfunc
			else
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: Backup roms to USB failed" 10 80 0
				sleep 4
				mainfunc
			fi
			;;
		4)
			mountfunc
			if [ -f "$rcbkup"/roms.tar.gz ] && [ -f "$rcbkup"/downloaded_images.tar.gz ] && [ -f "$rcbkup"/gamelists.tar.gz ] && [ -f "$rcbkup"/bios.tar.gz ]; then
				(pv -n "$rcbkup"/roms.tar.gz | tar xzf - -C /home/pi/RetroPie/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/home/pi/RetroPie/roms\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/bios.tar.gz | tar xzf - -C /home/pi/RetroPie/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/home/pi/RetroPie/BIOS\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/downloaded_images.tar.gz | tar xzf - -C /opt/retropie/configs/all/emulationstation/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/opt/retropie/configs/all/emulationstation/downloaded)images\n\n...Please wait" 10 80 0
				(pv -n "$rcbkup"/gamelists.tar.gz | tar xzf - -C /opt/retropie/configs/all/emulationstation/ ) 2>&1 | dialog --keep-tite --no-shadow --cr-wrap --keep-window --gauge "Restore in progress \n\n/opt/retropie/configs/all/emulationstation/gamelists\n\n...Please wait" 10 80 0
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Restore of rom data successful\n\nReboot to complete\n\n...Exiting" 10 80
				sleep 4
				mainfunc
			else
				umountfunc
				dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "ERROR: Backup rom data does not exist on USB drive\n\n...Exiting" 10 80
				sleep 4
				mainfunc
			fi
			;;
                253)
                        dialog --keep-tite --no-shadow --cr-wrap --keep-window --infobox "Option 1 will create a folder structure on your USB drive in properation for you to populate the folders with roms/bios files\n\nOnce it completes, remove the USB drive and insert it into your PC\n\nCopy the roms/bios you wish to play in the correct retropie/rom retropie/BIOS folders\n\nOnce copied, insert the USB drive back into the RetroStone and select option 2\n\nThis option will seamlessly copy roms and bios files to your internal storage\n\nOptions 3 and 4 will backup your internal roms with saves, coverart etc. and allow you to restore them later" 10 80
			sleep 10
			mainfunc
			;;
		254)
			echo "...Rebooting"
			/usr/bin/sudo /sbin/reboot
			;;
		255)
			echo "...Exiting"
			exit 0
			;;
	esac
done

}

mainfunc
