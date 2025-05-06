#!/bin/bash

# Random wallpaper switcher for Hyprland with hyprpaper
# Triggered with SUPER+alt+W

WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory $WALLPAPER_DIR does not exist."
    exit 1
fi

# Find all valid wallpapers
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | sort)

# Check if we found any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Error" "No wallpapers found in $WALLPAPER_DIR."
    exit 1
fi

# Get current wallpaper from config file
CURRENT_WALLPAPER=$(grep "wallpaper =" "$CONFIG_FILE" | awk -F, '{print $2}' | tr -d ' ')

# Keep selecting a random wallpaper until we get one different from the current
while true; do
    # Select a random wallpaper
    RANDOM_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
    SELECTED_PATH="${WALLPAPERS[$RANDOM_INDEX]}"
    
    # Break the loop if we selected a different wallpaper
    # or if we only have one wallpaper in the directory
    if [ "$SELECTED_PATH" != "$CURRENT_WALLPAPER" ] || [ ${#WALLPAPERS[@]} -eq 1 ]; then
        break
    fi
done

# First stop any existing hyprpaper process
if pgrep -x hyprpaper >/dev/null; then
    killall hyprpaper
    sleep 0.5
fi

# Update the hyprpaper.conf file
cat > "$CONFIG_FILE" << EOF
preload = $SELECTED_PATH
wallpaper = ,$SELECTED_PATH

EOF

# Start hyprpaper fresh with the new config
hyprpaper & disown

# Notify the user with a nicer filename (without the path)
FILENAME=$(basename "$SELECTED_PATH")
notify-send "Random Wallpaper Applied" "Switched to: $FILENAME" --icon="$SELECTED_PATH"

exit 0 