#!/usr/bin/env bash

set -euo pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"
BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"
INSTALL_TOOLS=0
SKIP_SUBMODULES=0

link_targets=(
  ".aliases"
  ".config"
  ".editorconfig"
  ".exports"
  ".funcs"
  ".gitattributes"
  ".gitconfig"
  ".gitignore"
  ".gitmodules"
  ".hammerspoon"
  ".ssh.config.example"
  ".tmux.conf"
  ".tmux.conf.local"
  ".vim"
  ".vimrc"
  ".zshrc"
)

log() {
  printf '%s\n' "$*"
}

warn() {
  printf 'warning: %s\n' "$*" >&2
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage: ./script/bootstrap.sh [--with-tools] [--skip-submodules]

  --with-tools      Run script/install-shell-tools.sh after symlinking dotfiles
  --skip-submodules Skip git submodule initialization
EOF
}

confirm() {
  local prompt="$1"
  local reply
  read -r -p "${prompt} [y/N] " reply
  [[ "${reply:-}" =~ ^[Yy]$ ]]
}

ensure_repo() {
  [[ -d "${DOTFILES_PATH}" ]] || die "dotfiles repo not found at ${DOTFILES_PATH}"
}

ensure_backup_dir() {
  mkdir -p "${BACKUP_DIR}"
}

backup_target() {
  local target="$1"
  local name
  name="$(basename "${target}")"
  ensure_backup_dir
  mv "${target}" "${BACKUP_DIR}/${name}"
  log "backed up ${target} -> ${BACKUP_DIR}/${name}"
}

link_target() {
  local rel="$1"
  local source="${DOTFILES_PATH}/${rel}"
  local target="${HOME}/${rel}"

  [[ -e "${source}" || -L "${source}" ]] || {
    warn "skipping missing source ${source}"
    return 0
  }

  if [[ -L "${target}" ]] && [[ "$(readlink "${target}")" == "${source}" ]]; then
    log "ok ${target} -> ${source}"
    return 0
  fi

  if [[ -e "${target}" || -L "${target}" ]]; then
    if confirm "${target} exists. Back it up and replace it?"; then
      backup_target "${target}"
    else
      warn "left existing target untouched: ${target}"
      return 0
    fi
  fi

  ln -s "${source}" "${target}"
  log "linked ${target} -> ${source}"
}

init_submodules() {
  if (( SKIP_SUBMODULES )); then
    return 0
  fi

  if [[ -f "${DOTFILES_PATH}/.gitmodules" ]] && command -v git >/dev/null 2>&1; then
    git -C "${DOTFILES_PATH}" submodule update --init --recursive .tmux
  fi
}

install_tools() {
  local installer="${DOTFILES_PATH}/script/install-shell-tools.sh"

  [[ -x "${installer}" ]] || die "tool installer is missing or not executable: ${installer}"
  "${installer}"
}

parse_args() {
  while (($#)); do
    case "$1" in
      --with-tools)
        INSTALL_TOOLS=1
        ;;
      --skip-submodules)
        SKIP_SUBMODULES=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "unknown argument: $1"
        ;;
    esac
    shift
  done
}

main() {
  parse_args "$@"
  ensure_repo
  init_submodules

  for rel in "${link_targets[@]}"; do
    link_target "${rel}"
  done

  if (( INSTALL_TOOLS )); then
    install_tools
  fi

  log "bootstrap complete"
}

main "$@"
