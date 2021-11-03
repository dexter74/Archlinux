#### Guide:
```
https://www.linuxtricks.fr/wiki/gnome-3-quelques-extensions-sympa
```

**Installation de SDDM**
```
pacman -S --noconfirm sddm;
systemctl enable --now sddm ;
```

**Installation de Gnome**
```
pacman -Syu --noconfirm gnome ;
pacman -S  --noconfirm gnome-extra ;
systemctl restart sddm ;
```
