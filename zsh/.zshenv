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
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export MYSQL_PS1="[\u@\h]\n(mysql::\d)> "
export BAT_STYLE="changes"
export BAT_THEME="Monokai Extended Bright"
export GOPATH="$HOME/go"
export ASDF_DIR="$HOME/.local/opt/asdf"
export ASDF_DATA_DIR="$ASDF_DIR"
export SDKMAN_DIR="$HOME/.config/sdkman"
export KOPIA_CHECK_FOR_UPDATES=false

export NVIM_BACKGROUND='dark'
export NVIM_COLORSCHEME='catppuccin'
export NVIM_DISABLE_ARROW_KEYS=true
export NVIM_FEATURE_LSP=true
export NVIM_LSP_SERVERS='lua_ls'
export NVIM_TRANSPARENT_BACKGROUND=true

export LSCOLORS=gxfxcxdxbxegedabagacad

if [[ -d "${HOME}/Library/Application Support/Herd/config/php" ]]; then
    for DIR in $(find $HOME/Library/Application\ Support/Herd/config/php -maxdepth 1 -type d ! -name php -print0 | xargs -0 basename); do
        export HERD_PHP_${DIR}_INI_SCAN_DIR="${HOME}/Library/Application Support/Herd/config/php/${DIR}/"
    done
fi

if [[ -f "$HOME/.zshenv.local" ]]; then
    source "$HOME/.zshenv.local"
fi
