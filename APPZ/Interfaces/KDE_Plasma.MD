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
pacman -S plasma;
pacman -S bluedevil;
pacman -S breeze;
pacman -S breeze-gtk;
pacman -S discover;
pacman -S drkonqi;
pacman -S kactivitymanagerd;
pacman -S kde-cli-tools;
pacman -S kde-gtk-config;
pacman -S kdecoration;
pacman -S kdeplasma-addons;
pacman -S kgamma5;
pacman -S khotkeys;
pacman -S kinfocenter;
pacman -S kmenuedit;
pacman -S kscreen;
pacman -S kscreenlocker;
pacman -S ksshaskpass;
pacman -S ksystemstats;
pacman -S kwallet-pam;
pacman -S kwayland-integration;
pacman -S kwayland-server;
pacman -S kwin;
pacman -S kwrited;
pacman -S layer-shell-qt;
pacman -S libkscreen;
pacman -S libksysguard;
pacman -S milou;
pacman -S oxygen;
pacman -S plasma-browser-integration;
pacman -S plasma-desktop;
pacman -S plasma-disks;
pacman -S plasma-firewall;
pacman -S plasma-integration;
pacman -S plasma-nm;
pacman -S plasma-pa;
pacman -S plasma-sdk;
pacman -S plasma-systemmonitor;
pacman -S plasma-thunderbolt;
pacman -S plasma-vault;
pacman -S plasma-workspace;
pacman -S plasma-workspace-wallpapers;
pacman -S polkit-kde-agent;
pacman -S powerdevil;
pacman -S sddm-kcm;
pacman -S systemsettings;
pacman -S xdg-desktop-portal-kde;
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
