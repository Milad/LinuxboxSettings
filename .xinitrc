#!/bin/bash

# To make PhpStorm to work under dwm.
export _JAVA_AWT_WM_NONREPARENTING=1

# Load Xresources settings
xrdb -load ~/Documents/Settings/.Xdefaults &

# Background
feh --bg-fill ~/Documents/Wallpapers/ --no-fehbg --randomize --recursive &

while true
do
    datetime=$(date +" %a %d %b  %R")
    disk=$(/usr/local/src/i3blocks/scripts/disk | sed -n 2p)
    memory=$(/usr/local/src/i3blocks/scripts/memory | sed -n 2p)
    load=$(/usr/local/src/i3blocks/scripts/load_average | sed -n 2p)

    dropbox_status=$(dropbox.py status)
    dropbox_icon=""
    if [ "$dropbox_status" != "Dropbox isn't running!" ]; then
        dropbox_icon=" "
    fi

    xsetroot -name "$dropbox_icon  $load  $memory  $disk $datetime"
    sleep 1
done &

while true
do
    slockauto.sh
    sleep 60
done &

exec dwm
