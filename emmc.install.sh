#!/bin/bash
[ `whoami` = root ] 
EX_LIST="exclude.txt"
if (dialog --title "ROPi Install"  --backtitle "ROPi Install" --yes-button "yes" --no-button "no"  --yesno "Would you like to install RetrOrangePi to eMMC?" 10 70) then
	echo "Installing to eMMC."
	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Formatting eMMC .." 10 70
	sleep 3
	dd bs=1 seek=446 count=64 if=/dev/zero of=/dev/mmcblk1 >/dev/null 2>&1
	fdisk /dev/mmcblk1 <<EOF
o
n
p
1
2048
+513M
n
p
2

+301M
n
p
3


w
EOF
       	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Formatting rootfs... Please wait..." 10 70
	mkfs -t ext4 -F /dev/mmcblk1p3 >/dev/null 2>&1 && mkfs -t ext4 -F /dev/mmcblk1p2 >/dev/null 2>&1 && mkfs.msdos -F 32 /dev/mmcblk1p1 >/dev/null 2>&1
	mkdir /mnt/boot /mnt/rootfs /mnt/openelec && mount /dev/mmcblk1p1 /mnt/boot && mount /dev/mmcblk1p2 /mnt/openelec &&  mount /dev/mmcblk1p3 /mnt/rootfs >/dev/null 2>&1
	dialog --title "ROPi Install" --backtitle "ROPi Install"  --infobox "\n  Installing boot files... Please wait..." 10 70
	rsync -avrltD  --delete /boot/ /mnt/boot/ >/dev/null 2>&1
	cd  /usr/lib/linux* && dd if=u-boot-sunxi-with-spl.bin of=/dev/mmcblk1 bs=1024 seek=8 >/dev/null 2>&1
	cd /home/pi/RetroPie/retropiemenu
	mkimage -C none -A arm -T script -d /mnt/boot/boot-retro.cmd /mnt/boot/boot.scr >/dev/null 2>&1
	# count files is needed for progress bar (thanks armbian)
	dialog --title "$ROPi Install" --backtitle "ROPi Install" --infobox "\n  Counting files... Please wait a few seconds." 10 70
	TODO=$(rsync -ahvrltDn --delete --stats --exclude-from=$EX_LIST / /mnt/rootfs | grep "Number of files:"|awk '{print $4}' | tr -d '.,')

	# creating rootfs
	rsync -avrltD  --delete --exclude-from=$EX_LIST / /mnt/rootfs | nl | awk '{ printf "%.0f\n", 100*$1/"'"$TODO"'" }' \
	| dialog --backtitle "ROPi Install"  --title "ROPi Install" --gauge "\n\n  Creating rootfs on eMMC. Please wait! This may take a while." 10 70

	# run rsync again to silently catch outstanding changes between / and /mnt/rootfs/
	dialog --title "ROPi Install" --backtitle "ROPi Install" --infobox "\n  Cleaning up... Just a few more seconds." 10 70
	rsync -avrltD  --delete --exclude-from=$EX_LIST / /mnt/rootfs >/dev/null 2>&1
	rsync -avrltD  --delete /mnt/oe/ /mnt/openelec >/dev/null 2>&1
	umount /mnt/boot /mnt/rootfs /mnt/openelec
	rm -r /mnt/boot /mnt/boot /mnt/openelec
	dialog --title "ROPi Install" --yes-button "ok" --no-button "exit"  --yesno "eMMC install complete, please power off and remove sd card to boot from eMMC" 10 70
        exit
    else
        exit
fi
