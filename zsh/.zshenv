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
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export MYSQL_PS1="[\u@\h]\n(mysql::\d)> "
export BAT_STYLE="changes"
export BAT_THEME="Monokai Extended Bright"
export N_PREFIX="$HOME/.n"

___paths=(
    /usr/local/share/npm/bin
    ${HOME}/.local/bin
    ${HOME}/bin
    /usr/local/sbin
    /usr/local/bin
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

for ___path in ${___paths[@]}; do
    test -d $___path && PATH="${___path}:${PATH}"
done
export PATH
unset ___paths

[ ! -d "$N_PREFIX" ] && mkdir -p

export LSCOLORS=gxfxcxdxbxegedabagacad

[ -f "$HOME/.zshenv.local" ] && . "$HOME/.zshenv.local"

