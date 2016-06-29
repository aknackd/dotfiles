
# colors
RESET='\033[;0m'
BLACK='\033[;30m'
RED='\033[0;31m'
GREEN='\033[;32m'
YELLOW='\033[;33m'
BLUE='\033[;34m'

log::info() {
    [[ -z $1 ]] && return
    echo -e "${GREEN}${1}${RESET}"
}

log::warning() {
    [[ -z $1 ]] && return
    echo -e "${YELLOW}${1}${RESET}"
}

log::error() {
    [[ -z $1 ]] && return
    echo -e "${RED}${1}${RESET}"
}
