#!/bin/bash

# Directories to stow
directories=(
    "alacritty"
    "bash"
    "fastfetch"
    "i3"
    "kitty"
    "moc"
    "picom"
    "qutebrowser"
    "ranger"
    "rofi"
    "rofi-theme"
    "theme"
    "tmux"
    "xresources"
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
