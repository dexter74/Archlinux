## Expérimental

[vala-panel-appmenu](https://github.com/rilian-la-te/vala-panel-appmenu#dependency-packages)

[topic](https://www.reddit.com/r/xfce/comments/pyzbrn/how_to_actually_enable_global_menu_in_xfce/)

[Mon Topic](https://forums.archlinux.fr/viewtopic.php?f=1&t=22413&p=177221#p177221)



### Vala-Panel

**Dépendance:
```
GLib (>= 2.56.0)
GTK3 (>= 3.22.0)
libwnck (>= 3.4.7)
libX11
valac (vala sous Arch)
```

```
yay -S --noconfirm glib2 gtk3 libwnck3 lib32-libx11 libx11 vala
```


**Paquet Vala-Panel :**
```
cd /tmp ;
rm -r /tmp/*
git clone https://github.com/rilian-la-te/vala-panel.git ;
cd vala-panel ;
```
