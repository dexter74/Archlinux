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

**Nautilus**
```
echo '
XDG_DESKTOP_DIR="$HOME/Bureau"
XDG_DOWNLOAD_DIR="$HOME/Téléchargement"
XDG_TEMPLATES_DIR="$HOME/Modèles"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Musiques"
XDG_PICTURES_DIR="$HOME/Images"
XDG_VIDEOS_DIR="$HOME/Vidéos"
' > ~/.config/user-dirs
```
