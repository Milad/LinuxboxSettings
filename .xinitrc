#!/bin/bash

# To make PhpStorm to work under dwm.
export _JAVA_AWT_WM_NONREPARENTING=1

calendar_icon=$(echo -e "\xEF\x81\xB3")
time_icon=$(echo -e "\xEF\x80\x97")
disk_icon=$(echo -e "\xEF\x82\xA0")
memory_icon=$(echo -e "\xEF\x8B\x9B")
load_icon=$(echo -e "\xEF\x87\xBE")
dropbox_icon=$(echo -e "\xEF\x85\xAB")
keyboard_icon=$(echo -e "\xEF\x84\x9C")
vol_muted_icon=$(echo -e "\xEF\x80\xA6")
vol_full_icon=$(echo -e "\xEF\x80\xA8")

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

    dp_icon=""
    path_to_dropbox=$(which dropbox.py)
    if [ -x "$path_to_dropbox" ]; then
        dropbox_status=$(dropbox.py status)
        if [ "$dropbox_status" != "Dropbox isn't running!" ]; then
            dp_icon=" $dropbox_icon"
        fi
    fi

    kb_layout=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}' | sed 's/.*/\U&/')

    volume=$(/usr/local/src/i3blocks/scripts/volume)
    if [ "$volume" == "MUTE" ]; then
        vol_icon="$vol_muted_icon"
    else
        vol_icon="$vol_full_icon $volume"
    fi

    xsetroot -name "$dp_icon $vol_icon $keyboard_icon $kb_layout $load_icon $load $memory_icon $memory $disk_icon $disk $datetime"
    sleep 1
done &

while true
do
    slockauto.sh
    sleep 60
done &

exec dwm
