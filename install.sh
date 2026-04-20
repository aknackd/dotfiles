#!/usr/bin/env bash

declare -a DEPENDENCIES=(curl git tmux stow)

COLOR_RED="$(echo -e "\033[0;31m")"
COLOR_GREEN="$(echo -e "\033[0;32m")"
COLOR_BLUE="$(echo -e "\033[0;34m")"
COLOR_RESET="$(echo -e "\033[0;0m")"

function check::dependencies() {
    for BIN in "${DEPENDENCIES[@]}"; do
        if ! command -v "$BIN" >/dev/null; then
            >&2 echo "${COLOR_RED}ERROR${COLOR_RESET}: Please install ${COLOR_BLUE}${BIN}${COLOR_RESET} first before proceeding!"
            exit 1
        fi
    done
}

function install::dotfiles() {
    echo "${COLOR_GREEN}:: Linking dotfiles ...${COLOR_RESET}"
    stow atuin ghostty git neovim opencode pi sqlite tmux zsh --target "$HOME" --verbose

    mkdir -pv "$HOME/.local/bin"
    stow bin --target "$HOME/.local/bin" --verbose

    # Setup ssh in home directory with the correct permissions to use
    # authorized_keys
    mkdir -p "$HOME/.ssh/sessions" "$HOME/.ssh/conf.d/home" "$HOME/.ssh/conf.d/work"
    touch "$HOME/.ssh/authorized_keys"
    chmod 0700 "$HOME/.ssh"
    chmod 0600 "$HOME/.ssh/authorized_keys"

    # And copy over the ssh config file(s) since some systems can have strict
    # permissions that won't allow symlinks to work
    [[ ! -f "$HOME/.ssh/config" ]] && cp -p ssh/.ssh/config "$HOME/.ssh/config"
    touch "$HOME/.ssh/conf.d/home/config" "$HOME/.ssh/conf.d/home/config"
    chmod 0600 "$HOME/.ssh/config" "$HOME/.ssh/conf.d/home/config" "$HOME/.ssh/conf.d/home/config"

    case "$(uname -s)" in
    Linux)
        echo "${COLOR_GREEN}:: Linking linux-specific dotfiles ...${COLOR_RESET}"
        stow herbstluftwm hyprland i3 polybar rofi sway waybar xorg --target "$HOME" --verbose
        ;;
    Darwin)
        echo "${COLOR_GREEN}:: Linking macOS-specific dotfiles ...${COLOR_RESET}"
        stow macOS --target "$HOME" --verbose
        ;;
    esac
}

function setup::fzf() {
    if [ ! -d "$HOME/.fzf" ]; then
        echo "${COLOR_GREEN}:: Setting up fzf ...${COLOR_RESET}"
        git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --bin --key-bindings --completion --no-update-rc
    fi
}

function setup::tmux() {
    local tpmdir="$HOME/.tmux/plugins/tpm"

    if [ ! -d "$tpmdir" ]; then
        echo "${COLOR_GREEN}:: Setting up tmux ...${COLOR_RESET}"
        git clone https://github.com/tmux-plugins/tpm.git "$tpmdir"
    fi
}

function install::sway_themes() {
    local confDir="$HOME/.config/sway/themes"

    if [ ! -d "$confDir" ]; then
        echo "${COLOR_GREEN}:: Setting up sway themes ...${COLOR_RESET}"
        git clone https://github.com/catppuccin/i3.git "$confDir/catppuccin"
    fi
}

check::dependencies
install::dotfiles
[[ "${SKIP_FZF:-n}" == "y" ]] || setup::fzf
[[ "${SKIP_TMUX:-n}" == "y" ]] || setup::tmux
[[ "${INSTALL_SWAY_THEMES:-n}" == "y" ]] && install::sway_themes
