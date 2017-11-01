#!/bin/bash
sudo pkill -f bgmusic.py
touch /home/pi/RetrOrangePi/Background_Music/DisableMusic
sudo sed --quiet -i -e 's/python/#Python/g' /etc/init.d/asplashscreen
sudo sed --quiet -i -e 's/python/#Python/g' /opt/retropie/supplementary/splashscreen/asplashscreen.sh

