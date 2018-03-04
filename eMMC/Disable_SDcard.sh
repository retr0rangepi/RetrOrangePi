#!/bin/bash
set -e #quit on any error
egrep -R mmcblk1p2 /boot/boot-retro.cmd
pushd ~/RetrOrangePi/eMMC/
sudo ./disable_sdcard.SH
