#!/bin/bash

theme="$HOME/.config/rofi/powermenu.rasi"

shutdown=""
reboot=""
lock=""
suspend=""
logout=""

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

selected_option=$(echo -e "$options" | rofi -dmenu -theme "$theme" -p "Goodbye")

case $selected_option in
"$lock")
  pkill rofi
  sleep 0.03
  hyprlock &
  ;;
"$logout")
  hyprctl dispatch exit
  ;;
"$suspend")
  systemctl suspend
  ;;
"$reboot")
  systemctl reboot
  ;;
"$shutdown")
  systemctl poweroff
  ;;
esac
