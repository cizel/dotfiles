export ZINIT_PATH=~/.dotfiles
source $ZINIT_PATH/zinit/zinit.zsh

export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;

if [[ -v ZINIT[PLUGINS_DIR] ]]; then
	ZSH="${ZINIT[PLUGINS_DIR]}/ohmyzsh---ohmyzsh"
	typeset -g DISABLE_AUTO_UPDATE=true
	typeset -g ZSH_DISABLE_COMPFIX=true #optional

	zsh_custom_plugins=(
		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-autosuggestions
		ohmyzsh/ohmyzsh
		rupa/z
	)

	omz_plugins=(
		git
		tig
		brew
		tmux
		mvn
	)

  # Define a fake function to ignore OMZ compinit calls
  compinit() {}

  zinit nocompletions atinit'ZSH=$PWD;' \
	  for ohmyzsh/ohmyzsh

		  for p in $zsh_custom_plugins; do
			  zinit ice depth=1
			  zinit light $p
		  done

	# Load the theme.
	if [ "$(uname)" = 'Darwin' ]; then
		zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
		zinit light sindresorhus/pure
	else
		setopt promptsubst
		zinit snippet OMZT::robbyrussell
	fi

  # Could use local files for `OMZ::` at this point!
  for p in $omz_plugins; do
	  zinit snippet OMZ::plugins/$p/$p.plugin.zsh
  done

  # Load compinit and load the completions
  unfunction compinit
  autoload -Uz compinit
  compinit
  zinit cdreplay -q

fi


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
