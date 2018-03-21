#!/bin/bash
[ `whoami` = root ] || exec sudo -u root $0
if (dialog --title "RetrOrangePi Overclock"  --backtitle "RetrOrangePi Configuration" --yes-button "yes" --no-button "no"  --yesno "Press YES to disable overclocking state." 10 70) then
        cd
        mv /etc/default/cpufrequtils.original /etc/default/cpufrequtils
        mv /boot/script.bin.original /boot/script.bin
        dialog --title "RetrOrangePi Overclock" --backtitle "RetrOrangePi Configuration" --infobox "Overclock disabled!" 10 70
        exit
    else
        exit
fi

