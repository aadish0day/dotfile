#!/bin/bash

echo "Setting up paths..."
backup_dir=~/Documents/GitHub/dotfile

echo "Backup Bash configuration..."
bashrc_src=~/.bashrc
bashrc_dest=$backup_dir/bashrc
rm -rf $bashrc_dest
cp -r $bashrc_src $bashrc_dest

echo "Backup i3 configuration..."
i3_src=~/.config/i3
i3_dest=$backup_dir/i3
rm -rf $i3_dest
cp -r $i3_src $i3_dest

echo "Backup MOC configuration..."
moc_src=~/.moc
moc_dest=$backup_dir/moc
rm -rf $moc_dest
cp -r $moc_src $moc_dest

echo "Backup Neofetch configuration..."
neofetch_src=~/.config/neofetch
neofetch_dest=$backup_dir/neofetch
rm -rf $neofetch_dest
cp -r $neofetch_src $neofetch_dest

echo "Backup Picom configuration..."
picom_src=~/.config/picom
picom_dest=$backup_dir/picom
rm -rf $picom_dest
cp -r $picom_src $picom_dest

echo "Backup Ranger configuration..."
ranger_src=~/.config/ranger
ranger_dest=$backup_dir/ranger
rm -rf $ranger_dest
cp -r $ranger_src $ranger_dest

echo "Backup Theme configuration..."
theme_src=~/.theme
theme_dest=$backup_dir/theme
rm -rf $theme_dest
cp -r $theme_src $theme_dest

echo "Backup Tmux configuration..."
tmux_src=~/.config/tmux
tmux_dest=$backup_dir/tmux
rm -rf $tmux_dest
cp -r $tmux_src $tmux_dest

echo "Backup XFCE4 configuration..."
xfce4_src=~/.config/xfce4
xfce4_dest=$backup_dir/xfce4
rm -rf $xfce4_dest
cp -r $xfce4_src $xfce4_dest

echo "Backup Zathura configuration..."
zathura_src=~/.config/zathura
zathura_dest=$backup_dir/zathura
rm -rf $zathura_dest
cp -r $zathura_src $zathura_dest

echo "Backup Kitty configuration..."
kitty_src=~/.config/kitty
kitty_dest=$backup_dir/kitty
rm -rf $kitty_dest
cp -r $kitty_src $kitty_dest

echo "Backup Alacritty configuration..."
kitty_src=~/.config/alacritty/
kitty_dest=$backup_dir/alacritty
rm -rf $kitty_dest
cp -r $kitty_src $kitty_dest

echo "All configurations have been backed up successfully!"

