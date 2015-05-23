#!/usr/bin/env bash

#
# Creates ~/.vim directory
#
function create_vim_folder() {
    if ! test -d ~/.vim
    then
        echo "==> Creating ~/.vim"
        mkdir -p ~/.vim/{autoload,backup,bundle,temp}
    fi
}

#
# Installs pathogen
#
function install_pathogen() {
    if ! test -f ~/.vim/autoload/pathogen.vim
    then
        echo "==> Installing pathogen"
        curl -sSLo ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
}

#
# Installs vim color schemes from
# https://github.com/flazz/vim-colorschemes
#
function install_color_schemes() {
    if test ! -d ~/.vim/colors
    then
        echo "==> Installing vim colors"
        # handle mktemp for Linux and Darwin (OSX)
        local tmpdir=$(mktemp -d 2>/dev/null || mktemp -d -t vim-colors)

        git clone https://github.com/flazz/vim-colorschemes.git $tmpdir
        mv "${tmpdir}/colors" ~/.vim/colors
        rm -rf $tmpdir
    fi
}

create_vim_folder
install_pathogen
install_color_schemes

