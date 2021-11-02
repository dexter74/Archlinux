# Installation du gestionnaire de fenêtre SDDM
``` 
pacman -S --noconfirm  sddm ;
systemctl enable --now sddm ;
``` 

# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --noconfirm xfce4 ;
```

**Mixeur Audio**
```
pacman -S --noconfirm pulseaudio  ; # Volume son
pacman -S --noconfirm pavucontrol ; # Mixeur de volume GUI Barre des tâches
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
systemctl --user enable --now blueman-applet.service 
nm-applet.service
```



**DockLite-Plugin**
https://github.com/nsz32/docklike-plugin

```
pacman -s xfce4-dev-tools ;
```


