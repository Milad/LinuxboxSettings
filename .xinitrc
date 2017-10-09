#!/bin/bash

# To make PhpStorm to work under dwm.
export _JAVA_AWT_WM_NONREPARENTING=1

calendar_icon=$(echo -e "\xEF\x81\xB3")
time_icon=$(echo -e "\xEF\x80\x97")
disk_icon=$(echo -e "\xEF\x82\xA0")
memory_icon=$(echo -e "\xEF\x8B\x9B")
load_icon=$(echo -e "\xEF\x87\xBE")
keyboard_icon=$(echo -e "\xEF\x84\x9C")
battery_icon=$(echo -e "\xEF\x89\x80")
vol_muted_icon=$(echo -e "\xEF\x80\xA6")
vol_full_icon=$(echo -e "\xEF\x80\xA8")
network_icon=$(echo -e "\xEF\x83\xA8")
wifi_icon=$(echo -e "\xEF\x87\xAB")
dropbox_icon=$(echo -e "\xEF\x85\xAB")

# Load Xresources settings
xrdb -load ~/Documents/Settings/.Xdefaults &

# Background
feh --bg-fill ~/Documents/Settings/Wallpapers/ --no-fehbg --randomize --recursive &

while true
do
    status=""

    datetime=$(date +"$calendar_icon %a %d %b $time_icon %R")

    status="$datetime"

    disk=$(/usr/local/src/i3blocks/scripts/disk | sed -n 2p)

    status="$disk_icon $disk  $status"

    memory=$(/usr/local/src/i3blocks/scripts/memory | sed -n 2p)

    status="$memory_icon $memory  $status"

    load=$(/usr/local/src/i3blocks/scripts/cpu_usage | sed -n 2p)

    status="$load_icon $load  $status"

    kb_layout=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}' | sed 's/.*/\U&/')

    status="$keyboard_icon $kb_layout  $status"

    volume=$(/usr/local/src/i3blocks/scripts/volume)

    if [ "$volume" == "MUTE" ]; then
        status="$vol_muted_icon $volume  $status"
    else
        status="$vol_full_icon $volume  $status"
    fi

    battery=$(/usr/local/src/i3blocks/scripts/battery)

    if [ "$battery" != "" ]; then
        if [[ "$battery" != *"DIS"* ]]; then
            battery2=$(echo -e "$battery" | sed -n 2p)
        else
            battery2=$(echo -e "$battery" | sed -n 1p)
        fi
        status="$battery_icon $battery2  $status"
    fi

    iface=$(/usr/local/src/i3blocks/scripts/iface | sed -n 2p)

    if [ "$iface" != "" ]; then
        status="$network_icon $iface  $status"
    fi

    wifi=$(/usr/local/src/i3blocks/scripts/wifi | sed -n 2p)

    if [ "$wifi" != "" ]; then
        status="$wifi_icon $wifi  $status"
    fi

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
