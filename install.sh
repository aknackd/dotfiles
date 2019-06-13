#!/usr/bin/env bash

declare -a DEPENDENCIES=( stow git tmux )


check::dependencies () {
    for BIN in "${DEPENDENCIES[@]}"; do
        command -v "$BIN" >/dev/null
        if [ $? -ne 0 ]; then
            >&2 echo "ERROR: Please install ${BIN} first before proceeding!"
            exit 1
        fi
    done
}

install::homebrew () {
    [[ $(uname -s) != "Darwin" ]] && return

    brew --version 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        echo ":: Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew analytics off
    fi
}

install::dotfiles () {
    echo ":: Linking dotfiles..."
    stow --target $HOME --verbose alacritty git neovim ssh tmux vim zsh

    mkdir -p $HOME/.ssh/sessions

    mkdir -p $HOME/.local/bin
    stow --target $HOME/.local/bin bin

    case "$(uname -s)" in
        Linux)
            echo ":: Linking linux-specific dotfiles..."
            stow --target $HOME --verbose xorg
            stow --target $HOME --verbose i3
            stow --target $HOME --verbose herbstluftwm
            stow --target $HOME --verbose termite
            ;;
        Darwin)
            echo ":: Linking MacOS-specific dotfiles..."
            stow --target $HOME --verbose macOS
            stow --target $HOME --verbose chunkwm
            ;;
    esac
}

setup::fzf () {
    if [ ! -d $HOME/.fzf ]; then
        echo ":: Setting up fzf..."
        git clone --depth=1 https://github.com/junegunn/fzf.git $HOME/.fzf
        $HOME/.fzf/install
    fi
}

setup::neovim () {
    if [ ! -d $HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim ]; then
        echo ":: Setting up neovim..."
        git clone https://github.com/Shougo/dein.vim.git $HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
        echo "-->"
        echo "--> Dein.vim plugin manager setup"
        echo "--> To complete the installation, open nvim and install dein:"
        echo "-->     :call dein#install()"
        echo "-->"
    fi
}

check::dependencies
install::homebrew
install::dotfiles
setup::fzf
setup::neovim
