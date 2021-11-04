# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --noconfirm xfce4           ; # Groupe de paquet
pacman -S --noconfirm xfce4-goodies   ; # extra
pacman -S --noconfirm xfce4-dev-tools ; # Outils
pacman -S --noconfirm gvfs            ; # Thunar > Parcourir réseau
pacman -S --noconfirm pacman -S xfwm4 xfce4-panel xfdesktop thunar xfce4-session xfce4-settings xfce4-appfinder xfce-utils xfconf
pacman -S gstreamer0.10-base-plugins
pacman -S dbus
```



---------------------------------------------------------------------------------------------
**EN DEV**
```
pacman -S --noconfirm pulseaudio              ; # Volume son
pacman -S --noconfirm pavucontrol             ; # Mixeur de volume GUI Barre des tâches
pacman -S --noconfirm blueman                 ; # Bluetooth
pacman -S --noconfirm network-manager-applet  ;


sudo pacman -S --needed gvfs-{afc,goa,google,gphoto2,mtp,nfs,smb} 
sudo pacman -S --needed xfce4 xfce4-goodies gvfs vlc quodlibet python-pyinotify lightdm-gtk-greeter xarchiver claws-mail galculator evince ffmpegthumbnailer xscreensaver  system-config-printer
```


**Dépendance optionel d'un paquet**
```
pacman -Qi thunar gvfs
```



**[PulseAudio](https://rudd-o.com/linux-and-free-software/how-to-make-pulseaudio-run-once-at-boot-for-all-your-users)**
```
echo "
[Unit]
Description=PulseAudio system server

[Service]
Type=notify
Exec=pulseaudio --daemonize=no --system --realtime --log-target=journal
Restart=on-failure

[Install]
WantedBy=multi-user.target " > /etc/systemd/system/pulseaudio.service ; 
systemctl daemon-reload 

systemctl --user enable --now pulseaudio.service
systemctl --user status --now pulseaudio.service
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
