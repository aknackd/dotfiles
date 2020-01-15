#!/usr/bin/env bash

declare -a DEPENDENCIES=( curl stow git tmux )


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

    command -v brew 2>&1 >/dev/null
    if [ $? -ne 0 ]; then
        echo ":: Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew analytics off
    fi
}

install::dotfiles () {
    echo ":: Linking dotfiles..."
    stow --target $HOME --verbose alacritty direnv git neovim ssh tmux vim zsh

    mkdir -p $HOME/.ssh/sessions

    mkdir -p $HOME/.local/bin
    stow --target $HOME/.local/bin --verbose bin

    case "$(uname -s)" in
        Linux)
            echo ":: Linking linux-specific dotfiles..."
            stow --target $HOME --verbose xorg
            stow --target $HOME --verbose i3
            stow --target $HOME --verbose herbstluftwm
            stow --target $HOME --verbose polybar
            stow --target $HOME --verbose termite
            ;;
        Darwin)
            echo ":: Linking MacOS-specific dotfiles..."
            stow --target $HOME --verbose macOS
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
    local vimplug="$HOME/.local/share/nvim/site/autoload/plug.vim"

    if [ ! -f "$vimplug" ]; then
        echo ":: Setting up neovim..."
        curl -fLso "$vimplug" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim +PlugInstall +qall!
    fi
}

check::dependencies
install::homebrew
install::dotfiles
setup::fzf
setup::neovim
