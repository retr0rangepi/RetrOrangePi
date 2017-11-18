#!/bin/bash

cmd=(dialog --keep-tite --menu "Select the driver:" 22 76 16)

options=(1 "TZ GAMES SP"
         2 "NES"
)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

for choice in $choices
do
    case $choice in
        1)
            source ./install_tz_gpio.sh
            ;;
        2)
            source ./install_nes.sh
            ;;
    esac
done
