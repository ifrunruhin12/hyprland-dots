#!/bin/bash

# Initialize swww daemon for wallpaper animations
# This script is called during Hyprland startup

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CURRENT_WALLPAPER_FILE="/tmp/hypr_current_wallpaper"

# Ensure wallpaper directory exists, if not create it
if [ ! -d "$WALLPAPER_DIR" ]; then
    mkdir -p "$WALLPAPER_DIR"
    notify-send "Created wallpaper directory" "Please add wallpapers to $WALLPAPER_DIR"
fi

# Give the system a moment to fully initialize
sleep 2

# Kill any existing swww daemon
killall swww-daemon 2>/dev/null

# Wait a moment to ensure the daemon is fully stopped
sleep 1

# Start the swww daemon with retry logic
MAX_ATTEMPTS=3
ATTEMPT=1
DAEMON_STARTED=false

while [ $ATTEMPT -le $MAX_ATTEMPTS ] && [ "$DAEMON_STARTED" = false ]; do
    swww init && DAEMON_STARTED=true
    
    if [ "$DAEMON_STARTED" = false ]; then
        echo "Attempt $ATTEMPT to start swww daemon failed, retrying..."
        sleep 1
        ATTEMPT=$((ATTEMPT + 1))
    fi
done

if [ "$DAEMON_STARTED" = false ]; then
    notify-send "Error" "Failed to start swww after $MAX_ATTEMPTS attempts. Please install swww."
    exit 1
fi

# Find all valid wallpapers
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) 2>/dev/null)

# Check if we found any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Warning" "No wallpapers found in $WALLPAPER_DIR. Please add some."
    exit 1
fi

# Select a random wallpaper
RANDOM_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
SELECTED_PATH="${WALLPAPERS[$RANDOM_INDEX]}"

# Save the wallpaper path for future reference
echo "$SELECTED_PATH" > "$CURRENT_WALLPAPER_FILE"

# Apply the wallpaper with a clean fade transition for startup
swww img "$SELECTED_PATH" \
    --transition-type fade \
    --transition-step 90 \
    --transition-duration 1.5 \
    --transition-fps 60

exit 0
