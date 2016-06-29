#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

#
# Creates ~/.vim directory
#
create_vim_folder() {
    if ! test -d ~/.vim; then
        log::info "===> Creating ~/.vim"
        mkdir -p ~/.vim/{autoload,backup,bundle,temp}
    fi
}

#
# Installs pathogen
#
install_pathogen() {
    if ! test -f ~/.vim/autoload/pathogen.vim; then
        log::info "===> Installing pathogen"
        curl -sSLo ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
}

#
# Installs vim color schemes from
# https://github.com/flazz/vim-colorschemes
#
install_color_schemes() {
    if test ! -d ~/.vim/colors; then
        log::info "===> Installing vim colors"

        # handle mktemp for Linux and Darwin (OSX)
        local readonly tmpdir=$(mktemp -d 2>/dev/null || mktemp -d -t vim-colors)

        git clone https://github.com/flazz/vim-colorschemes.git $tmpdir
        mv "${tmpdir}/colors" ~/.vim/colors
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
    )

    for plugin in "${plugins[@]}"; do
        if ! test -d ~/.vim/bundle/$(basename $plugin); then
            log::info "===> Installing plugin: $plugin"
            git clone https://github.com/${plugin}.git ~/.vim/bundle/$(basename $plugin)
        fi
    done
}

create_vim_folder
install_pathogen
install_color_schemes
install_plugins
