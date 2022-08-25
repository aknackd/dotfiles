#!/usr/bin/env bash

# Installs various langauge servers for use with Neovim LSP.

readonly COLOR_RED="$(echo -e "\033[0;31m")"
readonly COLOR_GREEN="$(echo -e "\033[0;32m")"
readonly COLOR_BLUE="$(echo -e "\033[0;34m")"
readonly COLOR_YELLOW=$(echo -e "\033[0;33m")
readonly COLOR_RESET="$(echo -e "\033[0;0m")"

if ! command -v yarn >/dev/null ; then
    >&2 echo "${COLOR_RED}ERROR${COLOR_RESET}: Please install ${COLOR_BLUE}yarn${COLOR_RESET} first before proceeding!"
fi

declare -A SERVERS
readonly SERVERS=(
    [bash]="bash-language-server@^3.1.0"
    [php]="intelephense@^1.8.2"
    [typescript]="typescript typescript-language-server@^1.1.1"
)

# Write a message in a particular color
#
# @param {string} color
# @param {string} message
function chalk () {
    readonly color="$(printf "COLOR_%s" "${1^^}")"
    readonly message="$2"

    if [ "$NOCOLOR" = "1" ]; then
        echo "$message"
    else
        echo -e "${!color}${message}${COLOR_RESET}"
    fi
}

# Prints the current datetime in ISO-8601 format
function now () {
    echo -n "$(date +"%Y-%m-%d %H:%M:%S%z")"
}

# Log an informational message
function log_info () {
    printf "%s %s\n" "$(chalk yellow "[$(now)]")" "$(chalk green "$1")"
}

for KEY in "${!SERVERS[@]}"; do
    log_info "Installing lsp servers for $(chalk blue "$KEY")"
    echo "yarn global add ${SERVERS[$KEY]}"
done
