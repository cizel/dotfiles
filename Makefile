init:
	brew install stow
	stow emacs
	stow vim
	stow tmux
	ln -sf `pwd`/tmux/.tmux/.tumx.conf ~/.tmux.conf
