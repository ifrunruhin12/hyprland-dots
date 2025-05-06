#!/bin/bash

# Run tofi with direct styling parameters
cat <<EOF | tofi --border-color="#89b4fa" --selection-color="#89b4fa" --corner-radius=12 --background-color="#1E1E2E"
🔥 Hyprland Keybinds Cheat Sheet

📦 Apps
󰣇 SUPER + Enter      → Terminal (kitty)
 SUPER + E          → File Manager (thunar)
󰍉 SUPER + Space     → App Launcher (wofi)
🖼️ SUPER + S          → Screenshot Tool
🖼️ SUPER + Shift + W  → Wallpaper Chooser
🖼️ SUPER + Alt + W    → Random Wallpaper

🪟 Window Management
❌ SUPER + Q          → Close Window
󰕰 SUPER + F          → Toggle Fullscreen
 SUPER + V          → Toggle Floating
↔️ SUPER + J          → Move Focus Left
↔️ SUPER + L          → Move Focus Right
↔️ SUPER + I          → Move Focus Up
↔️ SUPER + K          → Move Focus Down

🧠 Workspaces
1️⃣ SUPER + [1-9]       → Switch to Workspace
🚀 SUPER + Shift + [1-5] → Move Window to Workspace

🆘 System & Extras
📜 SUPER + H          → Show This Help Menu 💖
🔒 SUPER + P          → Logout Menu (wlogout)
🎧 SUPER + X/V        → (Mute/Power Menu not bound)
󰍉 SUPER + R/T        → (App/Ani-cli not bound)

EOF

