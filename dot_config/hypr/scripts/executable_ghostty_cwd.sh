#!/usr/bin/env bash

# Get active window info from Hyprland
ACTIVE_WINDOW=$(hyprctl activewindow -j)
CLASS=$(echo "$ACTIVE_WINDOW" | jq -r '.class')
PID=$(echo "$ACTIVE_WINDOW" | jq -r '.pid')

CWD=""

# Check if the active window is Ghostty
if { [ "$CLASS" = "com.mitchellh.ghostty" ] || [[ "$CLASS" == *ghostty* ]] || [[ "$CLASS" == *com.svend* ]]; } && [ -n "$PID" ] && [ "$PID" != "null" ]; then
    # Get the youngest shell child process PID (highest PID)
    SHELL_PID=$(pgrep -P "$PID" | sort -n | tail -n 1)
    if [ -n "$SHELL_PID" ]; then
        CWD=$(readlink -f "/proc/$SHELL_PID/cwd")
    fi
fi

# If we found a valid CWD, open Ghostty there. Otherwise, default to home.
if [ -n "$CWD" ] && [ -d "$CWD" ]; then
    ghostty --working-directory="$CWD"
else
    ghostty --working-directory="$HOME"
fi
