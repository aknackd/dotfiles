#!/usr/bin/env bash

clock () {
    local DATETIME=$(date "+%a %b %d, %F")
    echo -n "$DATETIME"
}

while true; do
    echo "%{c}%{F#FFFF00}%{B#0000FF} $(clock) %{F-}%{B-}"
    sleep 1
done
