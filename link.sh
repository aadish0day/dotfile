#!/bin/bash

# Ensure stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: GNU stow is not installed. Please install it manually."
    exit 1
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
