#!/bin/bash

cp bring_dotfile.sh ~/

# Define base directories for dotfiles and .config
DOTFILES_DIR=$(pwd) # Assumes the current directory contains the dotfiles
CONFIG_DIR=~/.config

# Ensure the .config directory exists
mkdir -p "$CONFIG_DIR"

# Declare an associative array for managing the directories
# Format is ["destination_subdir"]="source_subdir"
declare -A directories=(
    ["$CONFIG_DIR/i3.bak"]="$CONFIG_DIR/i3"
    ["$CONFIG_DIR/i3"]="i3/"
    ["~/.moc/"]="moc/"
    ["$CONFIG_DIR/ranger"]="ranger/"
    ["$CONFIG_DIR/neofetch"]="neofetch/"
    ["$CONFIG_DIR/zathura"]="zathura/"
)

# Loop through the directories and apply operations
for dest in "${!directories[@]}"; do
    src="${directories[$dest]}"
    if [[ $dest == *".bak" ]]; then
        # For backup operation
        if [ -d "$dest" ]; then
            rm -rf "$dest" # Remove the existing backup
        fi
        if [ -d "${dest%.*}" ]; then # Removes the .bak extension for checking
            mv "${dest%.*}" "$dest" # Backup the original directory
        fi
    else
        # Standard copy operation
        mkdir -p "$dest" # Ensure the destination directory exists
        cp -r "$DOTFILES_DIR/$src" "$dest" # Copy files
    fi
    echo "Processed $src to $dest"
done

echo "Dotfiles restoration/setup completed."

