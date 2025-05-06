#!/bin/bash

# Simple emoji selector using wofi
# Requires: wofi, wl-clipboard

# Array of common emojis with descriptions
EMOJIS=(
    "😀 Smile"
    "😂 Laugh"
    "😍 Heart Eyes"
    "🥰 In Love"
    "😎 Cool"
    "🤔 Thinking"
    "🙄 Rolling Eyes"
    "😴 Sleeping"
    "🤗 Hug"
    "👍 Thumbs Up"
    "👎 Thumbs Down"
    "👏 Clap"
    "🙏 Pray"
    "🔥 Fire"
    "❤️ Heart"
    "✨ Sparkles"
    "🌟 Star"
    "😭 Crying"
    "😢 Sad"
    "😡 Angry"
    "🤯 Mind Blown"
    "👀 Eyes"
    "🎉 Party"
    "🚀 Rocket"
    "💻 Laptop"
    "🍕 Pizza"
    "🍺 Beer"
    "🎮 Gaming"
    "🎵 Music"
    "📱 Phone"
)

# Function to display emojis in wofi and copy selection to clipboard
show_emojis() {
    printf "%s\n" "${EMOJIS[@]}" | wofi --dmenu --prompt="Select emoji" --width=400 --height=500 | awk '{print $1}' | wl-copy
    
    # Notify the user
    notify-send "Emoji copied to clipboard!" "$(wl-paste)" -t 1500
}

# Execute function
show_emojis 