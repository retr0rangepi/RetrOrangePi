clear
killall -q mplayer
LD_LIBRARY_PATH=/usr/lib/GLSHIM mplayer -really-quiet -cache 1024 "http://gyusyabu.ddo.jp:8000/;stream.mp3" &


