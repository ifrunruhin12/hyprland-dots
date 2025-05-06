#!/bin/bash

# Wait 10 seconds for desktop to load
sleep 10

# Kill any existing conky processes
killall conky 2>/dev/null

# Start conky with environment variables for Wayland
DISPLAY=:0 conky -c ~/.config/conky/neofetch.conf &

exit 0 