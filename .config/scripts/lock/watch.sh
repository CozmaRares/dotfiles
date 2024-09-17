#!/usr/bin/env bash

set -o errexit -o noclobber -o nounset

script_dir="$(dirname "$(readlink -f "$0")")"
image="$script_dir/watch-bg.png"
param=("--inside-color=ffffff1c" "--ring-color=ffffff3e" \
    "--line-color=ffffff00" "--keyhl-color=00000080" "--ringver-color=00000000" \
    "--separator-color=22222260" "--insidever-color=0000001c" \
    "--ringwrong-color=00000055" "--insidewrong-color=0000001c" \
    "--verif-color=00000000" "--wrong-color=ff000000" "--time-color=00000000" \
    "--date-color=00000000" "--layout-color=00000000")
i3lock -i "$image" "${param[@]}" -e -n
wait
