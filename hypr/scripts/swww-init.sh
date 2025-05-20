#!/bin/bash

# Initialize swww daemon for wallpaper animations

# Kill any existing swww daemon
killall swww-daemon 2>/dev/null

# Start the swww daemon
swww init || {
    # If swww fails, notify user to install it
    notify-send "Error" "swww is not installed. Please install it with your package manager."
    exit 1
}

# Set initial wallpaper with smooth transition
WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Find a random wallpaper to start with
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)

# If no wallpaper found, use a fallback
if [ -z "$WALLPAPER" ]; then
    notify-send "Warning" "No wallpapers found in $WALLPAPER_DIR. Using fallback."
    exit 1
fi

# Apply the wallpaper with a smooth fade
swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-pos "$(hyprctl cursorpos | awk '{print $1,$2}')" \
    --transition-duration 1 \
    --transition-fps 144

exit 0 