#!/usr/bin/env bash

export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11

if command -v gnome-keyring-daemon >/dev/null ; then
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
fi

xset s off &
xset -dpms &
xrdb -merge ~/.Xresources &
command -v autocutsel 2>/dev/null && autocutsel -fork &
command -v urxvtd 2>/dev/null && urxvtd &
command -v VBoxClient-all 2>/dev/null && VBoxClient-all &

# xsetroot -solid '#181818'

exec i3
# exec gnome-session
# exec twm
# exec herbstluftwm
