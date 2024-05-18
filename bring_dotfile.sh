#!/bin/bash

echo "Setting up paths..."
backup_dir=~/Documents/GitHub/dotfile

# Declare an associative array where keys are source paths and values are destination paths
declare -A paths=(
    [~/.bashrc]="$backup_dir/bashrc"
    [~/.zshrc]="$backup_dir/zshrc"
    [~/.config/i3]="$backup_dir/i3"
    [~/.moc]="$backup_dir/moc"
    [~/.config/neofetch]="$backup_dir/neofetch"
    [~/.config/picom]="$backup_dir/picom"
    [~/.config/ranger]="$backup_dir/ranger"
    [~/.theme]="$backup_dir/theme"
    [~/.config/tmux]="$backup_dir/tmux"
    [~/.config/xfce4]="$backup_dir/xfce4"
    [~/.config/zathura]="$backup_dir/zathura"
    [~/.config/kitty]="$backup_dir/kitty"
    [~/.config/alacritty]="$backup_dir/alacritty"
)

# Loop through the associative array
for src in "${!paths[@]}"; do
    dest="${paths[$src]}"
    echo "Backing up $(basename $src) configuration..."
    rm -rf $dest
    cp -r $src $dest
done

echo "All configurations have been backed up successfully!"

