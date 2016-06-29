#!/usr/bin/env bash

#
# Installs and sets up nvm - Node Version Manager
#
# This script *does not* add `source $NVM_DIR/nvm.sh` to your shell
# startup, you must do it manually yourself.
#

set -o errexit

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

readonly NVM_DIR=$HOME/.nvm

# Install the latest stable version of nvm
install() {
    log::info "===> Installing latest stable nvm..."
    git clone https://github.com/creationix/nvm.git "$NVM_DIR" \
        && pushd "$NVM_DIR" >/dev/null \
        && git checkout $(git describe --abbrev=0 --tags) \
        && popd >/dev/null

    source "$NVM_DIR/nvm.sh"
    printf "nvm version: %s\n" $(nvm --version)
}

[ ! -f "$NVM_DIR/nvm.sh" ] && install || log::warning "nvm already installed! skipping"
