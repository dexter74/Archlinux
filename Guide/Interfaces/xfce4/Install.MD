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

/usr/lib/systemd/system/nm-applet.service
[Unit]
Description=nm-applet
[Service]
ExecStart=nm-applet
[Install]
WantedBy=default.target

/usr/lib/systemd/system/blueman-applet.service
[Unit]
Description=blueman-applet
[Service]
ExecStart=blueman-applet
[Install]
WantedBy=default.target

systemctl --user daemon-reload
systemctl --user enable --now blueman-applet.service nm-applet.service
https://github.com/nsz32/docklike-plugin
```
