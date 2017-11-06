#!/bin/bash
rm /home/pi/RetrOrangePi/Background_Music/DisableMusic 2> /dev/null
sudo sed -i -e 's/nohtyp/python/g' /etc/init.d/asplashscreen 2> /dev/null
sudo sed -i -e 's/nohtyp/python/g' /opt/retropie/supplementary/splashscreen/asplashscreen.sh 2> /dev/null
python /home/pi/RetrOrangePi/Background_Music/bgmusic.py &


