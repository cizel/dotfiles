# Locale and editor defaults.
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export MANPAGER='less -X'

# CLI defaults.
if [[ -t 1 ]]; then
  export GPG_TTY="$(tty)"
fi
export FEISHU_PROBE_CACHE_TTL_MINUTES=60
export FEISHU_PROBE_ERROR_CACHE_TTL_MINUTES=30

path=(
  "$HOME/.local/bin"
  "$HOME/.atuin/bin"
  "$HOME/.fzf/bin"
  "$HOME/.npm-global/bin"
  "$HOME/.composer/vendor/bin"
  "$HOME/workspace/go-code/bin"
  "$HOME/workspace/anti-code/bin"
  /usr/local/bin
  /usr/local/sbin
  $path
)
export PATH

export GOPATH="$HOME/workspace/go-code"
export GOBIN="$GOPATH/bin"
export GO111MODULE=on

[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"
