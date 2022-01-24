**Update**
```
pacman -Sy;
```


**Minimal**
```bash
pacman -S plasma-desktop;
systemctl enable --now sddm;
systemctl restart sddm;
```



**Installer [KDE](https://wiki.archlinux.fr/KDE) :** (groupe plasma)
```
pacman -S --noconfirm plasma;
```

**Groupe Plasma**
```
pacman -S --noconfirm plasma
pacman -S --noconfirm bluedevil
pacman -S --noconfirm breeze
pacman -S --noconfirm breeze-gtk
pacman -S --noconfirm discover
pacman -S --noconfirm drkonqi
pacman -S --noconfirm kactivitymanagerd
pacman -S --noconfirm kde-cli-tools
pacman -S --noconfirm kde-gtk-config
pacman -S --noconfirm kdecoration
pacman -S --noconfirm kdeplasma-addons
pacman -S --noconfirm kgamma5
pacman -S --noconfirm khotkeys
pacman -S --noconfirm kinfocenter
pacman -S --noconfirm kmenuedit
pacman -S --noconfirm kscreen
pacman -S --noconfirm kscreenlocker
pacman -S --noconfirm ksshaskpass
pacman -S --noconfirm ksystemstats
pacman -S --noconfirm kwallet-pam
pacman -S --noconfirm kwayland-integration
pacman -S --noconfirm kwayland-server
pacman -S --noconfirm kwin
pacman -S --noconfirm kwrited
pacman -S --noconfirm layer-shell-qt
pacman -S --noconfirm libkscreen
pacman -S --noconfirm libksysguard
pacman -S --noconfirm milou
pacman -S --noconfirm oxygen
pacman -S --noconfirm plasma-browser-integration
pacman -S --noconfirm plasma-desktop
pacman -S --noconfirm plasma-disks
pacman -S --noconfirm plasma-firewall
pacman -S --noconfirm plasma-integration
pacman -S --noconfirm plasma-nm
pacman -S --noconfirm plasma-pa
pacman -S --noconfirm plasma-sdk
pacman -S --noconfirm plasma-systemmonitor
pacman -S --noconfirm plasma-thunderbolt
pacman -S --noconfirm plasma-vault
pacman -S --noconfirm plasma-workspace
pacman -S --noconfirm plasma-workspace-wallpapers
pacman -S --noconfirm polkit-kde-agent
pacman -S --noconfirm powerdevil
pacman -S --noconfirm sddm-kcm
pacman -S --noconfirm systemsettings
pacman -S --noconfirm xdg-desktop-portal-kde
```

**Extras**
```
pacman -S --noconfirm plasma-meta;
pacman -S --noconfirm kde-applications;
pacman -S --noconfirm kde-applications-meta;
```

**Supports**
```
Les Applications Qt5 > installé qtcurve-qt5 | qtcurve-kde 
Les Applications Qt4 > installé qtcurve-qt4
```
