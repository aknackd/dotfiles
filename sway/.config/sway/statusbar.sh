#!/usr/bin/bash

# Check if the waybar process is running
if pgrep -x "waybar" >/dev/null; then
    pkill -x "waybar"
    sleep 1
fi

waybar &
