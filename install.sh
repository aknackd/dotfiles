#!/usr/bin/env bash

declare -a DEPENDENCIES=( curl stow git tmux )

check::dependencies () {
    for BIN in "${DEPENDENCIES[@]}"; do
        if ! command -v "$BIN" >/dev/null ; then
            >&2 echo "ERROR: Please install ${BIN} first before proceeding!"
            exit 1
        fi
    done
}

install::homebrew () {
    [[ $(uname -s) != "Darwin" ]] && return

    if ! command -v brew >/dev/null 2>&1 ; then
        echo ":: Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew analytics off
    fi
}

install::dotfiles () {
    echo ":: Linking dotfiles..."
    stow alacritty direnv git neovim ssh tmux vim zsh --target "$HOME" --verbose

    mkdir -p "$HOME/.ssh/sessions"
    mkdir -p "$HOME/.local/bin"

    stow bin --target "$HOME/.local/bin" --verbose

    case "$(uname -s)" in
        Linux)
            echo ":: Linking linux-specific dotfiles..."
            stow herbsluftwm i3 polybar xorg --target "$HOME" --verbose
            ;;
        Darwin)
            echo ":: Linking MacOS-specific dotfiles..."
            stow macOS --target "$HOME" --verbose
            ;;
    esac
}

setup::fzf () {
    if [ ! -d "$HOME/.fzf" ]; then
        echo ":: Setting up fzf..."
        git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install"
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

setup::tmux () {
    local tpmdir="$HOME/.tmux/plugins/tpm"

    if [ ! -d "$tpmdir" ]; then
        echo ":: Setting up tmux..."
        git clone https://github.com/tmux-plugins/tpm.git "$tpmdir"
    fi
}

setup::vim () {
    local confDir="$HOME/.config/vim"

    if [ ! -d "$confDir" ]; then
        echo ":: Setting up vim..."
        mkdir -p "$confDir" "$confDir/backup" "$confDir/temp"
    fi
}

check::dependencies
install::homebrew
install::dotfiles
setup::fzf
setup::neovim
setup::tmux
setup::vim

