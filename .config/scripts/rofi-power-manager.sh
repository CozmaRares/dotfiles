#!/usr/bin/env bash

rst="󰑐  Reset"
perf="  Performance"
pwrsv="󱈏  Powersave"

choice=$(echo "$rst|$perf|$pwrsv" | rofi -dmenu -p "AutoCPU:" -sep "|" -selected-row 0)
notif=""

case "$choice" in
    "$rst")
        sudo auto-cpufreq --force reset
        notif="reset power state"
        ;;
    "$perf")
        sudo auto-cpufreq --force performance
        notif="enabled performance mode"
        ;;
    "$pwrsv")
        sudo auto-cpufreq --force powersave
        notif="enabled powersave mode"
        ;;
esac

notify-send "AutoCPU:" "$notif"
