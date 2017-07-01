#!/usr/bin/env bash

if command -v gnome-keyring-daemon >/dev/null ; then
    eval $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
fi

xset s off &
xset -dpms &
xrdb -merge ~/.Xresources &
autocutsel -fork &
autocutsel -fork -selection PRIMARY &
#xmodmap ~/.keybindings &

# set resolution
if command -v xrandr >/dev/null ; then
    (
        MAX_DISPLAYS=5

        # only in VMs for now until we can parse xrandr properly instead of depending on VGA-* named displays
        grep --color=none hypervisor /proc/cpuinfo >/dev/null

        if [ $? -eq 0 ]; then

            for NUM in 1..$MAX_DISPLAYS; do

                _display=$(xrandr | grep "VGA-${NUM} connected")

                if [ $? -eq 0 ]; then

                    _resolution=$(echo $_display \
                        | awk '{print $3}' \
                        | sed -n 's/\(\([0-9]*\)x\([0-9]*\)\).*/\1/p')

                    _args="--output $_display --mode $_resolution"

                    # (for now) assume display num > 1 is to the right of display num-1
                    # we really should write a proper script to detect this better
                    [[ $NUM -gt 1 ]] && _xrandr+=" --right-of VGA-$(expr $NUM - 1)"

                    echo "xrandr $_args" >> /home/aknaack/xrandr.log

                    xrandr $_args

                else

                    break  # no need to check for displays that don't exist

                fi

            done
        fi
    )
fi

# set background
command -v feh >/dev/null -a -f ~/.background && feh --bg-fill ~/.background

exec i3
