#!/bin/bash

# Kill any existing hyprpaper instances
killall hyprpaper 2>/dev/null

# Wait 1 second
sleep 1

# Start hyprpaper
hyprpaper &

exit 0
