#!/bin/bash
pushd /home/pi/RetrOrangePi/eMMC
sudo ./emmc.installv4.SH
sudo ./enable_emmc_sdcard.SH
sudo mkdir /mnt/boot 
sudo mount /dev/mmcblk1p1 /mnt/boot
sudo sed -i -e 's/mmc 0/mmc 1/g' /mnt/boot/boot-retro.cmd
sudo sed -i -e 's/mmc 0/mmc 1/g' /mnt/boot/boot.kodi.cmd
sudo mkimage -C none -A arm -T script -d /mnt/boot/boot-retro.cmd /mnt/boot/boot.scr >/dev/null 2>&1
sudo umount /mnt/boot
sudo rm -r /mnt/boot
popd

