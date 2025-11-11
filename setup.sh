#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Checking system ==="
if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman not found. This script supports Arch-based systems only."
  exit 1
fi

echo "=== Installing required packages ==="
sudo pacman -Syu --noconfirm \
  hyprland \
  xdg-desktop-portal-hyprland \
  kitty \
  terminus-font \
  ttf-terminus-nerd \
  thunar \
  thunar-archive-plugin \
  gvfs \
  file-roller \
  python \
  ufw \
  waybar \
  rofi-wayland \ 
  tmux \ 
  pavucontrol \
  network-manager-applet \
  nwg-look

echo "=== Enabling UFW firewall ==="
sudo ufw enable
sudo systemctl enable --now ufw.service

echo "=== Preparing directories ==="
mkdir -p "$HOME/.config"
sudo mkdir -p /usr/share/rofi/themes

move_dir() {
  src="$1"
  dst="$2"
  if [ ! -d "$src" ]; then
    echo "Warning: $src not found, skipping."
    return
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
    echo "Warning: $src not found, skipping."
    return
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
    echo "Warning: $src not found, skipping."
    return
  fi
  if [ -e "$dst" ]; then
    echo "Destination $dst already exists. Move or remove it first."
    exit 1
  fi
  sudo mkdir -p "$(dirname "$dst")"
  sudo mv "$src" "$dst"
  echo "Moved (root) $src -> $dst"
}

echo "=== Moving configuration files ==="

move_dir "$REPO_ROOT/.config/hypr" "$HOME/.config/hypr"
move_dir "$REPO_ROOT/.config/kitty" "$HOME/.config/kitty"
move_dir "$REPO_ROOT/.config/waybar" "$HOME/.config/waybar"

move_file_root "$REPO_ROOT/usr/share/rofi/themes/minimal.rasi" "/usr/share/rofi/themes/minimal.rasi"
move_file_root "$REPO_ROOT/usr/share/rofi/themes/white.rasi" "/usr/share/rofi/themes/white.rasi"

move_file "$REPO_ROOT/.tmux.conf" "$HOME/.tmux.conf"

echo "=== Setup complete ==="
echo "All packages installed and configurations moved successfully."
