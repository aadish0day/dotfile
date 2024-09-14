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
    "ranger"
    "rofi"
    "theme"
    "tmux"
    "zathura"
    "xfce4"
    "zsh"
)

# Base directory where your dotfiles are stored
DOTFILES_DIR="$HOME/.dotfiles"

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit

# Loop through each directory and stow it
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Stowing $dir..."
        stow --dotfiles --adopt "$dir"
    else
        echo "Directory $dir not found, skipping..."
    fi
done

echo "Dotfiles linking completed!"

