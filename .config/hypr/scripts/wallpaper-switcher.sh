#!/bin/bash

# Super fast wallpaper switcher using Rofi's native image preview
# For Hyprland with hyprpaper

WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory $WALLPAPER_DIR does not exist."
    exit 1
fi

# Build the menu options directly from the files
# This is much faster than generating thumbnails
menu_items=""
while IFS= read -r img; do
    filename=$(basename "$img")
    # Add to menu items with direct path to image
    menu_items+="${filename}\0icon\x1f${img}\n"
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | sort)

# Run rofi with bluish theme and icon settings
SELECTED=$(echo -e "$menu_items" | rofi -dmenu \
    -i \
    -p "Wallpaper" \
    -show-icons \
    -theme-str 'window {background-color: #1E293B; width: 70%; height: 70%; border: 2px; border-color: #60A5FA; border-radius: 8px;}' \
    -theme-str 'element {orientation: vertical; padding: 2px; spacing: 2px;}' \
    -theme-str 'element-icon {size: 160px;}' \
    -theme-str 'element-text {horizontal-align: 0.5; vertical-align: 0.5;}' \
    -theme-str 'listview {columns: 3; spacing: 5px; fixed-columns: true; cycle: false;}' \
    -theme-str 'element selected {background-color: #3B82F6; text-color: #FFFFFF;}' \
    -theme-str 'inputbar {padding: 8px; background-color: #1E293B; text-color: #60A5FA;}' \
    -theme-str 'prompt {text-color: #60A5FA;}' \
    -theme-str 'entry {text-color: #FFFFFF;}')

# If a wallpaper was selected
if [ -n "$SELECTED" ]; then
    # Get the full path
    SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"
    
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
    
    # Notify the user
    notify-send "Wallpaper Changed" "Switched to: $SELECTED"
fi

exit 0 