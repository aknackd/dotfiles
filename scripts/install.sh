#!/usr/bin/env bash
#
# Installation script

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
readonly DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/.common.sh"

pushd src >/dev/null

# Symlink directories
log::info "===> Symlinking directories"
for FILE in $(find . -maxdepth 1 -type d ! -name .); do
    src="$(basename $FILE)"
    dest="${HOME}/"
    [[ "$src" == "bin" ]] || dest="${dest}."
    dest="${dest}${src}"

    if [[ -s "$dest" ]]; then
        # Destination exists but is already symlinked so skip
        log::warning "---> Skipping ${src} (dest is already linked)"
    elif [[ -d "$dest" && "$(find ${dest} | wc -l)" -gt 0 ]]; then
        # Directory exists and is NOT empty, skip
        log::warning "---> Skipping ${src} (dir not empty)"
    else
        # All good, symlink directory
        log::info "---> Linking ${BLUE}${DIR}/src/${SRC}${RESET} ${GREEN}to${RESET} ${BLUE}${dest}${RESET}"
        ln -nfs "${DIR}/src/${src}" "${dest}"
    fi
done

# Symlink files
log::info "===> Symlinking files"
find . -maxdepth 1 -type f -print0 | while read -d $'\0' FILE; do
    src="$(basename $FILE)"
    dest="${HOME}/.${src}"

    if [[ -s "$dest" ]]; then
        # File already exists and is a symlink, skip
        log::warning "---> Skipping ${src} (dest is already linked)"
    elif [[ -f "$dest" ]]; then
        # File exists, skip
        log::warning "---> Skipping ${src} (dir not empty)"
    else
        # All good, symlink file
        log::info "---> Linking ${BLUE}${DIR}/src/${SRC}${RESET} ${GREEN}to${RESET} ${BLUE}${dest}${RESET}"
        ln -nfs "${DIR}/src/${src}" "${dest}"
    fi
done

popd >/dev/null

# Run setup scripts
log::info "===> Running setup scripts"
EXCLUDES="! -name install.sh"
find ./scripts -type f -name '*.sh' \( $EXCLUDES \) -print0 | while read -d $'\0' FILE; do
    sh -c "'$FILE'"
done
