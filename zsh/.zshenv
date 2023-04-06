export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="lynx"
export PAGER="less"
export TERM="xterm-256color"
export TERMINAL="urxvt"
export HISTCONTROL="ignoredups"
export HISTSIZE="1000000"
export HISTTIMEFORMAT="%F %T >> "
export XDG_CONFIG_HOME="$HOME/.config"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_GOOGLE_ANALYTICS=1
export HOMEBREW_NO_ANALYTICS=1
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export MYSQL_PS1="[\u@\h]\n(mysql::\d)> "
export BAT_STYLE="changes"
export BAT_THEME="Monokai Extended Bright"
export N_PREFIX="$HOME/.config/n"
export GOPATH="$HOME/go"
export ASDF_DIR="$HOME/.config/asdf"
export ASDF_DATA_DIR="$ASDF_DIR"
export SDKMAN_DIR="$HOME/.config/sdkman"

export NVIM_COLORSCHEME='kristijanhusak/vim-hybrid-material:hybrid_reverse'
export NVIM_FEATURE_LSP=true
export NVIM_LSP_SERVERS='tsserver,lua_ls,bashls,html,jsonls,volar,yamlls'

# https://stackoverflow.com/a/17841619
implode () { local IFS="$1";  shift ; echo "$*" }

___paths=(
    ${HOME}/.local/bin
    ${HOME}/bin
    ${GOPATH}/bin
    /usr/local/sbin
    /usr/local/bin
    ${N_PREFIX}/bin
    ${HOME}/.yarn/bin
    ${HOME}/.config/yarn/global/node_modules/.bin
    ${HOME}/.fzf/bin
    ${HOME}/.composer/vendor/bin
    ${HOME}/.config/composer/vendor/bin
    ${HOME}/.config/yarn/global/bin
    ${ANDROID_SDK_ROOT}/emulator
    ${ANDROID_SDK_ROOT}/platform-tools
    ${ANDROID_SDK_ROOT}/tools/bin
)

export PATH="$(implode ":" ${___paths[@]}):$PATH"

unset ___paths

export LSCOLORS=gxfxcxdxbxegedabagacad

[ -f "$HOME/.zshenv.local" ] && . "$HOME/.zshenv.local"

