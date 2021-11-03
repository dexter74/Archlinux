# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --noconfirm xfce4 ;
pacman -S --noconfirm xfce4-goodies ;
pacman -S --noconfirm xfce4-dev-tools ;
```

---------------------------------------------------------------------------------------------
**EN DEV**
```
pacman -S --noconfirm pulseaudio              ; # Volume son
pacman -S --noconfirm pavucontrol             ; # Mixeur de volume GUI Barre des tâches
pacman -S --noconfirm blueman                 ; # Bluetooth
pacman -S --noconfirm network-manager-applet  ;
```

**nm-applet**
```
echo "[Unit]
Description=nm-applet
[Service]
ExecStart=nm-applet
[Install]
WantedBy=default.target" > /usr/lib/systemd/system/nm-applet.service
```


**Blueman** (Bluetooth)
```
echo "[Unit]
Description=blueman-applet
[Service]
ExecStart=blueman-applet
[Install]
WantedBy=default.target" > /usr/lib/systemd/system/blueman-applet.service
```

**Rafraîchir Daemon**
```
systemctl --user daemon-reload
```

**Activer les services**
```
systemctl --user enable --now /usr/lib/systemd/system/nm-applet.service ;
systemctl --user enable --now /usr/lib/systemd/system/blueman-applet.service ;
```


**Vérifier l'état du service**
```
systemctl --user status nm-applet.service ;
systemctl --user status blueman-applet.service ;
```
https://github.com/nsz32/docklike-plugin


Menu Whisker > Commande 
```
Paquets: mugshot et menulibre
```
