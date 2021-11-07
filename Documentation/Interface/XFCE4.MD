# Installation de XFCE

**Installation de XFCE4** (Base)
```
pacman -S --asexplicit xfce4           ; # Groupe de paquet
pacman -S --asexplicit xfce4-goodies   ; # extra
pacman -S --asexplicit xfce4-dev-tools ; # Outils
pacman -S --asexplicit gvfs            ; # Requiert pour la corbeille, Thunar
```

**Thunar** (Dépendances optionnel)
```
pacman -Qi thunar ;
# Requis par : thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfdesktop
```

```
pacman -S --asexplicit thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfdesktop ;
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
