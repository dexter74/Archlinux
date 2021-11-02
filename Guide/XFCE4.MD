# Installation du gestionnaire de fenêtre SDDM
``` 
pacman -S --noconfirm sddm ; systemctl enable --now sddm ;
``` 

# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --noconfirm xfce4 ;
pacman -S --noconfirm xfce4-goodies ;
```

**Auto-Login sur XFCE**
```
echo "[Autologin]
User=marc
Session=xfce.desktop

[General]
Numlock=on

[Theme]
Current=breeze" > /etc/sddm.conf ; systemctl restart sddm ;
```
---------------------------------------------------------------------------------------------
**Icons**
Dossier des icones:
```
/usr/share/icons/
```
```
https://github.com/yeyushengfan258/Win10Sur-icon-theme
```
---------------------------------------------------------------------------------------------
**Themes**
Dossier des thèmes:
```
/usr/share/themes/
```
---------------------------------------------------------------------------------------------
**Création de l'icône PC**
```
thunar /
```
---------------------------------------------------------------------------------------------
**Logon**











---------------------------------------------------------------------------------------------
**EN DEV**
```
pacman -S --noconfirm pulseaudio  ; # Volume son
pacman -S --noconfirm pavucontrol ; # Mixeur de volume GUI Barre des tâches
pacman -S blueman network-manager-applet
pacman -s xfce4-dev-tools ;

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
systemctl --user enable --now blueman-applet.service 
nm-applet.service
https://github.com/nsz32/docklike-plugin
```
