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
LD_LIBRARY_PATH=/usr/local/lib /opt/retropie/supplementary/emulationstation/emulationstation.sh;stty echo
