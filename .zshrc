export ZDOTDIR="$HOME"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

typeset -U path fpath

[[ -f ~/.exports ]] && source ~/.exports
[[ -f ~/.aliases ]] && source ~/.aliases

for zsh_module in \
  "$XDG_CONFIG_HOME/zsh/history.zsh" \
  "$XDG_CONFIG_HOME/zsh/completion.zsh" \
  "$XDG_CONFIG_HOME/zsh/functions.zsh" \
  "$XDG_CONFIG_HOME/zsh/tools.zsh"
do
  [[ -f "$zsh_module" ]] && source "$zsh_module"
done

if [[ -o interactive ]] && command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if [[ -o interactive ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

[[ -r "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"
