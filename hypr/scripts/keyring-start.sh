#!/bin/sh

# Start the gnome-keyring-daemon and export its environment variables
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)

# Unlock the login keyring if it exists
if [ -f "$HOME/.local/share/keyrings/login.keyring" ]; then
    echo "Attempting to unlock keyring..."
    /usr/bin/secret-tool search doesnot matter </dev/null
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
export GPG_AGENT_INFO="$XDG_RUNTIME_DIR/keyring/gpg"
export GNOME_KEYRING_CONTROL="$XDG_RUNTIME_DIR/keyring"
export GNOME_KEYRING_PID="$!"

