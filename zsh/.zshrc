#!/usr/bin/env zsh

if ! test -d $HOME/.antigen ; then
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

[ ! -d "$N_PREFIX" ] && mkdir -p "$N_PREFIX"

## Setup antigen
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle gitfast
antigen bundle git-extras
antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme aknackd/zsh-themes ramiel
antigen apply

## Helper functions

___am_i_installed() {
    command -v $1 >/dev/null 2>&1 && echo 1 || echo 0
}

___am_i_running() {
    ps -ef | grep "$(echo "$1" | perl -lape 's/^(.)/\[$1\]/')" 2>&1 >/dev/null && echo 1 || echo 0
}

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

# Startup ssh-agent if not already running
[ $(___am_i_running ssh-agent) -eq 0 ] && eval "$(ssh-agent -s)"

command -v nvim >/dev/null        && alias vim="TERM=screen-256color nvim"
command -v rg >/dev/null          && alias ack="rg"
command -v bat >/dev/null         && alias cat="bat"
command -v batcat >/dev/null      && alias cat="batcat"
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
            # Prefer GNU versions of coreutuils and other utilities
            alias ls="gls --color=auto --group-directories-first --quoting-style=literal"
            alias seq="gseq"
            alias wc="gwc"
            alias du="gdu"
            alias df="gdf"
            alias sed="gsed"
            alias tar="gtar"
        fi

        # Use ssh keys added to our keychain when on macOS
        ssh-add -A 2>/dev/null
        ;;

    Linux)
        alias ls='ls --color=auto --group-directories-first --quoting-style=literal'
        ;;
esac

alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"

alias gb="git branch"
alias gd="git diff"
alias gh="git log --format=\"[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset\""
alias gs="git status --short --branch --untracked-files --renames"
alias gsh="gs ; echo '-------------------- LAST 5 COMMITS --------------------' ; gh -5"
alias gsup="git standup"
alias gl="git log"
alias gc="git commit"
alias gco="git checkout"
alias ga="git add"
alias gm="git merge"
alias gp="git push"
alias gr="git rebase"
alias grm="git rm"
alias gfo="git fetch origin"
alias gpo="git push origin"
alias gfu="git fetch upstream"
alias gpu="git push upstream"
alias grup="git remote update --prune"
alias grs="git restore --staged"
alias gap="git add --patch"
alias gsp="git show --patch"

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

# crtl-w to delete a word backwards
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}

zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
bindkey \^U backward-kill-line

[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"

