sudo sh -c "echo 0 > /sys/class/graphics/fb0/blank"
#sudo sh -c "echo 255 > /sys/class/leds/red_led/brightness"
#sudo sh -c "echo 0 > /sys/class/leds/green_led/brightness"
sudo sh -c "echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
sudo sh -c "echo interactive > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
sudo sh -c "echo interactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
sudo sh -c "echo interactive > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
python /home/pi/RetrOrangePi/Background_Music/bgmusic.py &


