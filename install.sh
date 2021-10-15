#!/usr/bin/env bash

declare -a DEPENDENCIES=( curl stow git tmux )

readonly COLOR_RED="$(echo -e "\033[0;31m")"
readonly COLOR_GREEN="$(echo -e "\033[0;32m")"
readonly COLOR_BLUE="$(echo -e "\033[0;34m")"
readonly COLOR_RESET="$(echo -e "\033[0;0m")"

check::dependencies () {
    for BIN in "${DEPENDENCIES[@]}"; do
        if ! command -v "$BIN" >/dev/null ; then
            >&2 echo "${COLOR_RED}ERROR${COLOR_RESET}: Please install ${COLOR_BLUE}${BIN}${COLOR_RESET} first before proceeding!"
            exit 1
        fi
    done
}

install::homebrew () {
    [[ $(uname -s) != "Darwin" ]] && return

    if ! command -v brew >/dev/null 2>&1 ; then
        echo "${COLOR_GREEN}:: Installing homebrew ...${COLOR_RESET}"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew analytics off
    fi
}

install::dotfiles () {
    echo "${COLOR_GREEN}:: Linking dotfiles ...${COLOR_RESET}"
    stow alacritty direnv git neovim tmux vim zsh --target "$HOME" --verbose

    mkdir -p "$HOME/.local/bin"
    stow bin --target "$HOME/.local/bin" --verbose

    # Setup ssh in home directory with the correct permissions to use
    # authorized_keys
    mkdir -p "$HOME/.ssh/sessions" "$HOME/.ssh/conf.d/home" "$HOME/.ssh/conf.d/work"
    # @@@ Don't update the timestamp if the file already exists
    touch "$HOME/.ssh/authorized_keys"
    chmod 0700 "$HOME/.ssh"
    chmod 0600 "$HOME/.ssh/authorized_keys"

    # And copy over the ssh config file(s) since some systems can have strict
    # permissions that won't allow symlinks to work
    cp -p ssh/.ssh/config "$HOME/.ssh/config"
    # @@@ Don't update the timestamp if the files already exist
    touch "$HOME/.ssh/conf.d/home/config" "$HOME/.ssh/conf.d/work/config"
    chmod 0600 "$HOME/.ssh/config" "$HOME/.ssh/conf.d/home/config" "$HOME/.ssh/conf.d/work/config"

    case "$(uname -s)" in
        Linux)
            echo "${COLOR_GREEN}:: Linking linux-specific dotfiles ...${COLOR_RESET}"
            stow herbstluftwm i3 polybar xorg --target "$HOME" --verbose
            ;;
        Darwin)
            echo "${COLOR_GREEN}:: Linking macOS-specific dotfiles ...${COLOR_RESET}"
            stow macOS --target "$HOME" --verbose
            ;;
    esac
}

setup::fzf () {
    if [ ! -d "$HOME/.fzf" ]; then
        echo "${COLOR_GREEN}:: Setting up fzf ...${COLOR_RESET}"
        git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install"
    fi
}

setup::neovim () {
    local vimplug="$HOME/.local/share/nvim/site/autoload/plug.vim"

    if [ ! -f "$vimplug" ]; then
        echo "${COLOR_GREEN}:: Setting up neovim ...${COLOR_RESET}"
        curl -fLso "$vimplug" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        nvim +PlugInstall +qall!
    fi
}

setup::tmux () {
    local tpmdir="$HOME/.tmux/plugins/tpm"

    if [ ! -d "$tpmdir" ]; then
        echo "${COLOR_GREEN}:: Setting up tmux ...${COLOR_RESET}"
        git clone https://github.com/tmux-plugins/tpm.git "$tpmdir"
    fi
}

setup::vim () {
    local confDir="$HOME/.config/vim"

    if [ ! -d "$confDir" ]; then
        echo "${COLOR_GREEN}:: Setting up vim ...${COLOR_RESET}"
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

