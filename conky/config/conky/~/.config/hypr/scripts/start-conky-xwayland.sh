#!/bin/bash

# Wait 10 seconds for desktop to load
sleep 10

# Kill any existing conky processes
killall conky 2>/dev/null

# Set appropriate Wayland/X11 variables
DISPLAY=:0
WAYLAND_DISPLAY=wayland-0
HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr/*/hyprland.lock | head -n 1 | cut -d'/' -f4)
XDG_RUNTIME_DIR=/run/user/$(id -u)

# Export them
export DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_RUNTIME_DIR

# Start conky with XWayland
conky -c ~/.config/conky/neofetch.conf &

exit 0 