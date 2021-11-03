
[Guide](https://wiki.xfce.org/fr/howto/install_new_themes)

```
REMARQUE : Il est aussi possible que le thème contienne des fichiers *.svg , dans ce cas, la bibliothèque librsvg est recommandée pour une meilleure intégration du thème.
pacman -S --noconfirm librsvg ;
```
**ocs-urls**
```
pacman -S --noconfirm qt5-base qt5-svg qt5-declarative qt5-quickcontrols
yay    -S --noconfirm ocs-url ; # Outils pour télécharger thèmes 
```

**Dossier Thèmes :**
```
/usr/share/themes
```

**MacOS**
```
wget -c https://github.com/B00merang-Project/macOS-Dark/archive/6.1-dark.zip -O /tmp/6.1-dark.zip ; unzip /tmp/6.1-dark.zip -d /usr/share/themes ;
wget -c https://github.com/B00merang-Project/macOS/archive/6.1.zip           -O /tmp/6.1.zip      ; unzip /tmp/6.1.zip      -d /usr/share/themes ;
```
