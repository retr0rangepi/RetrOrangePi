#!/bin/bash
[ `whoami` = root ] || exec sudo -u root $0
FexChange() {
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
if (dialog --title "RetrOrangePi Overclock"  --backtitle "RetrOrangePi Configuration" --yes-button "yes" --no-button "no"  --yesno "Would you like to overclock your board?\n \n NOTE: OVERCLOCKING CAN SHORTEN THE LIFESPAN OF YOUR CPU\n AND CAUSE RANDOM INSTABILITY. " 10 70) then
        cd
        bin2fex /boot/script.bin /boot/overclock.fex
        FexChange "/boot/overclock.fex" "dvfs_table" "max_freq" "1536000000" # maximum overclock
        FexChange "/boot/overclock.fex" "dvfs_table" "LV1_freq" "1536000000" # maximum overclock
        FexChange "/boot/overclock.fex" "dvfs_table" "LV1_volt" "1500" # maximum overvolting
        cp -n /etc/default/cpufrequtils /etc/default/cpufrequtils.original
        sed -i '/MAX_SPEED/d' /etc/default/cpufrequtils
        sed -i -e '$i MAX_SPEED=1536000' /etc/default/cpufrequtils
        fex2bin /boot/overclock.fex /boot/bin/overclock.bin
        cp -n /boot/script.bin /boot/script.bin.original
        cp /boot/bin/overclock.bin /boot/script.bin
        dialog --title "RetrOrangePi Overclock" --backtitle "RetrOrangePi Configuration" --infobox "Overclock enabled!" 10 60
        exit
    else
        exit
fi

