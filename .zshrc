# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="cloud"

plugins=(git z zsh-autosuggestions tig brew tmux zsh-syntax-highlighting git-open docker extract yarn)

source $ZSH/oh-my-zsh.sh

# User configuration
source ~/.zshrc.local

# vim as default
export EDITOR=vim

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/work/gopath/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/work/gopath/src/soa_tools:$PATH
export PATH=$HOME/private/bin:$PATH

# JAVA PATH
export JAVA_HOME=`/usr/libexec/java_home`

# GO Path
export GOPATH=~/work/gopath
export GOBIN=~/work/gopath/bin

# aliases
alias ss='export ALL_PROXY=http://127.0.0.1:8118'
alias uss='unset ALL_PROXY'

alias xmbash='docker exec -it website bash'
alias xm71bash='docker exec -it website71 bash'
alias cbash='docker exec -it centos zsh'
alias gpg_tty='export GPG_TTY=$(tty)'

# z autojump
/usr/local/etc/profile.d/z.sh
