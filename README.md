# dotfile

## SystemD Configuration to Prevent Suspension

Create a systemd service to prevent suspension:

sh```
1. Create a systemd service file:

    ```
    sudo nvim /etc/systemd/system/disable-suspend.service
    ```

2. Add the following content:

    ```ini
    [Unit]
    Description=Prevent suspend
    Before=sleep.target

    [Service]
    Type=oneshot
    ExecStart=/usr/bin/systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

    [Install]
    WantedBy=multi-user.target
    ```

3. Enable and start the service:

    ```
    sudo systemctl enable disable-suspend.service
    sudo systemctl start disable-suspend.service
    ```

```

## Managing Power Management with `systemd-logind`

Prevent automatic suspension:

1. Edit `/etc/systemd/logind.conf`:

    ```
    sudo nvim /etc/systemd/logind.conf
    ```

2. Modify or add the following lines:

    ```
    HandleSuspendKey=ignore
    HandleLidSwitch=ignore
    HandleHibernateKey=ignore
    ```

3. Restart the `systemd-logind` service:

    ```
    sudo systemctl restart systemd-logind.service
    ```


</details>

### i3 

```
mv ~/.config/i3 ~/.config/i3.bak
cp -r i3/ ~/.config/
```

### moc (Music player) 

```
mkdir -p ~/.moc
cp -r moc/* ~/.moc/
```

### neofetch

```
rm -fr ~/.config/neofetch/ 
cp -r neofetch/ ~/.config/neofetch/
```

### ranger

```
cp -r ranger/ ~/.config/
```

### zathura

```
cp -r zathura/ ~/.config/
```

### tmux

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp tmux.conf ~/.tmux.conf
```

### theme for qbittorrent

```
cp theme/ ~/.theme
```
