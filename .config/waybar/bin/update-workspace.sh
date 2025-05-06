#!/bin/bash

# This script listens for workspace changes in Hyprland and updates the waybar CSS

CONFIG_DIR="$HOME/.config/waybar"
STYLE_FILE="$CONFIG_DIR/style.css"

# Get active workspace
get_active_workspace() {
    hyprctl activeworkspace -j | jq '.id'
}

# Watch for workspace changes
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | 
while read -r line; do
    # If workspace change event
    if [[ $line == workspace* ]]; then
        active=$(get_active_workspace)
        # Update each workspace CSS class
        for i in {1..5}; do
            if [ "$i" -eq "$active" ]; then
                # Add active class
                sed -i "s/#custom-workspace$i {/#custom-workspace$i.active {/g" "$STYLE_FILE"
            else
                # Remove active class
                sed -i "s/#custom-workspace$i.active {/#custom-workspace$i {/g" "$STYLE_FILE"
            fi
        done
        # Signal waybar to reload
        pkill -SIGUSR2 waybar
    fi
done 