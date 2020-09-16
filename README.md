# cizel dotfiles 

- vim
- emacs (Doom emacs)
- tmux (Oh My Tmux)
- zsh (Oh My Zsh) 
- git

## Setup

Run this:

```bash
git clone https://github.com/cizel/dotfiles ~/.dotfiles
cd ~/.dotfiles
script/bootstrap.sh
# or without vim and emacs
script/bootstrap-basic.sh
```

## Overview of Files

```
.
├── .aliases
├── .doom.d
│   ├── config.el
│   ├── init.el
│   └── packages.el
├── .editorconfig
├── .exports
├── .gitattributes
├── .gitconfig
├── .gitignore
├── .gitmodules
├── .ssh.config.example
├── .tmux
│   ├── .tmux.conf
│   ├── .tmux.conf.local
│   ├── LICENSE.MIT
│   ├── LICENSE.WTFPLv2
│   └── README.md
├── .tmux.conf
├── .tmux.conf.local
├── .vim
│   ├── .netrwhist
│   ├── autoload
│   ├── backup
│   ├── colors
│   ├── plugged
│   ├── plugins.vim
│   ├── snippets
│   ├── swap
│   └── undo
├── .vimrc
├── .zshrc
├── README.md
└── script
    ├── bootstrap-basic.sh
    ├── bootstrap.sh
    ├── brew-cask.sh
    ├── brew-mirror.sh
    ├── brew.sh
    └── install.sh
```
