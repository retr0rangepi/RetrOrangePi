#!/bin/bash
clear

TERM=linux toilet -f standard -F metal "RetrOrangePi 4.0" 

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
echo "*    Updating EmulationStation with kiosk/kid mode suport       *"
echo "*                                                               *"
echo "*****************************************************************"
sleep 5
echo "Please wait..."
sudo killall emulationstation
sleep 5
sudo cp /opt/retropie/supplementary/emulationstation/emulationstation /opt/retropie/supplementary/emulationstation/emulationstation.old
sudo wget -q -O /opt/retropie/supplementary/emulationstation/emulationstation http://www.retrorangepi.org/emulationstation.kiosk
echo "Restarting EmulationStation..."
sleep 5
sudo killall login
