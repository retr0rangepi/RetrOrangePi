#!/bin/bash
if (dialog --title "Deactivate Swap memory"  --backtitle "RetrOrangePi Swap Memory script" --yes-button "yes" --no-button "no"  --yesno "\nThis script will remove the swapfile. Do you want to proceed?" 10 70) then
	echo "Removing swap memory..."
	sleep 3
	sudo sed -i '/^ *$/d' /etc/rc.local # Delete empty lines from rc.local
	sudo sed -i '/swap/d' /etc/fstab # Delete previous swap entries from fstab
	sudo sed -i '/swap/d' /etc/rc.local # Delete previous swap entries from rc.local
	sudo swapoff /swapfile # deactivate swap memory
	sudo rm -rf /swapfile # remove the swapfile
	dialog --title "Swap memory removed." --yes-button "ok" --yesno "\nPlease click OK to quit the script." 10 70
    else
        exit
fi
