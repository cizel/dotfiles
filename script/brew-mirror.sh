#!/bin/bash

mirror_disable () {
  # Homebrew
  cd "$(brew --repo)"
  git remote set-url origin https://github.com/Homebrew/brew.git
  # Homebrew Core
  cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
  git remote set-url origin https://github.com/Homebrew/homebrew-core

  # Homebrew Cask
  cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
  git remote set-url origin https://github.com/Homebrew/homebrew-cask

  # Homebrew Bottles
  gsed -i 's/export\ HOMEBREW_BOTTLE_DOMAIN/#export\ HOMEBREW_BOTTLE_DOMAIN/g' ~/.exports
}

mirror_enable () {
  # Homebrew
  cd "$(brew --repo)"
  git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

  # Homebrew Core
  cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
  git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

  # Homebrew Cask
  cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
  git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

  # Homebrew Bottles
  gsed -i 's/#export\ HOMEBREW_BOTTLE_DOMAIN/export\ HOMEBREW_BOTTLE_DOMAIN/g' ~/.exports
}

if [[ "${1}" == 'disable' ]]; then
  mirror_disable
else
  mirror_enable
fi
