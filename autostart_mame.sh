#!/bin/sh
stty -echo
SERVICE='fbi'
      if ps ax | grep $SERVICE > /dev/null
  then
      sudo killall -q $SERVICE
      fi
while pgrep mpv &>/dev/null;
do sleep 1;
done
/usr/local/bin/advmenu;startx 2>&1 >/dev/tty;/opt/retropie/supplementary/emulationstation/emulationstation.sh;stty echo

