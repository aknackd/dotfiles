#!/usr/bin/env bash

#
# Installs and sets up pyenv - Python Version Manager
#
# This script *does not* do the following:
#
#     1. Add `$PYENV_ROOT/bin` to your PATH
#     2. Add `eval "$(pyenv init -)"` to your shell rc
#
# You must do these things manually yourself.
#

set -o errexit

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

export PYENV_ROOT=$HOME/.pyenv
export PATH="$PATH:$PYENV_ROOT/bin"

# Install the latest stable version of pyenv
install() {
    log::info "===> Installing pyenv..."

    git clone https://github.com/yyuu/pyenv.git "$PYENV_ROOT" \
        && eval "$(pyenv init -)" \
        && log::info "---> pyenv version: $(pyenv --version | awk '{print $2}')"
}

[ ! -f "$PYENV_ROOT/bin/pyenv" ] && install || log::warning "pyenv already installed! skipping"