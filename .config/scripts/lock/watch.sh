#!/usr/bin/env bash

set -o errexit -o noclobber -o nounset

script_dir="$(dirname "$(readlink -f "$0")")"
image="$script_dir/watch-bg.jpg"
param=("--inside-color=0000001c" "--ring-color=0000003e" \
    "--line-color=00000000" "--keyhl-color=ffffff80" "--ringver-color=ffffff00" \
    "--separator-color=22222260" "--insidever-color=ffffff1c" \
    "--ringwrong-color=ffffff55" "--insidewrong-color=ffffff1c" \
    "--verif-color=ffffff00" "--wrong-color=ff000000" "--time-color=ffffff00" \
    "--date-color=ffffff00" "--layout-color=ffffff00")
i3lock -i "$image" "${param[@]}" -e -n
wait
