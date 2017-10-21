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
            stow --target $HOME --verbose herbstluftwm
            stow --target $HOME --verbose termite
            ;;
        Darwin)
            printf ":: Linking MacOS-specific dotfiles...\n"
            stow --target $HOME --verbose macOS
            stow --target $HOME --verbose chunkwm
            ;;
    esac
}

setup::neovim () {
    if which nvim 1>/dev/null 2>/dev/null -eq 0; then
        if [ ! -d $HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim ]; then
            printf ":: Setting up neovim...\n"
            git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
            printf "-->\n"
            printf "--> Dein.vim plugin manager setup\n"
            printf "--> To complete the installation, open nvim and install dein:\n"
            printf "-->     :call dein#install()\n"
            printf "-->\n"
        fi
    fi
}

install::homebrew
install::dotfiles
setup::neovim
