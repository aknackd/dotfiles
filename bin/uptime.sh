#!/usr/bin/env sh

readonly RED=colour1
readonly GREEN=colour28
readonly YELLOW=colour3
readonly BLUE=colour4
readonly GRAY=colour247

IFS=' ' read -ra LOADAVG<<< $(uptime | rev | cut -d':' -f1 | rev | sed s/,//g)

last1="${LOADAVG[0]}"
last5="${LOADAVG[1]}"
last15="${LOADAVG[2]}"

echo "#[fg=${BLUE}]  #[fg=${GREEN}]${last1} #[fg=${YELLOW}]${last5} #[fg=${GRAY}]${last15}"
