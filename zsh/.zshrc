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

alias art="php artisan"
alias df="df -hT"
alias grep="grep -E --color=auto"
alias hostname="echo $(hostname | sed s/\.local$//)"
alias more="less -im"
alias mv="mv -i"
alias rm="rm -i"
alias rmdir="rm -r"
alias screen="tmux"
alias tmux="TERM=xterm-256color tmux"

# Avoid weird errors when ssh'ing into remote servers that don't have 256 color
# support installed
alias ssh="TERM=xterm-color ssh"

# Startup ssh-agent if not already running
[ $(___am_i_running ssh-agent) -eq 0 ] && eval "$(ssh-agent -s)"

command -v bat >/dev/null         && alias cat="bat"
command -v batcat >/dev/null      && alias cat="batcat"
command -v direnv >/dev/null 2>&1 && { eval "$(direnv hook zsh)" }
command -v dotnet >/dev/null      && alias dotnet="TERM=xterm dotnet"
command -v nvim >/dev/null        && alias nvim="TERM=screen-256color nvim"
command -v rg >/dev/null          && alias ack="rg"

case "$(uname -s)" in
    Darwin)
        alias crontab="VIM_CRONTAB=true crontab"
        alias lsmod=kextstat
        alias lsregister="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
        alias modprobe=kextload
        alias rmmod=kextunload
        alias top='top -s 1 -ca -o cpu'
        alias zcat=gzcat

        test -f /usr/local/share/dotnet/dotnet && alias dotnet=/usr/local/share/dotnet/dotnet

        if [ $(___am_i_installed brew) -eq 1 ]; then
            # Prefer GNU versions of coreutuils and other utilities
            alias date="gdate"
            alias df="gdf"
            alias du="gdu"
            alias ls="gls --color=auto --group-directories-first --quoting-style=literal"
            alias sed="gsed"
            alias seq="gseq"
            alias tar="gtar"
            alias wc="gwc"
        fi

        # Use ssh keys added to our keychain when on macOS
        ssh-add -A 2>/dev/null
        ;;

    FreeBSD)
        alias top='top -s 1 -o cpu'
        alias zcat=gzcat

        # Prefer GNU versions of coreutuils and other utilities
        if [ $(pkg query %n coreutils 2>/dev/null) ]; then
            alias date="gdate"
            alias df="gdf"
            alias du="gdu"
            alias ls="gls --color=auto --group-directories-first --quoting-style=literal"
            alias seq="gseq"
            alias wc="gwc"
        fi

        command -v gsed >/dev/null && alias sed="gsed"
        command -v gtar >/dev/null && alias tar="gtar"
        ;;

    Linux)
        alias ls='ls --color=auto --group-directories-first --quoting-style=literal'
        ;;
esac

alias ga="git add"
alias gap="git add --patch"
alias gar="git add --all ."
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gfo="git fetch origin"
alias gfu="git fetch upstream"
alias gh="git log --format=\"[%Cgreen %h %Creset] %aI %Cred %an %Creset %s%Cblue%d%Creset\""
alias gl="git log"
alias gm="git merge"
alias gp="git push"
alias gpo="git push origin"
alias gpu="git push upstream"
alias gr="git rebase"
alias grc="git rebase --continue"
alias grm="git rm"
alias grs="git restore --staged"
alias grup="git remote update --prune"
alias gs="git status --short --branch --untracked-files --renames"
alias gsp="git show --patch"
alias gsup="git standup"

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
        printf "Merge a branch from the \`upstream\` remote into the current branch\n"
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
