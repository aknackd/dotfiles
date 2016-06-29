#!/usr/bin/env bash

#
# Installs and sets up gimme - Golang installer
#
# This script *does not* add `$HOME/bin` to your PATH, you
# must do these things manually yourself.
#

set -o errexit

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

readonly GIMME_BIN=$HOME/bin/gimme

# Install the latest stable version of pyenv
install() {
    log::info "===> Installing gimme..."

    curl -sL -o "$GIMME_BIN" https://raw.githubusercontent.com/travis-ci/gimme/master/gimme \
        && chmod +x "$GIMME_BIN" \
        && log::info "---> gimme version: $($GIMME_BIN version)"
}

[ ! -f "$GIMME_BIN" ] && install || log::warning "gimme already installed! skipping"
