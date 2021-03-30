#!/bin/zsh

#  inspired by R0boter/ArchlinuxInstall

function cfg_gpu() {
  sudo pacman -S mesa
}

function cfg_sway() {
  sudo pacman -S sway alacritty wofi waybar
}

function cfg_fonts() {
  sudo pacman -S fontconfig ttf-dejavu noto-fonts noto-fonts-cjk notot-fonts-emoji ttf-awesome --noconfirm
}

function cfg_tools() { 
  sudo pacman -S base-devel go kitty firefox-developer-edition ripgrep starship lolcat ctags --noconfirm
}

cfg_gpu
cfg_fonts
cfg_sway
cfg_tools
