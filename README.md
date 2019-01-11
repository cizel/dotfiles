# cizel dotfiles 

- vim
- emacs (SpaceEmacs)
- tmux (Oh My Tmux)
- zsh (Oh My Zsh) 
- git

## Setup

```bash
git clone https://github.com/cizel/dotfiles ~/.dotfiles
cd ~/.dotfiles
chmod +x bootstrap.sh
sh bootstrap.sh
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

