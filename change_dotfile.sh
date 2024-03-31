#!/bin/bash

# Define the base directory for GitHub dotfiles
GITHUB_DOTFILES_DIR=~/Documents/GitHub/dotfile

# Ensure the base directory exists
mkdir -p "$GITHUB_DOTFILES_DIR"

# Backup i3 configuration
rm -fr "$GITHUB_DOTFILES_DIR/i3"
cp -r ~/.config/i3 "$GITHUB_DOTFILES_DIR/i3"

# Backup moc configuration
rm -fr "$GITHUB_DOTFILES_DIR/moc"
cp -r ~/.moc "$GITHUB_DOTFILES_DIR/moc"

# Backup neofetch configuration
rm -fr "$GITHUB_DOTFILES_DIR/neofetch"
cp -r ~/.config/neofetch "$GITHUB_DOTFILES_DIR/neofetch"

# Backup ranger configuration
rm -fr "$GITHUB_DOTFILES_DIR/ranger"
cp -r ~/.config/ranger "$GITHUB_DOTFILES_DIR/ranger"

# Backup zathura configuration
rm -fr "$GITHUB_DOTFILES_DIR/zathura"
cp -r ~/.config/zathura "$GITHUB_DOTFILES_DIR/zathura"

echo "Backup completed."

