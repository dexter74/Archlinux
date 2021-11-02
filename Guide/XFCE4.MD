**Installation de XFCE4** (Base)
```
pacman -S --noconfirm xfce4 ;
```
**Extra**
```
pacman -S xfce4-goodies ;
```


**Création de l'icône PC**
```
thunar /
```

**Modifier apparence**
```
xfce4-appearance-settings
```

**PulseAudio** (icone Bureau)
```
pavucontrol
```

**Paquet**
```
pacman -S blueman network-manager-applet
```


### Services:
/usr/lib/systemd/system/nm-applet.service
```
[Unit]
Description=nm-applet

[Service]
ExecStart=nm-applet

[Install]
WantedBy=default.target
```

**Wi-Fi**
```
/usr/lib/systemd/system/blueman-applet.service

[Unit]
Description=blueman-applet

[Service]
ExecStart=blueman-applet

[Install]
WantedBy=default.target
```

**Sous Interface**
```
systemctl --user daemon-reload
```


systemctl --user enable --now blueman-applet.service 
nm-applet.service

