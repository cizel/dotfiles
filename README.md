# cizel dotfiles

This repo now uses a modular Ubuntu-friendly shell setup:

- `zsh`
- `sheldon` for plugin management
- `starship` for the prompt
- `fzf`, `fd`, `bat`, `eza`, `zoxide` for CLI ergonomics
- `direnv` for per-project environment loading
- `atuin` for shell history
- `tmux`, `vim`, `git`, `Doom Emacs`

## Setup

Clone the repo and symlink the dotfiles:

```bash
git clone https://github.com/cizel/dotfiles ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap.sh --with-tools
```

`bootstrap.sh` backs up existing targets into
`$XDG_STATE_HOME/dotfiles-backups` (or `~/.local/state/dotfiles-backups`)
before replacing them.

The install script does not require Homebrew and does not write into system
directories. It installs the CLI tools into `~/.local/bin`, `~/.atuin/bin`, and
`~/.fzf/bin`.

If you only want symlinks and not the toolchain, run:

```bash
./script/bootstrap.sh
```

If you want to install tools later, run:

```bash
./script/install-shell-tools.sh
exec zsh
```

## Shell Layout

The shell config is split between compatibility entrypoints and modular config:

- [`~/.zshrc`](/home/cizel/.dotfiles/.zshrc): main interactive zsh entrypoint
- [`~/.aliases`](/home/cizel/.dotfiles/.aliases): compatibility shim that loads the new aliases module
- [`~/.exports`](/home/cizel/.dotfiles/.exports): compatibility shim that loads the new exports module
- [`~/.funcs`](/home/cizel/.dotfiles/.funcs): compatibility shim that loads the new functions module
- [`~/.config/zsh/aliases.zsh`](/home/cizel/.dotfiles/.config/zsh/aliases.zsh): aliases, including the old high-frequency git aliases like `gst` and `gco`
- [`~/.config/zsh/exports.zsh`](/home/cizel/.dotfiles/.config/zsh/exports.zsh): PATH and environment variables
- [`~/.config/zsh/functions.zsh`](/home/cizel/.dotfiles/.config/zsh/functions.zsh): shell functions such as `proxy_on`, `proxy_off`, and `ips`
- [`~/.config/zsh/history.zsh`](/home/cizel/.dotfiles/.config/zsh/history.zsh): history behavior
- [`~/.config/zsh/completion.zsh`](/home/cizel/.dotfiles/.config/zsh/completion.zsh): completion setup
- [`~/.config/zsh/tools.zsh`](/home/cizel/.dotfiles/.config/zsh/tools.zsh): tool-specific initialization
- [`~/.config/sheldon/plugins.toml`](/home/cizel/.dotfiles/.config/sheldon/plugins.toml): zsh plugin definitions
- [`~/.config/starship.toml`](/home/cizel/.dotfiles/.config/starship.toml): prompt styling

## Tooling

These are the new shell tools and why they exist:

- `sheldon`: small, explicit zsh plugin manager. Replaces the old `antigen` setup.
- `starship`: prompt renderer. Replaces the old `pure` theme and now controls prompt appearance.
- `zoxide`: smarter directory jumping. It replaces the old `z` plugin flow.
- `fzf`: fuzzy selection for history, files, and completions.
- `fd`: simpler and faster file search than `find` for common interactive use.
- `bat`: better file preview with syntax highlighting.
- `eza`: modern `ls` replacement with cleaner output.
- `direnv`: auto-loads project-local environment variables from `.envrc`.
- `atuin`: improved shell history and search.

## Prompt

The prompt is controlled by [`~/.config/starship.toml`](/home/cizel/.dotfiles/.config/starship.toml).
It is tuned to be closer to the old `pure` feel:

- two-line prompt
- directory first
- git branch and status next
- minimal host/user noise
- green `>` on success, red `>` on failure
- no Nerd Font dependency by default

## Secrets

Do not commit API keys into tracked dotfiles.

- Use `~/.secrets` for machine-local exports
- Use `direnv` for project-local variables
- Treat `gogcli`, `clawhub`, Atuin receipts, and user-level systemd enablement symlinks as machine-local state, not shared dotfiles

## Git Identity

Shared git behavior lives in [`~/.gitconfig`](/home/cizel/.dotfiles/.gitconfig).
Machine-specific identity and merge-tool settings belong in `~/.gitconfig.local`.
Use [`~/.gitconfig.local.example`](/home/cizel/.dotfiles/.gitconfig.local.example)
as the starting point.

## Scripts

- [`script/bootstrap.sh`](/home/cizel/.dotfiles/script/bootstrap.sh): symlink dotfiles into `$HOME`, optionally running the tool installer
- [`script/install-shell-tools.sh`](/home/cizel/.dotfiles/script/install-shell-tools.sh): install the new user-space shell toolchain on Ubuntu/Linux
- [`script/install.sh`](/home/cizel/.dotfiles/script/install.sh): deprecated legacy installer kept only as a pointer
