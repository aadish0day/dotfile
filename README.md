# dotfile

## i3 

```
mv ~/.config/i3 ~/.config/i3.bak
cp -r i3/ ~/.config/
```

## moc (Music player) 

```
mkdir -p ~/.moc
cp -r moc/* ~/.moc/
```

## neofetch

```
rm -fr ~/.config/neofetch/ 
cp -r neofetch/ ~/.config/neofetch/
```

## ranger

```
cp -r ranger/ ~/.config/
```

## zathura

```
cp -r zathura/ ~/.config/
```

## tmux

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp tmux.conf ~/.tmux.conf
```

## theme for qbittorrent

```
cp theme/ ~/.theme
```
