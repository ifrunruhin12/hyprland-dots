#!/bin/bash

# Cache file location
WAIFU_LIST="$HOME/.cache/waifu_list.txt"

# Update cache if new images are found or if the cache is empty
if [[ ! -s "$WAIFU_LIST" || $(find ~/Pictures/waifus -type f -newer "$WAIFU_LIST" | wc -l) -gt 0 ]]; then
  find ~/Pictures/waifus -type f -name "*.png" > "$WAIFU_LIST"
fi

# Read the waifu images into an array
mapfile -t WAIFU_IMAGES < "$WAIFU_LIST"

# Ensure there are images in the array
if [[ ${#WAIFU_IMAGES[@]} -eq 0 ]]; then
  echo "No waifu images found."
  exit 1
fi

# Get a random waifu image
WAIFU_IMAGE=${WAIFU_IMAGES[RANDOM % ${#WAIFU_IMAGES[@]}]}

# Check if the selected file is a valid image
if [[ -f "$WAIFU_IMAGE" && $(file "$WAIFU_IMAGE" | grep -i 'image') ]]; then
  chafa --size=40x40 -c none "$WAIFU_IMAGE"
else
  echo "No valid image found."
fi

