#!/bin/bash
sudo pkill -f bgmusic.py
touch /home/pi/RetrOrangePi/Background_Music/DisableMusic
sudo sed -i -e 's/python/nohtyp/g' /etc/init.d/asplashscreen 2> /dev/null
sudo sed -i -e 's/python/nohtyp/g' /opt/retropie/supplementary/splashscreen/asplashscreen.sh 2> /dev/null

