#!/usr/bin/env bash

option=$(echo -e " Shutdown\n Reboot\n Sleep\n󰗽 Logout" | wofi --dmenu --width 200 --height 245 --insensitive --style ~/.config/wofi/style.css)

case "$option" in
  " Shutdown") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Sleep") systemctl suspend ;;
  "󰗽 Logout") hyprctl dispatch exit ;;
  *) exit 0 ;;
esac
