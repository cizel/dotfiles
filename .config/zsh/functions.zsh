proxy_on() {
  export http_proxy='http://127.0.0.1:7890'
  export https_proxy='http://127.0.0.1:7890'
}

proxy_off() {
  unset http_proxy
  unset https_proxy
}

ips() {
  if command -v hostname >/dev/null 2>&1; then
    hostname -I 2>/dev/null | awk '{for (i = 1; i <= NF; i++) if ($i != "127.0.0.1") print $i}'
  fi
}

if [[ "$OSTYPE" == darwin* ]]; then
  which-package() {
    osascript -e "id of app \"$1\""
  }
fi
