setopt promptsubst

export ZINIT_PATH=~/.dotfiles
source $ZINIT_PATH/zinit/zinit.zsh

export http_proxy=http://127.0.0.1:1087; \
    export https_proxy=http://127.0.0.1:1087;

zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "rupa/z"
zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv

# Load the theme.
if [ "$(uname)" = 'Darwin' ]; then
    zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
    zinit light sindresorhus/pure
else
    zinit snippet OMZT::robbyrussell
fi

# Could use local files for `OMZ::` at this point!
zinit snippet OMZL::git.zsh
zinit snippet OMZL::cli.zsh
zinit snippet OMZP::git
zinit snippet OMZP::svn
zinit snippet OMZP::tig
zinit snippet OMZP::brew
zinit snippet OMZP::tmux
zinit snippet OMZP::mvn

# Load compinit and load the completions
#unfunction compinit
#autoload -Uz compinit
#compinit
#zinit cdreplay -q


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

unset http_proxy; 
unset https_proxy;
