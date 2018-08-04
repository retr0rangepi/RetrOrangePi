#!/bin/bash
mkdir ~/temp
wget -O ~/temp/hotfix_v4.2.sh http://www.retrorangepi.org/hotfix_v4.2.sh
chmod +x ~/temp/hotfix_v4.2.sh
~/temp/hotfix_v4.2.sh
sudo killall login

