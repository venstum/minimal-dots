#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman not found. This script supports Arch-based systems only."
  exit 1
fi

sudo pacman -Syu --noconfirm \
  hyprland \
  rofi-wayland \
  waybar \
  xdg-desktop-portal-hyprland \
  kitty \
  terminus-font \
  ttf-terminus-nerd \
  thunar \
  thunar-archive-plugin \
  gvfs \
  file-roller \
  python \
  ufw

sudo ufw enable
sudo systemctl enable --now ufw.service

echo "All required packages installed and UFW enabled."
