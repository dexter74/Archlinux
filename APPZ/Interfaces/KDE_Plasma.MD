**Update**
```
pacman -Sy;
```


**Minimal**
```bash
pacman -S --noconfirm plasma-desktop;
# En cas de soucis:
# pacman-key --init;
# pacman-key --populate;
```


systemctl enable ---now ssdm;


**Installer [KDE](https://wiki.archlinux.fr/KDE) :** (groupe plasma)
```
pacman -S --noconfirm plasma;
```

**Groupe Plasma**
```
plasma
bluedevil
breeze
breeze-gtk
discover
drkonqi
kactivitymanagerd
kde-cli-tools
kde-gtk-config
kdecoration
kdeplasma-addons
kgamma5
khotkeys
kinfocenter
kmenuedit
kscreen
kscreenlocker
ksshaskpass
ksystemstats
kwallet-pam
kwayland-integration
kwayland-server
kwin
kwrited
layer-shell-qt
libkscreen
libksysguard
milou
oxygen
plasma-browser-integration
plasma-desktop
plasma-disks
plasma-firewall
plasma-integration
plasma-nm
plasma-pa
plasma-sdk
plasma-systemmonitor
plasma-thunderbolt
plasma-vault
plasma-workspace
plasma-workspace-wallpapers
polkit-kde-agent
powerdevil
sddm-kcm
systemsettings
xdg-desktop-portal-kde
```

**Extras**
```
pacman -S --noconfirm plasma-meta;
pacman -S --noconfirm plasma-desktop;
pacman -S --noconfirm kde-applications;
pacman -S --noconfirm kde-applications-meta;
```

**Supports**
```
Les Applications Qt5 > installé qtcurve-qt5 | qtcurve-kde 
Les Applications Qt4 > installé qtcurve-qt4
```
