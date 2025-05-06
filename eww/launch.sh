#!/bin/bash

# Kill any existing Eww instances to avoid duplicates
eww kill

# Give it a sec to breathe (just in case Hyprland is still starting)
sleep 1

# Start the daemon
eww daemon

# Wait for Eww to be fully ready
sleep 0.5

# Open the main system info widget
eww open sysinfo

