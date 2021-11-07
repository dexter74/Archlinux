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

