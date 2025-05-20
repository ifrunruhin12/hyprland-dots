#!/bin/bash

# Super fancy wallpaper switcher using Rofi's native image preview
# For Hyprland with swww (stylish transitions)

WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CURRENT_WALLPAPER_FILE="/tmp/hypr_current_wallpaper"

# Array of transition effects
TRANSITIONS=("simple" "wipe" "grow" "outer" "wave" "random")

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

# Build the menu options directly from the files
menu_items=""
while IFS= read -r img; do
    filename=$(basename "$img")
    # Add to menu items with direct path to image
    menu_items+="${filename}\0icon\x1f${img}\n"
done < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | sort)

# Add a separator and transition options
menu_items+="--TRANSITION EFFECTS--\0icon\x1f~/.config/hypr/wallpapers/icon-transition.png\n"
for transition in "${TRANSITIONS[@]}"; do
    menu_items+="Effect: ${transition}\0icon\x1f~/.config/hypr/wallpapers/effect-${transition}.png\n"
done

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

# If something was selected
if [ -n "$SELECTED" ]; then
    # Check if a transition effect was selected
    if [[ "$SELECTED" == "Effect:"* ]]; then
        # Extract the transition name
        TRANSITION=$(echo "$SELECTED" | cut -d' ' -f2)
        
        # Save the selected transition to a config file
        echo "$TRANSITION" > "$HOME/.config/hypr/current_transition"
        
        notify-send "Transition Effect Changed" "Now using: $TRANSITION"
    else
        # A wallpaper was selected
        
        # Get the full path
        SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"
        
        # Save the wallpaper for the random wallpaper script to know
        echo "$SELECTED_PATH" > "$CURRENT_WALLPAPER_FILE"
        
        # Get current transition effect (default to grow if none set)
        TRANSITION="grow"
        if [ -f "$HOME/.config/hypr/current_transition" ]; then
            TRANSITION=$(cat "$HOME/.config/hypr/current_transition")
        fi
        
        # If transition is "random", select a random transition
        if [ "$TRANSITION" = "random" ]; then
            TRANSITIONS_RANDOM=("simple" "wipe" "grow" "outer" "wave")
            RANDOM_INDEX=$((RANDOM % ${#TRANSITIONS_RANDOM[@]}))
            TRANSITION="${TRANSITIONS_RANDOM[$RANDOM_INDEX]}"
        fi
        
        # Enhanced transition effects with dynamic parameters
        case "$TRANSITION" in
            "simple")
                # Simple fade with higher step for more fluid animation
                swww img "$SELECTED_PATH" \
                    --transition-type simple \
                    --transition-step 90 \
                    --transition-duration 2 \
                    --transition-fps 60
                ;;
            "wipe")
                # Wipe with random angle for variety
                ANGLE=$((RANDOM % 360))
                swww img "$SELECTED_PATH" \
                    --transition-type wipe \
                    --transition-angle $ANGLE \
                    --transition-step 90 \
                    --transition-duration 2 \
                    --transition-fps 60
                ;;
            "grow")
                # Grow from cursor position
                swww img "$SELECTED_PATH" \
                    --transition-type grow \
                    --transition-pos "$(hyprctl cursorpos | awk '{print $1,$2}')" \
                    --transition-step 90 \
                    --transition-duration 2 \
                    --transition-fps 60
                ;;
            "outer")
                # Outer transition
                swww img "$SELECTED_PATH" \
                    --transition-type outer \
                    --transition-step 90 \
                    --transition-duration 2 \
                    --transition-fps 60
                ;;
            "wave")
                # Wave with random frequency for different pattern each time
                FREQ=$(awk -v min=10 -v max=30 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
                swww img "$SELECTED_PATH" \
                    --transition-type wave \
                    --transition-step 90 \
                    --transition-duration 2 \
                    --transition-fps 60 \
                    --transition-wave $FREQ
                ;;
        esac
        
        # Notify the user with enhanced details
        notify-send "Wallpaper Changed" "Switched to: $SELECTED (Effect: $TRANSITION)" --icon="$SELECTED_PATH"
    fi
fi

exit 0 