#!/usr/bin/env bash
#
# Installation script

# colors
RESET='\033[;0m'
BLACK='\033[;30m'
RED='\033[0;31m'
GREEN='\033[;32m'
YELLOW='\033[;33m'
BLUE='\033[;34m'

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

cd "$DIR"

source "${DIR}/scripts/_common.sh"

pushd src >/dev/null

# Symlink directories
echo -e "${GREEN}==> Symlinking directories${RESET}"
for FILE in $(find . -maxdepth 1 -type d ! -name .); do
    src="$(basename $FILE)"
    dest="${HOME}/"
    [[ "$src" == "bin" ]] || dest="${dest}."
    dest="${dest}${src}"

    if [[ -s "$dest" ]]; then
        # Destination exists but is already symlinked so skip
        echo -e "${YELLOW}---> Skipping ${src} (dest is already linked)${RESET}"
    elif [[ -d "$dest" && "$(find ${dest} | wc -l)" -gt 0 ]]; then
        # Directory exists and is NOT empty, skip
        echo -e "${YELLOW}---> Skipping ${src} (dir not empty)${RESET}"
    else
        # All good, symlink directory
        echo -e "${YELLOW}---> Linking ${BLUE}${DIR}/src/${src}${RESET} to ${BLUE}${dest}${BLUE}"
        ln -nfs "${DIR}/src/${src}" "${dest}"
    fi
done

# Symlink files
echo -e "${GREEN}==> Symlinking files${RESET}"
find . -maxdepth 1 -type f -print0 | while read -d $'\0' FILE; do
    src="$(basename $FILE)"
    dest="${HOME}/.${src}"

    if [[ -s "$dest" ]]; then
        # File already exists and is a symlink, skip
        echo -e "${YELLOW}---> Skipping ${src} (dest is already linked)${RESET}"
    elif [[ -f "$dest" ]]; then
        # File exists, skip
        echo -e "${YELLOW}---> Skipping ${src} (exists)${RESET}"
    else
        # All good, symlink file
        echo -e "${YELLOW}---> Linking ${RESET}${DIR}/src/${src}${YELLOW} to ${RESET}${dest}"
        ln -nfs "${DIR}/src/${src}" "${dest}"
    fi
done

popd >/dev/null

# Run setup scripts
echo -e "${GREEN}==> Running setup scripts${RESET}"
EXCLUDES="! -name install.sh"
find ./scripts -type f -name '*.sh' \( $EXCLUDES \) -print0 | while read -d $'\0' FILE; do
    sh -c "'$FILE'"
done
