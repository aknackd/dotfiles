#!/usr/bin/env bash

#
# Installs and sets up rbenv - Ruby Version Manager
#
# This script *does not* do the following:
#
#     1. Add `$RBENV_ROOT/bin` to your PATH
#     2. Add `eval "$(rbenv init -)"` to your shell rc
#
# You must do these things manually yourself.
#

set -o errexit

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

readonly RBENV_ROOT=$HOME/.rbenv

# Install the latest stable version of rbenv
install() {
    log::info "===> Installing rbenv..."

    git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"

    # try compiling the dynamic bash extension to speed up rbenv
    set +o errexit
    pushd "$RBENV_ROOT" >/dev/null ; src/configure ; make -C src ; popd >/dev/null

    set -o errexit
    eval "$(${RBENV_ROOT}/bin/rbenv init -)"
    log::info "---> rbenv version: $(${RBENV_ROOT}/bin/rbenv --version | awk '{print $2}')"

    # install plugins
    local readonly plugins=(
        rbenv/ruby-build
        jf/rbenv-gemset
    )

    for plugin in "${plugins[@]}"; do
        if ! test -d "$RBENV_ROOT/plugins/$(basename $plugin)"; then
            log::info "---> Installing plugin: $plugin"
            git clone https://github.com/${plugin}.git "$RBENV_ROOT/plugins/$(basename $plugin)"
        fi
    done
}

[ ! -f "$PYENV_ROOT/bin/rbenv" ] && install || log::warning "rbenv already installed! skipping"
