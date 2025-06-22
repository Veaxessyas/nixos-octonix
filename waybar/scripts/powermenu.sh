#!/usr/bin/env bash

option=$(echo -e " Shutdown\n Reboot\n󰗽 Logout\n Sleep" | wofi --dmenu --width 200 --height 200 --insensitive --style ~/.config/wofi/style.css)

case "$option" in
  " Shutdown") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  "󰗽 Logout") hyprctl dispatch exit ;;
  " Sleep") systemctl suspend ;;
  *) exit 0 ;;
esac
