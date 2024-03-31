#!/bin/bash

# Move the script to the user's home directory
cp bring_dotfile.sh ~/

# Define the base directory for dotfiles (assumes the current directory contains them)
DOTFILES_DIR=$(pwd)

# Create backup of the existing i3 config, if it exists
if [ -d ~/.config/i3 ]; then
    rm -rf ~/.config/i3.bak
    mv ~/.config/i3 ~/.config/i3.bak
fi

# Copy dotfiles to their respective locations
cp -r "$DOTFILES_DIR/i3/" ~/.config/
cp -r "$DOTFILES_DIR/moc/" ~/.moc/
cp -r "$DOTFILES_DIR/ranger/" ~/.config/
cp -r "$DOTFILES_DIR/neofetch/" ~/.config/
cp -r "$DOTFILES_DIR/zathura/" ~/.config/

echo "Dotfiles restoration/setup completed."

