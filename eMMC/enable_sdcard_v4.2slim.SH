#!/bin/bash
[ `whoami` = root ] || exec su -c $0 root
if (dialog --title "SD card as external storage"  --backtitle "Activate SD card" --yes-button "yes" --no-button "no"  --yesno "Please reinsert your sdcard now." 10 70) then
	echo "Activating SD card as external storage for roms."
	sleep 3
       	rm -rf /media/sd && mkdir /media/sd && mount /dev/mmcblk1p1 /media/sd >/dev/null 2>&1
	sed -i -e 's|root=/dev/mmcblk0p1|root=/dev/mmcblk1p1|g' /media/sd/boot/boot-slim.cmd
	sed -i -e '$i /dev/mmcblk0p1 /media/sd ext4 defaults,noatime,nodiratime,commit=600,errors=remount-ro 0 1' /etc/fstab
	sed -i -e '$i /media/sd/home/pi/RetroPie /home/pi/RetroPie none defaults,bind 0 0' /etc/fstab
	mkimage -C none -A arm -T script -d /media/sd/boot/boot-slim.cmd /media/sd/boot/boot.scr >/dev/null 2>&1
	rm -rf /media/sd/{bin,dev,etc,lib,mnt,opt,proc,root,run,sbin,selinux,srv,sys,usr,var}
	umount /media/sd
	dialog --title "SD card as external storage" --yes-button "ok" --no-button "exit"  --yesno "Your SD card was configured to act as RetroPie roms folder. Copy platforms (atari2600, nes, msx etc) to the root of the SD card and keep it inserted when booting." 10 70
        exit
    else
        exit
fi

