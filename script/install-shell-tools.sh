#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="${HOME}/.local/bin"
ATUIN_BIN_DIR="${HOME}/.atuin/bin"
FZF_DIR="${HOME}/.fzf"
FZF_VERSION="${FZF_VERSION:-0.70.0}"
PLATFORM="${PLATFORM:-$(uname -s)}"
ARCH="${ARCH:-$(uname -m)}"
FORCE_INSTALL=0

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

log() {
  printf '%s\n' "$*"
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

have_tool() {
  local cmd="$1"
  shift

  if (( FORCE_INSTALL )); then
    return 1
  fi

  if command -v "${cmd}" >/dev/null 2>&1; then
    return 0
  fi

  local path
  for path in "$@"; do
    [[ -x "${path}" ]] && return 0
  done

  return 1
}

install_if_missing() {
  local label="$1"
  local cmd="$2"
  shift 2

  local -a extra_paths=()
  while (($#)) && [[ "$1" != "--" ]]; do
    extra_paths+=("$1")
    shift
  done
  [[ "${1:-}" == "--" ]] && shift

  if have_tool "${cmd}" "${extra_paths[@]}"; then
    log "skip ${label}: already installed"
    return 0
  fi

  log "install ${label}"
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

install_bat() {
  local version="0.26.1"
  download_and_install_tarball \
    "https://github.com/sharkdp/bat/releases/download/v${version}/bat-v${version}-${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "bat-v${version}-${ARCH_ID}-${PLATFORM_ID}/bat" \
    "bat"
}

install_eza() {
  local version="0.23.4"
  download_and_install_tarball \
    "https://github.com/eza-community/eza/releases/download/v${version}/eza_${ARCH_ID}-${PLATFORM_ID}.tar.gz" \
    "eza" \
    "eza"
}

main() {
  parse_args "$@"
  require_supported_platform
  need_cmd curl || { echo "curl is required"; exit 1; }
  need_cmd tar || { echo "tar is required"; exit 1; }
  need_cmd git || { echo "git is required"; exit 1; }
  need_cmd python3 || { echo "python3 is required"; exit 1; }

  install_if_missing sheldon sheldon "${BIN_DIR}/sheldon" -- install_sheldon
  install_if_missing starship starship "${BIN_DIR}/starship" -- install_starship
  install_if_missing zoxide zoxide "${BIN_DIR}/zoxide" -- install_zoxide
  install_if_missing atuin atuin "${ATUIN_BIN_DIR}/atuin" "${BIN_DIR}/atuin" -- install_atuin
  install_if_missing direnv direnv "${BIN_DIR}/direnv" -- install_direnv
  install_if_missing fzf fzf "${FZF_DIR}/bin/fzf" "${BIN_DIR}/fzf" -- install_fzf
  install_if_missing fd fd "${BIN_DIR}/fd" -- install_fd
  install_if_missing bat bat "${BIN_DIR}/bat" -- install_bat
  install_if_missing eza eza "${BIN_DIR}/eza" -- install_eza

  cat <<EOF

Shell tools installed.

Make sure these are on PATH:
  ${BIN_DIR}
  ${ATUIN_BIN_DIR}
  ${FZF_DIR}/bin
EOF
}

main "$@"
