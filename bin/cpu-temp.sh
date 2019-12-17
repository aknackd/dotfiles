#!/usr/bin/env sh

readonly RED=colour1
readonly GREEN=colour28
readonly YELLOW=colour3
readonly BLUE=colour4
readonly GRAY=colour247

icon="宅"
temp=

case $(uname -s) in
    Darwin)
        temp="CPU:#[fg=${GREEN}]$(osx-cpu-temp -c -F) #[fg=default]GPU:#[fg=${YELLOW}]$(osx-cpu-temp -g -F)" ;;
esac

echo "#[fg=${RED}]${icon}#[fg=default]${temp}"

