#!/bin/bash

# To make PhpStorm to work under dwm.
export _JAVA_AWT_WM_NONREPARENTING=1

calendar_icon=$(echo -e "\xEF\x81\xB3")
time_icon=$(echo -e "\xEF\x80\x97")
disk_icon=$(echo -e "\xEF\x87\x80")
memory_icon=$(echo -e "\xEF\x8B\x9B")
load_icon=$(echo -e "\xEF\x87\xBE")
dropbox_icon=$(echo -e "\xEF\x85\xAB")

# Load Xresources settings
xrdb -load ~/Documents/Settings/.Xdefaults &

# Background
feh --bg-fill ~/Documents/Wallpapers/ --no-fehbg --randomize --recursive &

while true
do
    datetime=$(date +"$calendar_icon %a %d %b $time_icon %R")

    disk=$(/usr/local/src/i3blocks/scripts/disk | sed -n 2p)
    memory=$(/usr/local/src/i3blocks/scripts/memory | sed -n 2p)
    load=$(/usr/local/src/i3blocks/scripts/load_average | sed -n 2p)

    dropbox_status=$(dropbox.py status)
    db_icon=""
    if [ "$dropbox_status" != "Dropbox isn't running!" ]; then
        db_icon=" $dropbox_icon"
    fi

    xsetroot -name "$db_icon $load_icon $load $memory_icon $memory $disk_icon $disk $datetime"
    sleep 1
done &

while true
do
    slockauto.sh
    sleep 60
done &

exec dwm
