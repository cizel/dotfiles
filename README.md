# cizel dotfiles 

- vim
- emacs (Spacemacs)
- tmux (Oh My Tmux)
- zsh (Oh My Zsh) 
- git

## Setup

Run this:

```bash
git clone https://github.com/cizel/dotfiles ~/.dotfiles
cd ~/.dotfiles
script/bootstrap.sh
```

## Overview of Files

```
.
├── .gitattributes
├── .gitconfig
├── .gitignore
├── .spacemacs.d
│   ├── custom.el
│   ├── init.el
│   ├── layers
│   └── spacemacs.env
├── .tmux.conf
├── .tmux.conf.local
├── .vim
│   ├── autoload
│   ├── colors
│   ├── plugged
│   └── snippets
├── .vimrc
├── .vimrc_plugins
├── .zshrc
├── .zshrc.local.example
├── LICENSE
├── README.md
└── bootstrap.sh
```

