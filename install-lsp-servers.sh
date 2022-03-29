#!/usr/bin/env bash

# Installs various langauge servers for use with Neovim LSP.

readonly COLOR_RED="$(echo -e "\033[0;31m")"
readonly COLOR_GREEN="$(echo -e "\033[0;32m")"
readonly COLOR_BLUE="$(echo -e "\033[0;34m")"
readonly COLOR_RESET="$(echo -e "\033[0;0m")"

check_dependency () {
    local BIN
    BIN="$1"

    if ! command -v "$BIN" >/dev/null ; then
        >&2 echo "${COLOR_RED}ERROR${COLOR_RESET}: Please install ${COLOR_BLUE}${BIN}${COLOR_RESET} first before proceeding!"
        exit 1
    fi
}

install_bashls () {
    if [[ "${SKIP_BASHLS}x" == "x" ]]; then
        echo "${COLOR_GREEN}:: Installing bash-language-server ...${COLOR_RESET}"
        check_dependency yarn
        yarn global add bash-language-server
    fi
}

install_intelephense () {
    if [[ "${SKIP_INTELEPHENSE}x" == "x" ]]; then
        echo "${COLOR_GREEN}:: Installing intelephense  ...${COLOR_RESET}"
        check_dependency yarn
        yarn global add intelephense
    fi
}

install_tsserver () {
    if [[ "${SKIP_TSSERVER}x" == "x" ]]; then
        echo "${COLOR_GREEN}:: Installing tsserver ...${COLOR_RESET}"
        check_dependency yarn
        yarn global add typescript typescript-language-server
    fi
}

check_dependencies
install_bashls
install_intelephense
install_tsserver
