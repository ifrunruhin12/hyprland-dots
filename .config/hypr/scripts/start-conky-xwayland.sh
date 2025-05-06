#!/bin/bash
# Wait 10 seconds for desktop to load
sleep 10
# Kill any existing conky processes
killall conky 2>/dev/null
# Set appropriate environment variables for XWayland
DISPLAY=:0
export DISPLAY
# Start conky
conky -c ~/.config/conky/neofetch.conf &
exit 0
