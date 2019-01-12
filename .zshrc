# Path to your oh-my-zsh installation.
export ANTIGEN_PATH=~/.dotfiles
source $ANTIGEN_PATH/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle z
antigen bundle tig
antigen bundle brew
antigen bundle brew-cask
antigen bundle tmux
antigen bundle docker
antigen bundle extract
antigen bundle command-not-found

# extra bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme cloud

# Tell Antigen that you're done.
antigen apply

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
