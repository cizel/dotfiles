export ZPLUG_PATH=~/.dotfiles
source $ZPLUG_PATH/zplug/init.zsh

# Load the oh-my-zsh's library.
zplug "ohmyzsh/ohmyzsh"

# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/git", from: "oh-my-zsh"

# extra bundle.
zplug "rupa/z"
zplug "tcnksm/docker-alias", use:zshrc
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

# Load the theme.
if [ "$(uname)" = 'Darwin' ]; then
    zplug mafredri/zsh-async
    zplug sindresorhus/pure
else
    zplug 'dracula/zsh', as:theme
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    #zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# exports
[[ -f ~/.exports ]] && source ~/.exports

# functions
[[ -f ~/.funcs ]] && source ~/.funcs

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
