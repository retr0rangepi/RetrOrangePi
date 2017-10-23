sudo pkill -f bgmusic.py
touch /home/pi/RetrOrangePi/Background_Music/DisableMusic
sudo sed -i -e 's/python/#Python/g' /opt/retropie/supplementary/splashscreen/asplashscreen.sh

