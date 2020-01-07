#!/bin/bash
set -euo pipefail
shopt -s globstar nullglob

connected=()
internal='eDP-1'
previous=""
optionstring=()

while read -ra xrandr
do
    if [[ "${xrandr[1]}" = connected ]]
    then
        connected+=("${xrandr[0]}")
    elif [[ "${xrandr[1]}" = disconnected ]]
    then
        xrandr --output "${xrandr[0]}" --off
    fi
done <<< "$(xrandr)"

for i in "${connected[@]}"
do
    [[ "$i" = "$internal" ]] && continue
    if [[ "$previous" = "" ]]
    then
        optionstring+=("--output" "${internal}" "--primary" "--below" "${i}" "--output" "${i}" "--auto")
        previous="$i"
        continue
    fi
    optionstring+=("--output" "${i}" "--auto" "--left-of" "${previous}")
    previous="$i"
done

xrandr "${optionstring[@]}"

feh --bg-fill ~/Documents/Settings/Wallpapers --no-fehbg --randomize --recursive

exit 0
