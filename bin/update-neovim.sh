#!/usr/bin/env bash
#
# Updates and builds the latest version of neovim from the git repository.
#
# Fetches the newest commits from the specified branch (default: master),
# builds and installs neovim, and removes all older neovim installs, leaving
# only the newly built version.
#
# Builds are installed in a directory (specified by $NVIM_PREFIX, defaults
# to /usr/local/Cellar/neovim) along with a symlink to the build named "latest"
# in the same build directory (similar to how Homebrew works).
#
# Makes the following assumptions:
#
#     1. All build dependencies already installed (see https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)
#     2. The neovim git repo has already been cloned
#     3. A local.mk file already exists in the source directory
#     4. The install directory has r/w access for the user running the script
#     5. A symlink to "$NVIM_PREFIX/latest" exists somewhere in your PATH (ex: /usr/local/bin/nvim)
#
# Environment variables for customization:
#
#     | Name             | Description                                              | Default                       |
#     |:-----------------|:---------------------------------------------------------|:------------------------------|
#     | NVIM_BRANCH      | Branch to build                                          | master                        |
#     | NVIM_SOURCE_DIR  | Path to source directory                                 | $HOME/Workspace/neovim/neovim |
#     | NVIM_PREFIX      | Directory prefix where neovim will be installed          | /usr/local/Cellar/neovim      |
#     | NVIM_NUM_COMMITS | The last x commits to show after fetching latest commits | 15                            |
#     | NVIM_NUM_JOBS    | The number of jobs (commands) to run simultaneously      | `nproc`                       |
#

readonly GREEN="$(echo -e "\033[0;32m")"
readonly YELLOW="$(echo -e "\033[0;33m")"
readonly RESET="$(echo -e "\033[0;0m")"

function log() {
    printf "[%s%s%s] %s%s%s\n" $YELLOW $(date +'%Y-%m-%dT%H:%M:%S') $RESET $GREEN "$1" $RESET
}

readonly NVIM_BRANCH="${NVIM_BRANCH:-master}"
readonly NVIM_SOURCE_DIR="${NVIM_SOURCE_DIR:-${HOME}/Workspace/neovim/neovim}"
readonly NVIM_PREFIX="${NVIM_PREFIX:-/usr/local/Cellar/neovim}"
readonly NVIM_NUM_COMMITS="${NVIM_NUM_COMMITS:-15}"
readonly NVIM_NUM_JOBS="${NVIM_NUM_JOBS:-$(nproc 2>/dev/null || sysctl -n hw.ncpu)}"

make_cmd=make
if [[ "$(uname -s)" == "FreeBSD" ]]; then
    make_cmd="gmake"
fi

cd "$NVIM_SOURCE_DIR"

log "Cleaning build directory ..."
"$make_cmd" dist clean

log "Fetching the latest changes from the ${NVIM_BRANCH} branch ..."
git fetch origin
git merge origin/$NVIM_BRANCH

log "Showing the last ${NVIM_NUM_COMMITS} commits ..."
git --git-dir="${NVIM_SOURCE_DIR}/.git" log --format="[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset" --max-count=$NVIM_NUM_COMMITS

readonly COMMIT=$(git rev-parse HEAD)

if [[ -d "${NVIM_PREFIX}/${COMMIT}" ]]; then
    log "Commit ${COMMIT} has already been built, exiting"
    exit 0
fi

log "Building from commit ${COMMIT} ..."
nice -n +15 "$make_cmd" -j $NVIM_NUM_JOBS install

cd "$NVIM_PREFIX"

log "Creating symlink to point to latest ..."
ln -nfs $COMMIT latest

log "Removing old neovim installs ..."
find . -maxdepth 1 -type d \( ! -name $COMMIT -a ! -name . \) -type d -print0 | xargs -0 rm -rf

log "Printing newly built neovim version ..."
nvim --version | head -n 1

log "Done!"
log "Be sure to setup a symlink somewhere in your PATH that links to "${NVIM_PREFIX}/latest""
