# RetrOrangePi 4.0 

RetrOrangePi is a non profit gaming and media center distribution compatible with boards equipped with CPU H3 and GPU Mali 400 (most Orange Pis, Banana Pi M2+, Beelink X2 and NanoPi M1). It is based on Armbian (Linux Debian 8) and RetroPie. RetrOrangePi is a gaming and media center distribution based on Armbian (Linux Debian 8), compatible with most Orange Pi boards , equipped with CPU H3 and GPU Mali 400. You'll be able to play your favorite games from the 70's, 80's and 90s, have a full desktop experience with thousands of apps from Debian repositories like Firefox, LibreOffice, GIMP, Transmission, and also OpenELEC/Kodi media center (former XBMC), where you can watch HD movies and install hundreds of addons. 

Until we get working GPU drivers, there will be no support for new boards like Orange Pi PC2, Orange Pi Win, Orange Pi Prime or any other with Mali 450 GPU or A64/H5 CPU.

Some of the software included in the image have non-commercial licenses. Because of this, selling a pre-installed RetrOrangePi image is not legal, neither including it with your commercial product is. As it relies on other people’s work with our own features, we won't be offering any help in customizations to avoid rebranding or reselling.

Compatibility: most games should run fine on ANY board up to the Sony Playstation. Things get hit and miss on Dreamcast, MAME, N64 and PSP. Games like Super Mario 64, Mario Kart, Zelda OOT (N64), Ultimate Ghosts n Goblins, LittleBigPlanet, GTA Vice City (PSP), Crazy Taxi, Sonic Adventure and Shenmue (Dreamcast) are some examples of games that run fine with a few minor issues. Conker (N64), God of War (PSP), Sega Saturn and 3DO games are not playable.
Nintendo DS best emulator out there is closed source and was only ported to Raspberry Pi. Its developer (Exophase) was already contacted regarding a port for SDL/EGL without RPI dependencies.

## Multiboot environment

ROPi 4.0 will firstly boot to EmulationStation; map your controller. You can open the Armbian Desktop, where you can switch to your preferred boot-type (EmulationStation, AdvanceMENU, Retroarch, Kodi or Desktop)

### EmulationStation

The classic RetroPie frontend, features background music and custom ROPi theme and menu options (inside Retropie section).

### Retroarch

Libretro's own frontend/emulator, Retroarch is the heart of the emulation component. This option will get you a similar build of Lakka.

### Kodi

Boots to our Kodi Krypton 17.4 build, with hardware acceleration powered by MPV player. IPTVSimple is included; enable it from the addons menu.

### Desktop

Classic Armbian Desktop version, with several pre-installed applications.

### AdvanceMENU

MAME versatile frontend, supports picture and video snapshots. Reads roms from mame-advmame folder. Full integration with RetroPie platforms is possible and will be added soon.



Download site: http://www.retrorangepi.org/
Forum: http://orangepi.club/forumdisplay.php?fid=5
Facebook page: https://www.facebook.com/retrorangepi/
Facebook group: https://www.facebook.com/groups/1131759626884432/

