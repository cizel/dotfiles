setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Keep autosuggestions on the history path only.
export ZSH_AUTOSUGGEST_STRATEGY=(history)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

if [[ -o interactive ]]; then
  bindkey -e

  if [[ -r /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
  elif [[ -r "$HOME/.fzf/shell/completion.zsh" ]]; then
    source "$HOME/.fzf/shell/completion.zsh"
  fi

  if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -r "$HOME/.fzf/shell/key-bindings.zsh" ]]; then
    source "$HOME/.fzf/shell/key-bindings.zsh"
  fi
fi

if [[ -r "$HOME/.openclaw/completions/openclaw.zsh" ]]; then
  source "$HOME/.openclaw/completions/openclaw.zsh"
fi

if [[ -r /etc/zsh_command_not_found ]]; then
  source /etc/zsh_command_not_found
fi
