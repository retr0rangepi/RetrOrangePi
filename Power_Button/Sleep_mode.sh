sudo cp ~/RetrOrangePi/Power_Button/turnon /etc/acpi/events/button_power
sudo sh -c "echo 4 > /sys/class/graphics/fb0/blank"
#sudo sh -c "echo 255 > /sys/class/leds/red_led/brightness"
#sudo sh -c "echo 0 > /sys/class/leds/green_led/brightness"
sudo sh -c "echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
sudo sh -c "echo powersave > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
sudo sh -c "echo powersave > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
sudo sh -c "echo powersave > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
sudo pkill -f bgmusic.py
sudo killall -q mplayer
sudo service acpid restart

