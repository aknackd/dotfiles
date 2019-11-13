#!/usr/bin/env sh

readonly RED=colour1
readonly GREEN=colour28
readonly YELLOW=colour3
readonly BLUE=colour4
readonly GRAY=colour247

case $(uname -s) in
    Darwin)
        percentage=$(pmset -g batt | grep -o "[0-9]\+%")
        status=$(pmset -g sysload | grep battery | awk '{print $5}')
        ;;
esac

actual=$(echo $percentage | sed 's/%$//')
icon=
color=

if (( actual == 100 )); then
    icon=""
    color=$GREEN
elif (( actual > 60 && actual < 100 )); then
    icon=""
    color=$GREEN
elif (( actual == 50 )); then
    icon=""
    color=$BLUE
elif (( actual > 20 && actual < 50 )); then
    icon=""
    color=$YELLOW
else
    icon=""
    color=$RED
fi

echo "#[fg=${color}] ${icon}#[fg=default] ${percentage} #[fg=${GRAY}](#[fg=${color}]${status}#[fg=default])"

