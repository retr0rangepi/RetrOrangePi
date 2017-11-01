#!/bin/bash
rm /home/pi/RetrOrangePi/Background_Music/DisableMusic 2> /dev/null
sudo sed --quiet -i -e 's/#Python/python/g' /etc/init.d/asplashscreen
sudo sed --quiet -i -e 's/#Python/python/g' /opt/retropie/supplementary/splashscreen/asplashscreen.sh
python /home/pi/RetrOrangePi/Background_Music/bgmusic.py &

