#!/bin/bash

# Wait for desktop to load
sleep 10

# Kill any existing conky processes
killall conky 2>/dev/null

# Ensure XDG_CURRENT_DESKTOP is set for conky
export XDG_CURRENT_DESKTOP=Hyprland

# Start conky with our config
conky -c ~/.config/conky/neofetch.conf &

exit 0 