#!/bin/bash
killall emulationstation
sleep 3
clear
TERM=linux toilet -f standard -F metal "RetrOrangePi 4.1"

#    RetrOrangePi BashWelcomeTweak

echo -e "       \033[0;32m█              █\033[0m     "
echo -e "  \033[0;33m█\033[0m     \033[0;32m█            █\033[0m     \033[0;33m█"
echo -e "\033[0;33m  █  ████████████████████  █"
echo -e "\033[0;33m  ███████\033[1;37m██\033[0;33m████████\033[1;37m██\033[0;33m███████"
echo -e "\033[0;33m  ██████████████████████████"
echo -e "\033[0;33m    ██████████████████████ "
echo -e "\033[0;33m     ████████████████████  "
echo -e "\033[0;33m        █             █   "
echo -e "\033[0;33m       █               █  "
echo ""
echo ""
echo "*****************************************************************"
echo "*                                                               *"
echo "*                 Installing English translation                *"
echo "*                                                               *"
echo "*****************************************************************"
sleep 3
mkdir /home/pi/temp
cp -v /opt/retropie/supplementary/emulationstation/emulationstation /home/pi/temp/es_original
sudo wget -O /opt/retropie/supplementary/emulationstation/emulationstation http://www.retrorangepi.org/es_english
sed -i '/GamelistViewStyle/d' /opt/retropie/configs/all/emulationstation/es_settings.cfg
sed -i -e '$i <string name="GamelistViewStyle" value="detailed" />\n' /opt/retropie/configs/all/emulationstation/es_settings.cfg
sed -i '/language/d' /opt/retropie/configs/all/retroarch.cfg
sed -i -e '$i user_language = "0"\n' /opt/retropie/configs/all/retroarch.cfg
sudo killall login

