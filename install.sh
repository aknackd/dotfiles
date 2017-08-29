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
    stow --target $HOME --verbose git neovim ssh tmux vim zsh

    mkdir -p $HOME/.ssh/sessions

    mkdir -p $HOME/bin
    stow --target $HOME/bin bin

    case "$(uname -s)" in
        Linux)
            printf ":: Linking linux-specific dotfiles...\n"
            stow --target $HOME --verbose xorg
            stow --target $HOME --verbose i3
            ;;
        Darwin)
            printf ":: Linking MacOS-specific dotfiles...\n"
            stow --target $HOME --verbose macOS
            stow --target $HOME --verbose chunkwm
            ;;
    esac
}

install::homebrew
install::dotfiles