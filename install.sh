#!/usr/bin/env bash

install::homebrew () {
    [[ $(uname -s) != "Darwin" ]] && return

    brew --version 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        printf ":: Installing homebrew...\n"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew analytics off
    fi

    printf ":: Installing formulae defined in Brewfile...\n"
    brew bundle
}

install::dotfiles () {
    printf ":: Linking dotfiles...\n"
    stow --target $HOME --verbose git ssh tmux vim zsh

    mkdir -p $HOME/.ssh/sessions

    mkdir -p $HOME/bin
    stow --target $HOME/bin bin

    if [[ $(uname -s) == "Linux" ]]; then
        printf ":: Linking linux-specific dotfiles...\n"
        stow --target $HOME --verbose xorg
	stow --target $HOME --verbose i3
    fi
}

install::homebrew
install::dotfiles
