# dotfile

## SystemD Configuration to Prevent Suspension

```
sudo ./disable-suspension.sh
```

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

## theme for qbittorrent

```
cp -r theme/ ~/.theme
```

## tmux 

```
cp -r tmux/ ~/.config/
```

## picom 

```
cp -r picom/ ~/.config/
```

## rofi 

```
cp -r rofi/ ~/.config/
```

