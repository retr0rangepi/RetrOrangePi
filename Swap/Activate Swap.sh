#!/bin/bash
if (dialog --title "Activate Swap memory"  --backtitle "RetrOrangePi Swap Memory script" --yes-button "yes" --no-button "no"  --yesno "\nA 512MB swapfile will be created on the root folder and will be enabled by default. Do you want to proceed?" 10 70) then
	echo "Creating swap memory... this will only take a minute."
	sleep 3
	pushd ~/RetrOrangePi/Swap
	./makeswap
	sudo sed -i '/^ *$/d' /etc/rc.local # Delete empty lines from rc.local
	sudo sed -i '/swap/d' /etc/fstab # Delete previous swap entries from fstab
	sudo sed -i '/swap/d' /etc/rc.local # Delete previous swap entries from rc.local
	sudo sed -i -e '$i \sudo swapon /swapfile\n' /etc/rc.local #enable swap on rc.local
	dialog --title "Swap memory created." --yes-button "ok" --yesno "\nPlease click OK to reboot the system." 10 70
        sudo reboot
    else
        exit
fi
