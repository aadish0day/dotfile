#!/bin/bash

# Define the base directory for GitHub dotfiles
GITHUB_DOTFILES_DIR=~/Documents/GitHub/dotfile

# List of config directories to backup
declare -A config_directories=(
    [i3]=".config/i3"
    [moc]=".moc"
    [neofetch]=".config/neofetch"
    [ranger]=".config/ranger"
    [zathura]=".config/zathura"
)

# Loop through the config directories and perform operations
for key in "${!config_directories[@]}"; do
    src_dir="${HOME}/${config_directories[$key]}"
    dest_dir="${GITHUB_DOTFILES_DIR}/${key}"

    # Remove the destination directory if it exists
    rm -fr "${dest_dir}"

    # Copy the source directory to the destination
    cp -r "${src_dir}" "${dest_dir}"

    echo "Backed up ${config_directories[$key]} to ${dest_dir}"
done

echo "Backup completed."

