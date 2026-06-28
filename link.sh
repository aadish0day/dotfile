#!/bin/bash

if ! command -v stow &> /dev/null; then
    echo "stow not found. Attempting automatic installation..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y stow
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y stow
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm stow
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y stow
    elif command -v apk &> /dev/null; then
        sudo apk add stow
    elif command -v pkg &> /dev/null; then
        pkg install -y stow
    else
        echo "Error: GNU stow is not installed. Please install it manually."
        exit 1
    fi
fi

# Base directory for dotfiles
DOTFILES_DIR="$HOME/dotfile"

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit 1

# Stow all subdirectories, excluding metadata and non-stow folders
for dir in */; do
    dir=${dir%/}
    # Skip standard non-stowed directories
    if [[ "$dir" != "kde" && "$dir" != "output" ]]; then
        echo "Stowing $dir..."
        stow "$dir"
    fi
done

echo "Dotfiles linking completed!"
