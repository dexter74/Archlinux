**Expérimental**




[vala-panel-appmenu](https://github.com/rilian-la-te/vala-panel-appmenu#dependency-packages)
[topic](https://www.reddit.com/r/xfce/comments/pyzbrn/how_to_actually_enable_global_menu_in_xfce/)
[Mon Topic](https://forums.archlinux.fr/viewtopic.php?f=1&t=22413&p=177221#p177221)



**Outils pour la compilation**
```
pacman -S --noconfirm meson ;
```

**Dépendance :**
```
pacman -S --noconfirm glib2 gtk3 vala bamf ;
```

**Correctif erreur:**
```
pacman -S --noconfirm gobject-introspection ;
```


**GIT**
```
cd /tmp ;
rm -r /tmp/* ;
git clone https://gitlab.com/vala-panel-project/vala-panel-appmenu.git ;
cd /tmp/vala-panel-appmenu ;
meson -Dxfce=enabled --prefix=/usr/local /tmp ;
ninja install ;
```



```
 gtk2 cmake appmenu-gtk-module
yay -S --noconfirm vala-panel ;
```
