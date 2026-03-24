#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="${HOME}/.local/bin"
ATUIN_BIN_DIR="${HOME}/.atuin/bin"
FZF_DIR="${HOME}/.fzf"
FZF_VERSION="${FZF_VERSION:-0.70.0}"
PLATFORM="${PLATFORM:-$(uname -s)}"
ARCH="${ARCH:-$(uname -m)}"

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
  require_supported_platform
  need_cmd curl || { echo "curl is required"; exit 1; }
  need_cmd tar || { echo "tar is required"; exit 1; }
  need_cmd git || { echo "git is required"; exit 1; }
  need_cmd python3 || { echo "python3 is required"; exit 1; }

  install_sheldon
  install_starship
  install_zoxide
  install_atuin
  install_direnv
  install_fzf
  install_fd
  install_bat
  install_eza

  cat <<EOF

Shell tools installed.

Make sure these are on PATH:
  ${BIN_DIR}
  ${ATUIN_BIN_DIR}
  ${FZF_DIR}/bin
EOF
}

main "$@"
