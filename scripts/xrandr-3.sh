#!/bin/bash

xrandr --auto

xrandr --output DP-1-1 --right-of DP-1-2 --output eDP-1 --right-of DP-1-1

feh --bg-fill ~/Documents/Settings/Wallpapers/ --no-fehbg --randomize --recursive
