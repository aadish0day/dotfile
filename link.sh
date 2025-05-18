#!/bin/bash

# Directories to stow
directories=(
    "alacritty"
    "aria2"
    "bash"
    "bspwm"
    "dunst"
    "fastfetch"
    "gammastep"
    "git"
    "gtk-theme"
    "hypr"
    "i3"
    "kitty"
    "moc"
    "paru"
    "picom"
    "polybar"
    "qalculate"
    "ranger"
    "rofi"
    "scripts"
    "sxhkd"
    "theme"
    "tmux"
    "waybar"
    "wezterm"
    "xdg-desktop-portal"
    "xresources"
    "yazi"
    "zathura"
    "zsh"
)

# Base directory for dotfiles
DOTFILES_DIR="$HOME/dotfile"

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit

# Stow each directory
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Stowing $dir..."
        # stow -R --override="*" "$dir"
        stow "$dir"
    else
        echo "Directory $dir not found, skipping..."
    fi
done

echo "Dotfiles linking completed!"
