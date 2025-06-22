#!/usr/bin/env bash

# Wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Grab all image paths
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \)))

# Choose a random one to start with
RANDOM_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# Wait until hyprpaper is ready
until hyprctl hyprpaper listpreloads &>/dev/null; do
    sleep 0.2
done

# Start hyprpaper with that random wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$RANDOM_WALLPAPER"
hyprctl hyprpaper wallpaper "eDP-1,$RANDOM_WALLPAPER"

# Then loop and rotate every 30 minutes
while true; do
    for WP in "${WALLPAPERS[@]}"; do
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$WP"
        hyprctl hyprpaper wallpaper "eDP-1,$WP"
        sleep 1800
    done
done
