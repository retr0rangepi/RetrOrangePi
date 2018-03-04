sudo cp ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/shutdown /etc/acpi/events/button_power
mv ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Shutdown.sh ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Shutdown_enabled.sh 2>/dev/null
mv ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Reboot_enabled.sh ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Reboot.sh 2>/dev/null
mv ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Suspend_enabled.sh ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Suspend.sh 2>/dev/null
mv ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Restart_enabled.sh ~/RetroPie/retropiemenu/RetrOrangePi/Power_Button/Restart.sh 2>/dev/null
sudo service acpid restart


sudo killall login
