**Menu Démarrer Style Windows**
```
kali-undercover
```

# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --asexplicit xfce4              ; # Groupe de paquet
pacman -S --asexplicit xfce4-goodies      ; # extra
pacman -S --asexplicit xfce4-dev-tools    ; # Outils
pacman -S --asexplicit gvfs               ; # Requiert pour la corbeille, Thunar
```

**Son**
```
pacman -S --asexplicit pavucontrol        ; # Contrôleur de son
pacman -S --asexplicit pipewire           ; # Son (A testé)
pacman -S --asexplicit pulseaudio         ; # Son
systemctl --user enable --now pipewire    ; # Service gérent le son
systemctl --user enable --now pulseaudio  ; # Service gérent le son
```

**Thunar** (Dépendances optionnel)
```
pacman -S --asexplicit thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfdesktop ;
pacman -S --asexplicit gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb ;
```

**prise Partage**
```
```


**Répertoire par défaut**
```
echo 'XDG_DESKTOP_DIR="$HOME/Bureau"
XDG_DOWNLOAD_DIR="$HOME/Téléchargements"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Musiques"
XDG_PICTURES_DIR="$HOME/Images"
XDG_VIDEOS_DIR="$HOME/Videos"' > ~/.config/user-dirs.dirs

mkdir $HOME/ Bureau Téléchargements Templates Public Documents Musiques Images Videos
```
