#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Copy bring_dotfile.sh 
cp -r ./bring_dotfile.sh ~/

# Copy i3 configuration
echo "Updating i3 configuration..."
rm -fr ~/.config/i3/
cp -r i3/ ~/.config/

# Ensure .moc directory exists and copy MOC configuration
echo "Updating MOC configuration..."
mkdir -p ~/.moc
cp -r moc/* ~/.moc/

# Remove existing Neofetch configuration and copy the new one
echo "Updating Neofetch configuration..."
rm -rf ~/.config/neofetch/
cp -r neofetch/ ~/.config/

# Copy Ranger configuration
echo "Updating Ranger configuration..."
cp -r ranger/ ~/.config/

# Copy Zathura configuration
echo "Updating Zathura configuration..."
cp -r zathura/ ~/.config/

# Copy theme
echo "Updating system theme..."
cp -r theme/ ~/.theme

# Copy Tmux configuration
echo "Updating Tmux configuration..."
cp -r tmux/ ~/.config/

# Copy Picom configuration
echo "Updating Picom configuration..."
cp -r picom/ ~/.config/

# Ask for permission to update Xfce4 configuration
echo "Do you want to update the xfce4 configuration? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    echo "Updating xfce4 configuration..."
    rm -fr ~/.config/xfce4/
    cp -r xfce4/ ~/.config/
    echo "Xfce4 configuration updated."
else
    echo "Xfce4 configuration update skipped."
fi

echo "Dotfile update complete!"

