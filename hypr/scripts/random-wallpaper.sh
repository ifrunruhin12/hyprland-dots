#!/bin/bash

# Random wallpaper switcher with fancy transitions
# For Hyprland with swww

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory $WALLPAPER_DIR does not exist."
    exit 1
fi

# Check if swww is running, if not initialize it
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init || {
        notify-send "Error" "Failed to initialize swww daemon. Is swww installed?"
        exit 1
    }
    sleep 1
fi

# Find all valid wallpapers
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | sort)

# Check if we found any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Error" "No wallpapers found in $WALLPAPER_DIR."
    exit 1
fi

# Get current wallpaper - use a simpler method
# The previous method may be failing to properly get the current wallpaper
CURRENT_WALLPAPER_FILE="/tmp/hypr_current_wallpaper"
# If the file exists, read it
if [ -f "$CURRENT_WALLPAPER_FILE" ]; then
    CURRENT_WALLPAPER=$(cat "$CURRENT_WALLPAPER_FILE")
else
    # If file doesn't exist, just set an empty string to ensure we pick a wallpaper
    CURRENT_WALLPAPER=""
fi

# Select a different wallpaper from the current one
while true; do
    # Pick a random wallpaper
    RANDOM_INDEX=$((RANDOM % ${#WALLPAPERS[@]}))
    SELECTED_PATH="${WALLPAPERS[$RANDOM_INDEX]}"
    
    # Break if we selected a different wallpaper or only have one option
    if [ "$SELECTED_PATH" != "$CURRENT_WALLPAPER" ] || [ ${#WALLPAPERS[@]} -eq 1 ]; then
        break
    fi
done

# Save the new wallpaper path for next time
echo "$SELECTED_PATH" > "$CURRENT_WALLPAPER_FILE"

# Always use a different transition type for variety
# Avoid using the previous transition stored in the file
TRANSITIONS=("simple" "wipe" "grow" "outer" "wave")
RANDOM_INDEX=$((RANDOM % ${#TRANSITIONS[@]}))
TRANSITION="${TRANSITIONS[$RANDOM_INDEX]}"

# Make sure we have interesting parameters for each transition type
case "$TRANSITION" in
    "simple")
        # Simple fade
        swww img "$SELECTED_PATH" \
            --transition-type simple \
            --transition-step 90 \
            --transition-duration 2 \
            --transition-fps 60
        ;;
    "wipe")
        # Wipe with random angle
        ANGLE=$((RANDOM % 360))
        swww img "$SELECTED_PATH" \
            --transition-type wipe \
            --transition-angle $ANGLE \
            --transition-step 90 \
            --transition-duration 2 \
            --transition-fps 60
        ;;
    "grow")
        # Grow from random position
        SCREEN_WIDTH=$(hyprctl monitors -j | jq -r '.[0].width')
        SCREEN_HEIGHT=$(hyprctl monitors -j | jq -r '.[0].height')
        POS_X=$((RANDOM % SCREEN_WIDTH))
        POS_Y=$((RANDOM % SCREEN_HEIGHT))
        swww img "$SELECTED_PATH" \
            --transition-type grow \
            --transition-pos "$POS_X $POS_Y" \
            --transition-step 90 \
            --transition-duration 2 \
            --transition-fps 60
        ;;
    "outer")
        # Outer effect
        swww img "$SELECTED_PATH" \
            --transition-type outer \
            --transition-step 90 \
            --transition-duration 2 \
            --transition-fps 60
        ;;
    "wave")
        # Wave with random frequency
        FREQ=$(awk -v min=10 -v max=30 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
        swww img "$SELECTED_PATH" \
            --transition-type wave \
            --transition-step 90 \
            --transition-duration 2 \
            --transition-fps 60 \
            --transition-wave $FREQ
        ;;
esac

# Notify the user
FILENAME=$(basename "$SELECTED_PATH")
notify-send "Random Wallpaper Applied" "Switched to: $FILENAME (Effect: $TRANSITION)" --icon="$SELECTED_PATH"

exit 0 