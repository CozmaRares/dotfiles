#!/usr/bin/env bash

# Stripped down version of i3lock-fancy
# https://github.com/meskarune/i3lock-fancy

set -o errexit -o noclobber -o nounset

image="$HOME/.lock.png"

flameshot screen -p "$image" 1>/dev/null 2>&1

value="60"
color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb     -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}')
script_dir="$(dirname "$(readlink -f "$0")")"

# color > value then background is white
if [[ $color -gt $value ]]; then
    icon="$script_dir/lockdark.png"
    param=("--inside-color=0000001c" "--ring-color=0000003e" \
        "--line-color=00000000" "--keyhl-color=ffffff80" "--ringver-color=ffffff00" \
        "--separator-color=22222260" "--insidever-color=ffffff1c" \
        "--ringwrong-color=ffffff55" "--insidewrong-color=ffffff1c" \
        "--verif-color=ffffff00" "--wrong-color=ff000000" "--time-color=ffffff00" \
        "--date-color=ffffff00" "--layout-color=ffffff00")
else
    icon="$script_dir/lock.png"
    param=("--inside-color=ffffff1c" "--ring-color=ffffff3e" \
        "--line-color=ffffff00" "--keyhl-color=00000080" "--ringver-color=00000000" \
        "--separator-color=22222260" "--insidever-color=0000001c" \
        "--ringwrong-color=00000055" "--insidewrong-color=0000001c" \
        "--verif-color=00000000" "--wrong-color=ff000000" "--time-color=00000000" \
        "--date-color=00000000" "--layout-color=00000000")
fi

convert "$image" -colorspace Gray -blur 0x8 "$icon" -gravity center -composite "$image"

i3lock -i "$image" "${param[@]}"

wait

rm "$image"
