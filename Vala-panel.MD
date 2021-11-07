**Expérimental**




[vala-panel-appmenu](https://github.com/rilian-la-te/vala-panel-appmenu#dependency-packages)
[topic](https://www.reddit.com/r/xfce/comments/pyzbrn/how_to_actually_enable_global_menu_in_xfce/)
[Mon Topic](https://forums.archlinux.fr/viewtopic.php?f=1&t=22413&p=177221#p177221)

```
pacman -S --noconfirm meson gobject-introspection vala gtk2 cmake appmenu-gtk-module bamf ;
yay -S --noconfirm vala-panel ;

cd /tmp ;
rm -r /tmp/* ;
git clone https://gitlab.com/vala-panel-project/vala-panel-appmenu.git ;
cd /tmp/vala-panel-appmenu ;
meson -Dxfce=auto --prefix=/usr/local /tmp ;
ninja install ;
```

