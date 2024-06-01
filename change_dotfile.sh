#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Function to update configuration directories
update_config() {
    local src=$1
    local dest=$2
    echo "Updating $src configuration..."
    rm -fr "$dest"
    cp -r "$src/" "$dest"
}

# Copy essential dotfiles
cp -r ./bring_dotfile.sh ~/
cp -r ./bashrc ~/.bashrc
source ~/.bashrc
cp -r ./zshrc ~/.zshrc
cp -r ./theme/ ~/.theme

# Update configurations for various applications
update_config ./i3 ~/.config/i3
update_config ./kitty ~/.config/kitty
update_config ./moc ~/.moc
update_config ./fastfetch ~/.config/fastfetch
update_config ./ranger ~/.config/ranger
update_config ./zathura ~/.config/zathura
update_config ./tmux ~/.config/tmux
update_config ./picom ~/.config/picom
update_config ./alacritty ~/.config/alacritty
update_config ./qutebrowser ~/.config/qutebrowser

# Conditional update for Xfce4 configuration
echo "Do you want to update the xfce4 configuration? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    update_config ./xfce4 ~/.config/xfce4
    echo "Xfce4 configuration updated."
else
    echo "Xfce4 configuration update skipped."
fi

echo "Dotfile update complete!"
echo "Please restart your shell or manually source the configuration files if necessary."
