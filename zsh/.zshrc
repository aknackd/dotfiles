#!/usr/bin/env zsh

if ! test -d $HOME/.antigen ; then
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

## Setup antigen
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle gitfast
antigen bundle git-extras
antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme aknackd/zsh-themes ramiel
antigen apply

## Helper functions

___am_i_installed() {
    command -v $1 >/dev/null 2>&1 && echo 1 || echo 0
}

## Setup environment

[ -s "$NVM_DIR/nvm.sh" ]          && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
[ -s "$ASDF_DIR/asdf.sh" ]        && source "$ASDF_DIR/asdf.sh"

## Setup fzf
if [ -d $HOME/.fzf ]; then
    [[ $- == *i* ]] && source $HOME/.fzf/shell/completion.zsh 2> /dev/null
    source $HOME/.fzf/shell/key-bindings.zsh
fi

## Aliases

alias hostname="echo $(hostname | sed s/\.local$//)"
alias df="df -hT"
alias more="less -im"
alias mv="mv -i"
alias rm="rm -i"
alias rmdir="rm -r"
alias grep="grep -E --color=auto"
alias tmux="TERM=xterm-256color tmux"
alias screen="tmux"
alias art="php artisan"

# Avoid wierd errors when ssh'ing into remote servers that don't
# have 256 color support installed
alias ssh="TERM=xterm-color ssh"

command -v nvim >/dev/null        && alias vim="TERM=screen-256color nvim"
command -v rg >/dev/null          && alias ack="rg"
command -v rustup >/dev/null      && alias rup="rustup"
command -v bat >/dev/null         && alias cat="bat"
command -v dotnet >/dev/null      && alias dotnet="TERM=xterm dotnet"
command -v direnv >/dev/null 2>&1 && { eval "$(direnv hook zsh)" }

case "$(uname -s)" in
    Darwin)
        alias top='top -s 1 -ca -o cpu'
        alias lsmod=kextstat
        alias modprobe=kextload
        alias rmmod=kextunload
        alias crontab="VIM_CRONTAB=true crontab"
        alias zcat=gzcat

        test -f /usr/local/share/dotnet/dotnet && alias dotnet=/usr/local/share/dotnet/dotnet

        if [ $(___am_i_installed brew) -eq 1 ]; then
            ___HOMEBREW_PREFIX=$(brew --prefix)

            alias 7z="$___HOMEBREW_PREFIX/bin/7za"
            alias git="$___HOMEBREW_PREFIX/bin/git"

            # prefer GNU versions
            alias ls="${___HOMEBREW_PREFIX}/bin/gls --color=auto --group-directories-first --quoting-style=literal"
            alias seq="${___HOMEBREW_PREFIX}/bin/gseq"
            alias wc="${___HOMEBREW_PREFIX}/bin/gwc"
            alias du="${___HOMEBREW_PREFIX}/bin/gdu"
            alias df="${___HOMEBREW_PREFIX}/bin/gdf"
            alias sha1sum="${___HOMEBREW_PREFIX}/bin/gsha1sum"
            alias sha244sum="${___HOMEBREW_PREFIX}/bin/gsha244sum"
            alias sha256sum="${___HOMEBREW_PREFIX}/bin/gsha256sum"
            alias sha384sum="${___HOMEBREW_PREFIX}/bin/gsha384sum"
            alias sha512sum="${___HOMEBREW_PREFIX}/bin/gsha512sum"
            alias cal="$___HOMEBREW_PREFIX/bin/gcal"
            alias sed="$___HOMEBREW_PREFIX/bin/gsed"
            alias tar="$___HOMEBREW_PREFIX/bin/gtar"

            unset ___HOMEBREW_PREFIX
        fi
        ;;

    Linux)
        # ls: Group directories if ls has the capability
        man ls | col -bx | grep '\-\-group\-directories\-first' >/dev/null
        test $? && alias ls='ls --color=auto --group-directories-first --quoting-style=literal'
        ;;
esac

alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"

alias gb="git branch"
alias gd="git diff"
alias gs="git status"
alias gh="git log --format=\"[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset\""
alias gsup="git standup"
alias gl="git log"
alias gc="git commit"
alias gco="git checkout"
alias ga="git add"
alias gm="git merge"
alias gp="git push"
alias gr="git reset"
alias grm="git rm"
alias gfo="git fetch origin"
alias gpo="git push origin"
alias gfu="git fetch upstream"
alias gpu="git push upstream"
alias grup="git remote update --prune"

gmo () {
    if test $# -ne 1 ; then
        printf "Merge a branch from the \`origin\` remote into the current branch\n"
        printf "Usage: $0 BRANCH\n"
        return 1
    fi

    git merge origin/$1
}

gmu () {
    if test $# -ne 1 ; then
        printf "Merge a branch from the \`origin\` remote into the current branch\n"
        printf "Usage: $0 BRANCH\n"
        return 1
    fi

    git merge upstream/$1
}

whereami () {
    echo "${USER}@$(hostname | sed s/\.local$//):$(pwd)"
}
