#!/usr/bin/env bash

# Downloads and installs the latest [asdf](https://asdf-vm.com) release

readonly GITHUB_API_ACCEPT="application/vnd.github+json"
readonly GITHUB_API_VERSION="2022-11-28"
readonly OS_PLATFORM="$(uname -sm | sed 's| |-|' | tr '[[:upper:]]' '[[:lower:]]')"
readonly PREFIX="${PREFIX:-${ASDF_DATA_DIR:-$HOME/.local/opt/asdf}}"

install_dir="${PREFIX}/bin"

install_completions=0
verbose=0

readonly ASDF_BIN="${install_dir}/asdf"

while [[ $# > 0 ]]; do
    [[ "$1" == "--completions" ]] && install_completions=1
    [[ "$1" == "--verbose" ]] && verbose=1
    shift
done

function log() {
    local dry=" "
    [[ "$dry_run" == "1" ]] && dry=" [DRY] "

    1>&2 printf "[%s]%s%s\n" "$(date +'%Y-%m-%d %H:%M:%S')" "$dry" "$*"
}

function execute() {
    [[ "$verbose" == "1" ]] && log "[EXEC] "$@""
    "$@"
}

# Fetches latest asdf version from the GitHub API and returns its JSON response
function get_latest_release_json() {
    execute curl --location --silent \
        --header "Accept: $GITHUB_API_ACCEPT" \
        --header "X-GitHub-Api-Version: $GITHUB_API_VERSION" \
        --url https://api.github.com/repos/asdf-vm/asdf/releases/latest
}

# Extracts the latest release version from the GitHub API
# @param {string} json
function get_latest_release_version() {
    local json="$1"
    echo "$json" | jq -r '.name'
}

# Downloads a release for our platform
# @param {string} json
# @param {string} version
# @param {string} platform
function download_and_install_release() {
    local json="$1"
    local version="$2"
    local platform="$3"

    local expected_filename="asdf-${version}-${platform}.tar.gz"
    local download_url="$(echo "$json" | jq -r ".assets[] | select(.name == \"${expected_filename}\") | .url")"
    # @@@ Test with linux
    local download_dir="$(mktemp -d -t asdf-download)"
    local downloaded_filename="${download_dir}/${expected_filename}"

    log "Downloading asdf ${version} :: filename = ${expected_filename}"

    execute curl --location \
        --header "Accept: application/octet-stream" \
        --output "$downloaded_filename" \
        --url "$download_url"

    log "File downloaded to : ${downloaded_filename}"
    log "Extracting release to ${install_dir}"

    execute tar xfz "$downloaded_filename" -C "$install_dir"
    execute rm -rf "$download_dir"
}

# Installs zsh completions for asfd
function install_asdf_completions() {
    log "Installing zsh completions for zsh"

    [[ -d "${PREFIX}/completions" ]] && execute mkdir -p "${PREFIX}/completions"

    execute "$ASDF_BIN" completion zsh >"${PREFIX}/completions/_asdf"
}

function main() {
    if [[ ! -d "$install_dir" ]]; then
        log "Creating install directory :: ${install_dir}"
        execute mkdir -p "${install_dir}/shims"
    fi

    json="$(get_latest_release_json)"
    latest_version="$(get_latest_release_version "$json")"

    log "Latest version of asdf : ${latest_version}"

    # Bail if the latest version is already installed
    if command -v asdf >/dev/null; then
        our_version="$(asdf --version | awk '{ print $NF }')"
        if [[ "$our_version" == "$latest_version" ]]; then
            log "asdf ${latest_version} is already installed! exiting"
            exit 0
        fi
    fi

    download_and_install_release "$json" "$latest_version" "$OS_PLATFORM"

    [[ "$install_completions" == "1" ]] && install_asdf_completions
}

main
