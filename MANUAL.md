# RetrOrangePi 4.0 

## Installation instructions:
 
1. RetrOrangePi is not a single application. It's a full system that has to be copied to an SD card and inserted in a compatible board. Download the latest image from http://www.retrorangepi.org

2. Uncompress image:

    Linux: 7zr x imagename.img.7z
    Windows:  7-Zip  
=> Image size is ~5GB so a minimum 8GB sdcard is required for the full ROPi version. Its main partition is EXT4 (linux-only), so you won’t be able to open/access it from inside Windows, i.e., add roms, unless you install a 3rd party application like Paragon or Ext2SD. Connect a flash drive to your board and use Desktop option in the main launcher to be able to copy roms with ease.

3. Flash image to an SD card:
    Linux: sudo dd bs=4M if=imagename.img of=/dev/XXX (identify target with care by running ‘sudo fdisk –l’ to avoid data destruction)
    Windows: use Win32DiskImager or Etcher

4. Insert card into the board and power on

## Important information:

* In case your board does not seem to boot,  try to reformat your sd card with SDFormatter 4.0 by Trendy (with size adjustment on) or Linux GParted (delete all partitions and recreate one), try a different power supply (real 2A) and sdcard (original,  class10 recommended), and last but not least make sure to be connected to HDMI 720 compatible TV, no DVI adapters (default boot config)
* On first boot it will automatically install the system, resize sd card and reboot again, please be patient.
* If you still get a blank screen with ethernet and board lights, connect through SSH on port 22 and use Putty to change videomode. Default usernames and passwords are: user pi / password pi and superuser root / password orangepi . Run 'sudo h3disp' to test other resolutions.
* Emulators are already installed, but some will only appear in EmulationStation when roms are added (with a few exceptions).
* To add ROMs, copy files to /home/pi/RetroPie/roms/$CONSOLE folder, where $CONSOLE is the name of the target console, e.g. snes or arcade.  You can launch Desktop from EmulationStation and plug an USB drive with your ROMs. Roms folders are also samba shares. EmulationStation will search for specific extension for each platform. Please refer to supported platform page for correct extensions.
* If your emulator does not run some or any of your ROMS, check if the system requires *a BIOS* and that it is in the /home/pi/RetroPie/BIOS folder.  If it's a MAME/NeoGeo rom, take a look at this *thread*.

You can also check the output of the error, by running Runcommand Log from RetroPie section:

* [Download site] (http://www.retrorangepi.org/)
* [Forum] (http://orangepi.club/forumdisplay.php?fid=5)
* [Facebook page] (https://www.facebook.com/retrorangepi/)
* [Facebook group] (https://www.facebook.com/groups/1131759626884432/)

