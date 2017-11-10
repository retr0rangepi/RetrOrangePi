#!/bin/sh

#module GPIO for RetrOrangepi
#Author: Erick Tarzia - http://tzgamessp.com.br
#EMAIL: ericktarzia@gmail.com

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`
fundo=`tput setab 7`

echo "${green} ${fundo} ## RetrOrangePi GPIO installer brought you by TZ GAMES SP ## ${reset}"
echo "${yellow}Updating APT-GET${reset}"
#sudo apt-get update

echo "${yellow}Installing python-dev python-pip gcc...${reset}"
sudo apt-get install python-dev python-pip gcc

#echo "${yellow}Installing linux-headers...${reset}"
#sudo apt-get install linux-headers-$(uname -r)

echo "${yellow}Installing evdev...${reset}"
sudo pip install evdev

echo "${yellow}Installing uinput...${reset}"
sudo pip install python-uinput

#echo "${yellow}Installing GPIO for RetrOrangePi...${reset}"
#sudo python /home/pi/RetrOrangePi/GPIO/orangepi_PC_gpio_pyH3-master/setup.py install

if [ -f /lib/systemd/system/tz_gpio.service ]; then
	echo "${green} SERVICE Found ${reset}" 
else
	echo "${yellow} SERVICE Not Found ${reset}"
	echo "${green} copying files... ${reset}"
	echo "${yellow} SERVICE FOUND ${reset}"

	sudo cp -avr ~/RetrOrangePi/GPIO/tz_gpio.service /lib/systemd/system
	sudo chmod 644 /lib/systemd/system/tz_gpio.service
	sudo systemctl enable tz_gpio.service
fi

echo "${yellow}Installing GPIO for RetrOrangePi...${reset}"
sudo python /home/pi/RetrOrangePi/GPIO/orangepi_PC_gpio_pyH3-master/setup.py install

#check uinput
File=/etc/modules
if grep -q "uinput" "$File"; then
	echo "${green} uinput OK ${reset}"
else
	echo "${red} ${fundo} ADD the line uinput in the /etc/modules ${reset}"
fi

if grep -q "#uinput" "$File"; then
	echo "${red} ${fundo} UNCOMMENT the line uinput in the /etc/modules ${reset}"
fi

echo "${green} ALL OK, reboot and enjoy ${reset}"
