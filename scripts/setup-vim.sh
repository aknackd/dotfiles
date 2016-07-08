#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

readonly VIM_ROOT=$HOME/.vim

#
# Creates ~/.vim directory
#
create_vim_folder() {
    if ! test -d $VIM_ROOT; then
        log::info "===> Creating $VIM_ROOT"
        mkdir -p $VIM_ROOT/{autoload,backup,bundle,temp}
    fi
}

#
# Installs pathogen
#
install_pathogen() {
    if ! test -f $VIM_ROOT/autoload/pathogen.vim; then
        log::info "===> Installing pathogen"
        curl -sSLo $VIM_ROOT/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
}

#
# Installs vim color schemes from
# https://github.com/flazz/vim-colorschemes
#
install_color_schemes() {
    if test ! -d $VIM_ROOT/colors; then
        log::info "===> Installing vim colors"

        # handle mktemp for Linux and Darwin (OSX)
        local readonly tmpdir=$(mktemp -d 2>/dev/null || mktemp -d -t vim-colors)

        git clone https://github.com/flazz/vim-colorschemes.git $tmpdir
        mv "${tmpdir}/colors" $VIM_ROOT/colors
        rm -rf $tmpdir
    fi
}

#
# Installs various plugins
#
install_plugins() {
    # vim plugins on github
    local readonly plugins=(
        bling/vim-airline
        fatih/vim-go
        scrooloose/nerdtree
        godlygeek/tabular
    )

    for plugin in "${plugins[@]}"; do
        if ! test -d $VIM_ROOT/bundle/$(basename $plugin); then
            log::info "===> Installing plugin: $plugin"
            git clone https://github.com/${plugin}.git $VIM_ROOT/bundle/$(basename $plugin)
        fi
    done
}

create_vim_folder
install_pathogen
install_color_schemes
install_plugins
