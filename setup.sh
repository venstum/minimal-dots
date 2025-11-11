#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config"
sudo mkdir -p /usr/share/rofi/themes

move_dir() {
  src="$1"
  dst="$2"
  if [ ! -d "$src" ]; then
    echo "Source directory $src not found"
    return 0
  fi
  if [ -e "$dst" ]; then
    echo "Destination $dst already exists. Move or remove it first."
    exit 1
  fi
  mkdir -p "$(dirname "$dst")"
  mv "$src" "$dst"
  echo "Moved $src -> $dst"
}

move_file() {
  src="$1"
  dst="$2"
  if [ ! -f "$src" ]; then
    echo "Source file $src not found"
    return 0
  fi
  if [ -e "$dst" ]; then
    echo "Destination $dst already exists. Move or remove it first."
    exit 1
  fi
  mkdir -p "$(dirname "$dst")"
  mv "$src" "$dst"
  echo "Moved $src -> $dst"
}

move_file_root() {
  src="$1"
  dst="$2"
  if [ ! -f "$src" ]; then
    echo "Source file $src not found"
    return 0
  fi
  if [ -e "$dst" ]; then
    echo "Destination $dst already exists. Move or remove it first."
    exit 1
  fi
  sudo mkdir -p "$(dirname "$dst")"
  sudo mv "$src" "$dst"
  echo "Moved (root) $src -> $dst"
}

move_dir "$REPO_ROOT/.config/hypr" "$HOME/.config/hypr"
move_dir "$REPO_ROOT/.config/kitty" "$HOME/.config/kitty"
move_dir "$REPO_ROOT/.config/waybar" "$HOME/.config/waybar"

move_file_root "$REPO_ROOT/usr/share/rofi/themes/minimal.rasi" "/usr/share/rofi/themes/minimal.rasi"
move_file_root "$REPO_ROOT/usr/share/rofi/themes/white.rasi" "/usr/share/rofi/themes/white.rasi"

move_file "$REPO_ROOT/.tmux.conf" "$HOME/.tmux.conf"

echo "setup.sh completed."
