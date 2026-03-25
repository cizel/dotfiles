#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="${HOME}/.local/bin"
ATUIN_BIN_DIR="${HOME}/.atuin/bin"
FZF_DIR="${HOME}/.fzf"
FZF_VERSION="${FZF_VERSION:-0.70.0}"
PLATFORM="${PLATFORM:-$(uname -s)}"
ARCH="${ARCH:-$(uname -m)}"
FORCE_INSTALL=0
APT_UPDATED=0

case "${PLATFORM}" in
  Linux)
    PLATFORM_ID="unknown-linux-gnu"
    ;;
  *)
    PLATFORM_ID=""
    ;;
esac

case "${ARCH}" in
  x86_64|amd64)
    ARCH_ID="x86_64"
    ;;
  aarch64|arm64)
    ARCH_ID="aarch64"
    ;;
  *)
    ARCH_ID=""
    ;;
esac

mkdir -p "${BIN_DIR}"

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

have_apt() {
  command -v apt-get >/dev/null 2>&1 && command -v apt-cache >/dev/null 2>&1
}

log() {
  printf '%s\n' "$*"
}

ensure_link() {
  local target="$1"
  local source="$2"

  mkdir -p "$(dirname "${target}")"
  ln -sfn "${source}" "${target}"
}

download_and_install_tarball() {
  local url="$1"
  local binary_path="$2"
  local target_name="$3"
  local tmpdir

  tmpdir="$(mktemp -d)"
  trap 'rm -rf "${tmpdir}"' RETURN

  curl -fL "${url}" -o "${tmpdir}/archive.tar.gz"
  tar -xzf "${tmpdir}/archive.tar.gz" -C "${tmpdir}"
  install -m 755 "${tmpdir}/${binary_path}" "${BIN_DIR}/${target_name}"
}

require_supported_platform() {
  [[ "${PLATFORM}" == "Linux" ]] || die "install-shell-tools.sh currently supports Linux only"
  [[ -n "${ARCH_ID}" ]] || die "unsupported architecture: ${ARCH}"
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage: ./script/install-shell-tools.sh [--force]

  --force  Reinstall tools even if matching binaries already exist
EOF
}

parse_args() {
  while (($#)); do
    case "$1" in
      --force)
        FORCE_INSTALL=1
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

sudo_cmd() {
  if [[ "$(id -u)" -eq 0 ]]; then
    "$@"
  else
    sudo "$@"
  fi
}

have_tool() {
  local cmds_csv="$1"
  shift

  if (( FORCE_INSTALL )); then
    return 1
  fi

  local cmd
  for cmd in ${cmds_csv//,/ }; do
    if command -v "${cmd}" >/dev/null 2>&1; then
      return 0
    fi
  done

  local path
  for path in "$@"; do
    [[ -x "${path}" ]] && return 0
  done

  return 1
}

install_if_missing() {
  local label="$1"
  local cmds_csv="$2"
  shift 2

  local -a extra_paths=()
  while (($#)) && [[ "$1" != "--" ]]; do
    extra_paths+=("$1")
    shift
  done
  [[ "${1:-}" == "--" ]] && shift

  if have_tool "${cmds_csv}" "${extra_paths[@]}"; then
    log "skip ${label}: already installed"
    return 0
  fi

  log "install ${label}"
  "$@"
}

apt_package_available() {
  local package="$1"
  apt-cache show "${package}" >/dev/null 2>&1
}

apt_install_package() {
  local package="$1"

  if ! have_apt; then
    return 1
  fi

  if ! apt_package_available "${package}"; then
    return 1
  fi

  if (( ! APT_UPDATED )); then
    log "apt update"
    sudo_cmd apt-get update
    APT_UPDATED=1
  fi

  log "apt install ${package}"
  sudo_cmd apt-get install -y "${package}"
}

install_with_apt_fallback() {
  local label="$1"
  local cmds_csv="$2"
  local apt_package="$3"
  shift 3

  local -a extra_paths=()
  while (($#)) && [[ "$1" != "--" ]]; do
    extra_paths+=("$1")
    shift
  done
  [[ "${1:-}" == "--" ]] && shift

  if have_tool "${cmds_csv}" "${extra_paths[@]}"; then
    log "skip ${label}: already installed"
    return 0
  fi

  if apt_install_package "${apt_package}"; then
    return 0
  fi

  log "fallback install ${label}"
  "$@"
}

install_sheldon() {
  curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to "${BIN_DIR}"
}

install_starship() {
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "${BIN_DIR}"
}

install_zoxide() {
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh \
    | sh -s -- --bin-dir "${BIN_DIR}"
}

install_atuin() {
  curl --proto '=https' -fLsS https://setup.atuin.sh | bash
}

install_direnv() {
  export bin_path="${BIN_DIR}"
  curl -sfL https://direnv.net/install.sh | bash
}

install_fzf() {
  if [[ ! -d "${FZF_DIR}" ]]; then
    git clone --depth 1 --branch "${FZF_VERSION}" https://github.com/junegunn/fzf.git "${FZF_DIR}"
  fi

  "${FZF_DIR}/install" --bin --xdg --key-bindings --completion --no-update-rc
}

install_fd() {
  local version="10.4.2"
  download_and_install_tarball \
    "https://github.com/sharkdp/fd/releases/download/v${version}/fd-v${version}-${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "fd-v${version}-${ARCH_ID}-${PLATFORM_ID}/fd" \
    "fd"
}

post_install_fd() {
  if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    ensure_link "${BIN_DIR}/fd" "$(command -v fdfind)"
  fi
}

install_bat() {
  local version="0.26.1"
  download_and_install_tarball \
    "https://github.com/sharkdp/bat/releases/download/v${version}/bat-v${version}-${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "bat-v${version}-${ARCH_ID}-${PLATFORM_ID}/bat" \
    "bat"
}

post_install_bat() {
  if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    ensure_link "${BIN_DIR}/bat" "$(command -v batcat)"
  fi
}

install_eza() {
  local version="0.23.4"
  download_and_install_tarball \
    "https://github.com/eza-community/eza/releases/download/v${version}/eza_${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "eza" \
    "eza"
}

install_ripgrep() {
  local version="14.1.1"
  download_and_install_tarball \
    "https://github.com/BurntSushi/ripgrep/releases/download/${version}/ripgrep-${version}-${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "ripgrep-${version}-${ARCH_ID}-${PLATFORM_ID}/rg" \
    "rg"
}

install_tig() {
  if apt_install_package tig; then
    return 0
  fi

  die "tig is not available via apt on this system; install it manually"
}

main() {
  parse_args "$@"
  require_supported_platform
  need_cmd curl || { echo "curl is required"; exit 1; }
  need_cmd tar || { echo "tar is required"; exit 1; }
  need_cmd git || { echo "git is required"; exit 1; }
  need_cmd python3 || { echo "python3 is required"; exit 1; }

  install_if_missing sheldon sheldon "${BIN_DIR}/sheldon" -- install_sheldon
  install_with_apt_fallback starship starship starship "${BIN_DIR}/starship" -- install_starship
  install_with_apt_fallback zoxide zoxide zoxide "${BIN_DIR}/zoxide" -- install_zoxide
  install_with_apt_fallback atuin atuin atuin "${ATUIN_BIN_DIR}/atuin" "${BIN_DIR}/atuin" -- install_atuin
  install_with_apt_fallback direnv direnv direnv "${BIN_DIR}/direnv" -- install_direnv
  install_with_apt_fallback fzf fzf fzf "${FZF_DIR}/bin/fzf" "${BIN_DIR}/fzf" -- install_fzf
  install_with_apt_fallback fd "fd,fdfind" fd-find "${BIN_DIR}/fd" "${BIN_DIR}/fdfind" -- install_fd
  post_install_fd
  install_with_apt_fallback bat "bat,batcat" bat "${BIN_DIR}/bat" "${BIN_DIR}/batcat" -- install_bat
  post_install_bat
  install_with_apt_fallback eza "eza,exa" eza "${BIN_DIR}/eza" "${BIN_DIR}/exa" -- install_eza
  install_with_apt_fallback ripgrep "rg,ripgrep" ripgrep "${BIN_DIR}/rg" -- install_ripgrep
  install_if_missing tig tig "${BIN_DIR}/tig" -- install_tig

  cat <<EOF

Shell tools installed.

Make sure these are on PATH:
  ${BIN_DIR}
  ${ATUIN_BIN_DIR}
  ${FZF_DIR}/bin
EOF
}

main "$@"
