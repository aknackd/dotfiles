#!/usr/bin/env bash
#
# Updates and builds the latest version of neovim from the git repository.
#
# Fetches the newest commits from the specified branch (default: master),
# builds and installs neovim, and removes all older neovim installs, leaving
# only the newly built version.
#
# Builds are installed in a directory (specified by $NVIM_PREFIX, defaults to
# /usr/local/Cellar/neovim) along with a symlink to the build named "latest" in
# the same build directory (similar to how Homebrew works).
#
# This script makes the following assumptions:
#
#     1. All build dependencies already installed (see https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)
#     2. The neovim git repo has already been cloned
#     3. The install directory has r/w access for the user running the script
#     4. A symlink to "$NVIM_PREFIX/latest" exists somewhere in your PATH (ex: /usr/local/bin/nvim)
#

SELF="$0"

# Colors
RED="$(echo -e "\033[0;31m")"
GREEN="$(echo -e "\033[0;32m")"
YELLOW="$(echo -e "\033[0;33m")"
RESET="$(echo -e "\033[0;0m")"

# Defaults
DEFAULT_NVIM_USE_NIGHTLY=0
DEFAULT_NVIM_BRANCH="master"
DEFAULT_NVIM_NICENESS="+15"
DEFAULT_NVIM_NUM_JOBS="$(nproc 2>/dev/null || sysctl -n hw.ncpu)"
DEFAULT_NVIM_PREFIX="/usr/local/Cellar/neovim"
DEFAULT_NVIM_SOURCE_DIR="/usr/local/src/neovim"
DEFAULT_NVIM_BUILD_TYPE="Release"

function log() {
    printf "[%s%s%s] %s%s%s\n" "$YELLOW" "$(date +'%Y-%m-%dT%H:%M:%S')" "$RESET" "$GREEN" "$1" "$RESET"
}

function error_log() {
    printf "[%s%s%s] %s%s%s\n" "$YELLOW" "$(date +'%Y-%m-%dT%H:%M:%S')" "$RESET" "$RED" "$1" "$RESET" 1>&2
}

function usage() {
    1>&2 printf "%s [OPTIONS]\n\n" "$(basename "$SELF")"
    1>&2 printf "Builds Neovim from source\n\n"
    1>&2 printf "OPTIONS\n"
    1>&2 printf "  -N, --nightly              Download and extract nightly build instead of building from source\n"
    1>&2 printf "  -b, --branch=BRANCH        Specify the neovim branch to build\n"
    1>&2 printf "  -j, --jobs=NUM             Allow NUM jobs at once (default: %d)\n" "$DEFAULT_NVIM_NUM_JOBS"
    1>&2 printf "  -n, --nice=NUM             Specify nice adjustment (default: %s)\n" "$DEFAULT_NVIM_NICENESS"
    1>&2 printf "  -p, --prefix=PATH          Directory prefix where neovim will be installed (default: %s)\n" "$DEFAULT_NVIM_PREFIX"
    1>&2 printf "  -s, --source=PATH          Directory path where neovim source is located (default: %s)\n" "$DEFAULT_NVIM_SOURCE_DIR"
    1>&2 printf "  -t, --type=TYPE            Specify build type to use for source builds (default: %s)\n" "$DEFAULT_NVIM_BUILD_TYPE"
    1>&2 printf "      --help                 Display this help text and exit\n"
    exit 1
}

# Transform long options into short options
for option in "$@"; do
    shift
    case "$option" in
        --nightly)     set -- "$@" "-N" ;;
        --branch)      set -- "$@" "-b" ;;
        --jobs)        set -- "$@" "-j" ;;
        --nice)        set -- "$@" "-n" ;;
        --prefix)      set -- "$@" "-p" ;;
        --source)      set -- "$@" "-s" ;;
        --type)        set -- "$@" "-t" ;;
        --help)        set -- "$@" "-h" ;;
        *)             set -- "$@" "$option" ;;
    esac
done

# Parse short options
OPTIND=1
while getopts ":b:c:j:n:p:s:t:h:N" option; do
    case "$option" in
        N) NVIM_USE_NIGHTLY=1         ;;
        b) NVIM_BRANCH="$OPTARG"      ;;
        j) NVIM_NUM_JOBS="$OPTARG"    ;;
        n) NVIM_NICENESS="$OPTARG"    ;;
        p) NVIM_PREFIX="$OPTARG"      ;;
        s) NVIM_SOURCE_DIR="$OPTARG"  ;;
        t) NVIM_BUILD_TYPE="$OPTARG"  ;;
        *) usage                      ;;
    esac
done

shift "$(expr $OPTIND - 1)"

# Merge options with defaults
NVIM_BRANCH="${NVIM_BRANCH:-${NVIM_BRANCH:-${DEFAULT_NVIM_BRANCH}}}"
NVIM_SOURCE_DIR="${NVIM_SOURCE_DIR:-${NVIM_SOURCE_DIR:-${DEFAULT_NVIM_SOURCE_DIR}}}"
NVIM_PREFIX="${NVIM_PREFIX:-${NVIM_PREFIX:-${DEFAULT_NVIM_PREFIX}}}"
NVIM_NICENESS="${NVIM_NICENESS:-${NVIM_NICENESS:-${DEFAULT_NVIM_NICENESS}}}"
NVIM_NUM_JOBS=$(( "${NVIM_NUM_JOBS:-${NVIM_NUM_JOBS:-${DEFAULT_NVIM_NUM_JOBS}}}" ))
NVIM_BUILD_TYPE="${NVIM_BUILD_TYPE:-${NVIM_BUILD_TYPE:-${DEFAULT_NVIM_BUILD_TYPE}}}"

# Validates build type
function validate_build_type() {
    if [[ "$NVIM_BUILD_TYPE" != "Release" && "$NVIM_BUILD_TYPE" != "RelWithDebIfo" && "$NVIM_BUILD_TYPE" != "Debug" ]]; then
        error_log "Invalid build type specified, must be \"Release\", \"RelWithDebInfo\", or \"Debug\""
        exit 1
    fi
}

# Download and extract the nightly prerelease build
function install_nightly() {
    local platform
    platform="$(uname -s)"

    local arch
    arch="$(uname -m)"
    if [[ "$arch" == "aarch64" ]]; then
        arch=arm64
    fi

    # neovim sadly only has arm64 nightly builds for macOS

    if [[ "$platform" != "Darwin" && "$arch" == "arm64" ]]; then
        log "${RED}NOTICE${GREEN}: Only x86_64 nightly builds are available for ${platform}"
        log "${RED}NOTICE${GREEN}: neovim only provides arm64 nightly prerelease builds for macOS (Apple Silicon)"
        exit 1
    fi

    local tarball_filename checksum_filename
    case "$platform" in
        Linux)
            tarball_filename=nvim-linux64.tar.gz
            checksum_filename=nvim-linux64.tar.gz.sha256sum
            ;;
        Darwin)
            tarball_filename="nvim-macos-${arch}.tar.gz"
            checksum_filename="nvim-macos-${arch}.tar.gz.sha256sum"
            ;;
        *)
            error_log "Invalid platform, must be either Linux or macOS"
            exit 1
            ;;
    esac

    local tarball_url checksum_url
    tarball_url="https://github.com/neovim/neovim/releases/download/nightly/${tarball_filename}"
    checksum_url="https://github.com/neovim/neovim/releases/download/nightly/${checksum_filename}"

    local tempdir temp_tarball_filename temp_checksum_filename
    tempdir="$(mktemp --suffix=.update-neovim --directory 2>/dev/null || mktemp -d -t update-neovim)"
    temp_tarball_filename="${tempdir}/${tarball_filename}"
    temp_checksum_filename="${tempdir}/${checksum_filename}"

    log "Downloading nightly prerelease build for ${platform} ..."
    curl --silent --location --fail --retry 3 --url "$tarball_url" --output "$temp_tarball_filename"

    log "Verifying checksum ..."
    curl --silent --location --fail --retry 3 --url "$checksum_url" --output "$temp_checksum_filename"

    pushd "$tempdir" >/dev/null

    if sha256sum --check "$temp_checksum_filename" 1>/dev/null ; then
        log "Checksum OK, extracting prerelease build ..."
        rm -rf "${NVIM_PREFIX}/nightly"
        mkdir -p "${NVIM_PREFIX}/nightly"
        tar xfz "$temp_tarball_filename" --directory="${NVIM_PREFIX}/nightly" --strip-components=1

        log "Creating symlink to point to nightly build ..."
        ln -nfs "${NVIM_PREFIX}/nightly" "${NVIM_PREFIX}/latest"
    else
        error_log "Checksum failed!"
    fi

    popd >/dev/null

    log "Cleaning up ..."
    rm -rf "$tempdir"
}

# Builds neovim from source (i.e. when --nightly isn't specified)
function build_from_source() {
    log "Validating options ..."
    validate_build_type

    make_cmd="make"
    if [[ "$(uname -s)" == "FreeBSD" ]]; then
        make_cmd="gmake"
    fi

    # TODO: Clone neovim if $NVIM_SOURCE_DIR doesn't exist

    if [[ ! -d "$NVIM_SOURCE_DIR" ]]; then
        log "Unable to find source directory $NVIM_SOURCE_DIR; exiting"
        exit 1
    fi

    log "Building neovim with the following configuration:"
    1>&2 printf "\n"
    1>&2 printf "    Build niceness:                        %s\n" "$NVIM_NICENESS"
    1>&2 printf "    Build prefix:                          %s\n" "$NVIM_PREFIX"
    1>&2 printf "    Build type:                            %s\n" "$NVIM_BUILD_TYPE"
    1>&2 printf "    Neovim source branch:                  %s\n" "$NVIM_BRANCH"
    1>&2 printf "    Neovim source directory:               %s\n" "$NVIM_SOURCE_DIR"
    1>&2 printf "    Number of parallel build jobs:         %d\n" "$NVIM_NUM_JOBS"
    1>&2 printf "\n"

    cd "$NVIM_SOURCE_DIR"

    log "Cleaning build directory ..."
    "$make_cmd" clean distclean

    log "Fetching the latest changes from the ${NVIM_BRANCH} branch ..."
    git fetch origin
    git merge "origin/${NVIM_BRANCH}"

    log "Showing the last 15 commits ..."
    git --git-dir="${NVIM_SOURCE_DIR}/.git" log --format="[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset" --max-count=15

    COMMIT="$(git rev-parse HEAD)"

    if [[ -f "${NVIM_PREFIX}/${COMMIT}/bin/nvim" ]]; then
        log "Commit ${COMMIT} has already been built, exiting"
        exit 0
    fi

    log "Building from commit ${COMMIT} ..."
    nice -n "$NVIM_NICENESS" "$make_cmd" -j "$NVIM_NUM_JOBS" \
        CMAKE_BUILD_TYPE="$NVIM_BUILD_TYPE" \
        CMAKE_INSTALL_PREFIX="${NVIM_PREFIX}/${COMMIT}" \
        install

    cd "$NVIM_PREFIX"

    log "Creating symlink to point to latest ..."
    ln -nfs "$COMMIT" latest

    log "Removing old neovim installs ..."
    find . -maxdepth 1 -type d \( ! -name "$COMMIT" -a ! -name . -a ! -name nightly \) -exec rm -rf {} \;
}

[[ "$NVIM_USE_NIGHTLY" == "1" ]] && install_nightly || build_from_source

if ! which nvim 1>/dev/null 2>/dev/null ; then
    error_log "nvim not found in \$PATH"
    error_log "Be sure to setup a symlink somewhere in your PATH that links to ${NVIM_PREFIX}/latest"
    exit 1
fi

log "Done!"
