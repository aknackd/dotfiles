 EDITOR="nvim"
 VISUAL="$EDITOR"
 BROWSER="lynx"
 PAGER="less"
 TERM="xterm-256color"
 TERMINAL="urxvt"
 HISTCONTROL="ignoredups"
 HISTSIZE="1000000"
 HISTTIMEFORMAT="%F %T >> "
 XDG_CONFIG_HOME="$HOME/.config"
 DOTNET_CLI_TELEMETRY_OPTOUT=1
 ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
 MYSQL_PS1="[\u@\h]\n(mysql::\d)> "
 BAT_STYLE="changes"
 BAT_THEME="Monokai Extended Bright"

___paths=(
    /usr/local/share/npm/bin
    ${HOME}/.local/bin
    ${HOME}/bin
    /usr/local/sbin
    /usr/local/bin
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
 PATH
unset ___paths

 NVM_DIR="$HOME/.nvm"
 ASDF_DIR="$HOME/.asdf"

if [ "$(uname -s)" = "Darwin" ]; then
     LSCOLORS=gxfxcxdxbxegedabagacad
    brew list | grep '^node$' >/dev/null
    [ $? -eq 0 ] &&  PATH="$PATH:$(brew --prefix node)/bin"
fi

