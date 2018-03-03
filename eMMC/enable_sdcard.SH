#!/bin/bash
[ `whoami` = root ] || exec su -c $0 root
if (dialog --title "SD card as external storage"  --backtitle "Activate SD card" --yes-button "yes" --no-button "no"  --yesno "Please reinsert your sdcard now." 10 70) then
	echo "Activating SD card as external storage for roms."
	sleep 3
       	rm -rf /media/sdboot && mkdir /media/sdboot && mount /dev/mmcblk1p1 /media/sdboot >/dev/null 2>&1
	sed -i -e 's|root=/dev/mmcblk0p2|root=/dev/mmcblk1p2|g' /media/sdboot/boot-retro.cmd
	sed -i -e 's|disk=/dev/mmcblk0p2|disk=/dev/mmcblk1p2|g' /media/sdboot/boot.kodi.cmd
	sed -i '/ext4/d' /etc/fstab
	sed -i '/vfat/d' /etc/fstab
	sed -i -e '$i /dev/mmcblk1p2 / ext4 defaults,noatime,nodiratime,commit=600,errors=remount-ro 0 1' /etc/fstab
	sed -i -e '$i /dev/mmcblk0p1 /boot vfat defaults 0 2' /etc/fstab
	sed -i -e '$i /dev/mmcblk0p2 /home/pi/RetroPie/roms vfat umask=022,uid=pi,gid=pi 0 2' /etc/fstab
	mkimage -C none -A arm -T script -d /media/sdboot/boot-retro.cmd /media/sdboot/boot.scr >/dev/null 2>&1
	umount /media/sdboot
	dialog --title "SD card as external storage" --yes-button "ok" --no-button "exit"  --yesno "Your SD card was configured to act as RetroPie roms folder. Copy platforms (atari2600, nes, msx etc) to the root of the SD card and keep it inserted when booting." 10 70
        exit
    else
        exit
fi

