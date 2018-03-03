#!/bin/bash
[ `whoami` = root ] || exec su -c $0 root
EX_LIST="/home/pi/RetrOrangePi/eMMC/exclude.txt"
if (dialog --title "ROPi Install"  --backtitle "ROPi Install" --yes-button "yes" --no-button "no"  --yesno "Would you like to install RetrOrangePi v4.1 to eMMC?" 10 70) then
	echo "Installing to eMMC."
	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Formatting eMMC..." 10 70
	sleep 3
	fdisk /dev/mmcblk1 <<EOF
o
n
p
1
8192
+512M
t
e
n
p
2
8192


w
EOF
        cd  /usr/lib/linux* && dd if=u-boot-sunxi-with-spl.bin of=/dev/mmcblk1 bs=1024 seek=8 >/dev/null 2>&1
        cd /home/pi/RetrOrangePi/eMMC
       	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Formatting rootfs. Please wait..." 10 70
	dd if=/dev/mmcblk0p1 of=/dev/mmcblk1p1
	mkfs -t ext4 -F /dev/mmcblk1p2 >/dev/null 2>&1
	mkdir /mnt/rootfs && mount /dev/mmcblk1p2 /mnt/rootfs >/dev/null 2>&1
	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Installing boot files. Please wait..." 10 70
	# count files is needed for progress bar (thanks armbian)
	dialog --title "$ROPi Install" --backtitle "ROPi Install" --infobox "\n  Counting files, few seconds..." 10 70
	TODO=$(rsync -ahvrltDn --delete --stats --exclude-from=$EX_LIST / /mnt/rootfs | grep "Number of files:"|awk '{print $4}' | tr -d '.,')

	# creating rootfs
	rsync -avrltD  --delete --exclude-from=$EX_LIST / /mnt/rootfs | nl | awk '{ printf "%.0f\n", 100*$1/"'"$TODO"'" }' \
	| dialog --backtitle "ROPi Install"  --title "ROPi Install" --gauge "\n\n  Creating rootfs on eMMC. This should take ~40min to complete." 10 70

	# run rsync again to silently catch outstanding changes between / and /mnt/rootfs/
	dialog --title "ROPi Install" --backtitle "ROPi Install" --infobox "\n  Cleaning up ... few seconds." 10 70
	rsync -avrltD  --delete --exclude-from=$EX_LIST / /mnt/rootfs >/dev/null 2>&1
        sed -i '/ext4/d' /mnt/rootfs/etc/fstab
        sed -i -e '$i /dev/mmcblk0p2 / ext4 defaults,noatime,nodiratime,commit=600,errors=remount-ro 0 1' /mnt/rootfs/etc/fstab
        sed -i '/vfat/d' /mnt/rootfs/etc/fstab
        sed -i -e '$i /dev/mmcblk0p1 /boot vfat defaults 0 2' /mnt/rootfs/etc/fstab
	umount /mnt/rootfs
	rm -r /mnt/rootfs
	dialog --title "ROPi Install" --yes-button "ok" --no-button "exit"  --yesno "Press OK to set default boot to eMMC. Then, shutdown the system, unplug power supply and USB hubs, remove SD card and power it on again to boot from eMMC." 10 70
        exit
    else
        exit
fi

