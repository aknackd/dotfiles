#!/usr/bin/env bash

#
# Installs and sets up nodenv
#
# This script *does not* do the following:
#
#     1. Add `$NODENV_ROOT/bin` to your PATH
#     2. Add `eval "$(nodenv init -)"` to your shell rc
#
# You must do these things manually yourself.
#

set -o errexit

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

readonly NODENV_ROOT=$HOME/.nodenv

# Install the latest stable version of nodenv
install() {
    log::info "===> Installing latest stable nodenv..."

    git clone https://github.com/nodenv/nodenv "$NODENV_ROOT"

    # try compiling the dynamic bash extension to speed up rbenv
    set +o errexit
    pushd "$NODENV_ROOT" >/dev/null ; src/configure ; make -C src ; popd >/dev/null

    set -o errexit
    eval "$(${NODENV}/bin/nodenv init -)"
    log::info "---> nodenv version: $(${NODENV_ROOT}/bin/nodenv --version | awk '{print $2}')"

    # install plugins
    local readonly plugins=(
        nodenv/node-build
    )

    for plugin in "${plugins[@]}"; do
        if ! test -d "$NODENV_ROOT/plugins/$(basename $plugin)"; then
            log::info "---> Installing plugin: $plugin"
            git clone https://github.com/${plugin}.git "$NODENV_ROOT/plugins/$(basename $plugin)"
        fi
    done
}

[ ! -f "$NODENV_ROOT/bin/nodenv" ] && install || log::warning "nodenv already installed! skipping"
