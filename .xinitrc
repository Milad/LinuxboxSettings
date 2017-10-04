#!/bin/bash

# To make PhpStorm to work under dwm.
export _JAVA_AWT_WM_NONREPARENTING=1

calendar_icon=$(echo -e "\xEF\x81\xB3")
time_icon=$(echo -e "\xEF\x80\x97")
disk_icon=$(echo -e "\xEF\x82\xA0")
memory_icon=$(echo -e "\xEF\x8B\x9B")
load_icon=$(echo -e "\xEF\x87\xBE")
battery_icon=$(echo -e "\xEF\x89\x80")
keyboard_icon=$(echo -e "\xEF\x84\x9C")
vol_muted_icon=$(echo -e "\xEF\x80\xA6")
vol_full_icon=$(echo -e "\xEF\x80\xA8")
network_icon=$(echo -e "\xEF\x83\xA8")
dropbox_icon=$(echo -e "\xEF\x85\xAB")

# Load Xresources settings
xrdb -load ~/Documents/Settings/.Xdefaults &

# Background
feh --bg-fill ~/Documents/Wallpapers/ --no-fehbg --randomize --recursive &

while true
do
    status=""

    datetime=$(date +"$calendar_icon %a %d %b $time_icon %R")

    status="$datetime"

    disk=$(/usr/local/src/i3blocks/scripts/disk | sed -n 2p)

    status="$disk_icon $disk  $status"

    memory=$(/usr/local/src/i3blocks/scripts/memory | sed -n 2p)

    status="$memory_icon $memory  $status"

    load=$(/usr/local/src/i3blocks/scripts/load_average | sed -n 2p)

    status="$load_icon $load  $status"

    battery=$(/usr/local/src/i3blocks/scripts/battery | sed -n 2p)

    status="$battery_icon $battery  $status"

    kb_layout=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}' | sed 's/.*/\U&/')

    status="$keyboard_icon $kb_layout  $status"

    volume=$(/usr/local/src/i3blocks/scripts/volume)
    if [ "$volume" == "MUTE" ]; then
        status="$vol_muted_icon $volume  $status"
    else
        status="$vol_full_icon $volume  $status"
    fi

    iface=$(/usr/local/src/i3blocks/scripts/iface | sed -n 2p)

    status="$network_icon $iface  $status"

    path_to_dropbox=$(which dropbox.py)
    if [ -x "$path_to_dropbox" ]; then
        dropbox_status=$(dropbox.py status)
        if [ "$dropbox_status" != "Dropbox isn't running!" ]; then
            status=" $dropbox_icon  $status"
        fi
    fi

    xsetroot -name " $status"
    sleep 1
done &

while true
do
    slockauto.sh
    sleep 60
done &

exec dwm
