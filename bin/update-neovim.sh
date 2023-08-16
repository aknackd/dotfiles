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
#     3. A local.mk file already exists in the source directory
#     4. The install directory has r/w access for the user running the script
#     5. A symlink to "$NVIM_PREFIX/latest" exists somewhere in your PATH (ex: /usr/local/bin/nvim)
#

SELF="$0"

# Colors
GREEN="$(echo -e "\033[0;32m")"
YELLOW="$(echo -e "\033[0;33m")"
RESET="$(echo -e "\033[0;0m")"

# Defaults
DEFAULT_NVIM_BRANCH="master"
DEFAULT_NVIM_NICENESS="+15"
DEFAULT_NVIM_NUM_COMMITS=15
DEFAULT_NVIM_NUM_JOBS="$(nproc 2>/dev/null || sysctl -n hw.ncpu)"
DEFAULT_NVIM_PREFIX="/usr/local/Cellar/neovim"
DEFAULT_NVIM_SOURCE_DIR="/usr/local/src/neovim"

function log() {
    printf "[%s%s%s] %s%s%s\n" "$YELLOW" "$(date +'%Y-%m-%dT%H:%M:%S')" "$RESET" "$GREEN" "$1" "$RESET"
}

function error_log() {
    printf "[%s%s%s] %s%s%s\n" "$YELLOW" "$(date +'%Y-%m-%dT%H:%M:%S')" "$RESET" "$GREEN" "$1" "$RESET" 1>&2
}

function usage() {
    1>&2 printf "%s [OPTIONS]\n\n" "$(basename "$SELF")"
    1>&2 printf "Builds Neovim from source\n\n"
    1>&2 printf "OPTIONS\n"
    1>&2 printf "  -b, --branch=BRANCH        Specify the neovim branch to build\n"
    1>&2 printf "  -c, --num-commits=NUM      Specify the last NUM commits to show after fetching neovim updates\n"
    1>&2 printf "  -j, --jobs=NUM             Allow NUM jobs at once (default: %d)\n" "$DEFAULT_NVIM_NUM_JOBS"
    1>&2 printf "  -n, --nice=NUM             Specify nice adjustment (default: %s)\n" "$DEFAULT_NVIM_NICENESS"
    1>&2 printf "  -p, --prefix=PATH          Directory prefix where neovim will be installed (default: %s)\n" "$DEFAULT_NVIM_PREFIX"
    1>&2 printf "  -s, --source=PATH          Directory path where neovim source is located (default: %s)\n" "$DEFAULT_NVIM_SOURCE_DIR"
    1>&2 printf "      --help                 Display this help text and exit\n"
    exit 1
}

ARGS=$(getopt -o b:c:j:n:p:s: --long branch:,num-commits:,nice:,jobs:,prefix:,source:,help -- "$@")
eval set -- "$ARGS"

while [ : ]; do
    case "$1" in
        -b | --branch)      NVIM_BRANCH="$2"      ; shift 2 ;;
        -c | --num-commits) NVIM_NUM_COMMITS="$2" ; shift 2 ;;
        -j | --jobs)        NVIM_NUM_JOBS="$2"    ; shift 2 ;;
        -n | --nice)        NVIM_NICENESS="$2"    ; shift 2 ;;
        -p | --prefix)      NVIM_PREFIX="$2"      ; shift 2 ;;
        -s | --source)      NVIM_SOURCE_DIR="$2"  ; shift 2 ;;
        --help)             usage ;;
        --) shift ; break ;;
    esac
done

NVIM_BRANCH="${NVIM_BRANCH:-${NVIM_BRANCH:-${DEFAULT_NVIM_BRANCH}}}"
NVIM_SOURCE_DIR="${NVIM_SOURCE_DIR:-${NVIM_SOURCE_DIR:-${DEFAULT_NVIM_SOURCE_DIR}}}"
NVIM_PREFIX="${NVIM_PREFIX:-${NVIM_PREFIX:-${DEFAULT_NVIM_PREFIX}}}"
# TODO: Parse to int
NVIM_NUM_COMMITS="${NVIM_NUM_COMMITS:-${NVIM_NUM_COMMITS:-${DEFAULT_NVIM_NUM_COMMITS}}}"
# TODO: Parse to int
NVIM_NICENESS="${NVIM_NICENESS:-${NVIM_NICENESS:-${DEFAULT_NVIM_NICENESS}}}"
# TODO: Parse to int
NVIM_NUM_JOBS="${NVIM_NUM_JOBS:-${NVIM_NUM_JOBS:-${DEFAULT_NVIM_NUM_JOBS}}}"

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
1>&2 printf "    Neovim source branch:                  %s\n" "$NVIM_BRANCH"
1>&2 printf "    Neovim source directory:               %s\n" "$NVIM_SOURCE_DIR"
1>&2 printf "    Number of parallel build jobs:         %d\n" "$NVIM_NUM_JOBS"
1>&2 printf "    Number of recent commits to display:   %d\n" "$NVIM_NUM_COMMITS"
1>&2 printf "\n"

cd "$NVIM_SOURCE_DIR"

log "Cleaning build directory ..."
"$make_cmd" clean distclean

log "Fetching the latest changes from the ${NVIM_BRANCH} branch ..."
git fetch origin
git merge "origin/${NVIM_BRANCH}"

log "Showing the last ${NVIM_NUM_COMMITS} commits ..."
git --git-dir="${NVIM_SOURCE_DIR}/.git" log --format="[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset" --max-count="$NVIM_NUM_COMMITS"

COMMIT="$(git rev-parse HEAD)"

if [[ -f "${NVIM_PREFIX}/${COMMIT}/bin/nvim" ]]; then
    log "Commit ${COMMIT} has already been built, exiting"
    exit 0
fi

log "Building from commit ${COMMIT} ..."
nice -n "$NVIM_NICENESS" "$make_cmd" -j "$NVIM_NUM_JOBS" install

cd "$NVIM_PREFIX"

log "Creating symlink to point to latest ..."
ln -nfs "$COMMIT" latest

log "Removing old neovim installs ..."
find . -maxdepth 1 -type d \( ! -name "$COMMIT" -a ! -name . \) -exec rm -rf {} \;

if which nvim 2>/dev/null ; then
    log "Printing newly built neovim version ..."
    nvim --version | head -n 1
else
    error_log "nvim not found in \$PATH"
    error_log "Be sure to setup a symlink somewhere in your PATH that links to ${NVIM_PREFIX}/latest"
    exit 1
fi

log "Done!"
