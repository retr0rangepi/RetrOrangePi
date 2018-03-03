#!/bin/bash
[ `whoami` = root ] || exec su -c $0 root
if (dialog --title "Disabling SD card as external storage"  --backtitle "Disable SD card" --yes-button "yes" --no-button "no"  --yesno "Press yes to disable SD card." 10 70) then
	echo "Disabling SD card as external storage for roms."
	sleep 3
	sed -i '/ext4/d' /etc/fstab
	sed -i '/vfat/d' /etc/fstab
	sed -i -e '$i /dev/mmcblk0p2 / ext4 defaults,noatime,nodiratime,commit=600,errors=remount-ro 0 1' /etc/fstab
	sed -i -e '$i /dev/mmcblk0p1 /boot vfat defaults 0 2' /etc/fstab
	dialog --title "Disabling SD card as external storage" --yes-button "ok" --no-button "exit"  --yesno "Your SD card was disabled as RetroPie roms folder. Remove it after shutting down the board." 10 70
        exit
    else
        exit
fi

