#!/bin/bash

# Get active workspace
active=$(hyprctl activeworkspace -j | jq '.id')

# Generate workspace array with specified number of workspaces
workspaces=$(seq 1 5 | jq --argjson active "$active" --slurp -R 'split("\n") | map(select(length > 0)) | map({id: ., active: (. == $active|tostring)})')

echo "$workspaces" 