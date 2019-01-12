#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names

# Install wget with IRI support
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --with-override-system-vi

# z hopping around folders
brew install z

# run this script when this file changes guy.
brew install entr

# github util. gotta love `hub fork`, `hub create`, `hub checkout <PRurl>`
brew install hub

# Install other useful binaries
brew install the_silver_searcher
brew install fzf

# System extra tools
brew install imagemagick --with-webp
brew install gcc
brew install cmake
brew install openssl
brew install automake
brew install htop
brew install nmap
brew install telnet
brew install trash
brew install rename
brew install tree
brew install ffmpeg

# Programing & Tools
brew install git
brew install node # This installs `npm` too using the recommended installation method
brew install ruby
brew install php
brew install go
brew install python
brew install python@2
brew install glide
brew install yarn

# useful tools
brew install tig
brew install ncdu # find where your diskspace went
brew install tldr
brew install bat
brew install privoxy
brew install proxychains-ng
brew install caddy
brew install hugo

# edit
brew install editorconfig
brew install global
brew install ctags
brew install fcitx-remote-for-osx # https://github.com/CodeFalling/fcitx-remote-for-osx
brew install reattach-to-user-namespace

brew install tmux

brew install zsh

# Remove outdated versions from the cellar
brew cleanup
