#!/usr/bin/env bash

if command -v gnome-keyring-daemon >/dev/null ; then
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
fi

xset s off &
xset -dpms &
xrdb -merge ~/.Xresources &
autocutsel -fork &
urxvtd &
command -v VBoxClient-all 2>/dev/null && VBoxClient-all &

xrandr --auto --output VGA-1 --mode 1920x1080 --left-of VGA-2
xrandr --auto --output VGA-2 --mode 1920x1080 --right-of VGA-1

xsetroot -solid '#181818'

exec i3
# exec twm
# exec herbstluftwm
