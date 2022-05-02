**Installation de Docklite**

![screenshot](https://i.imgur.com/b4qDHCB.jpg)

**Changer User**
```
su - marc ;
```

[Release](https://docs.xfce.org/panel-plugins/xfce4-docklike-plugin/start#latest_release)

[GUIDE](https://www.reddit.com/r/xfce/comments/og249s/xfce4docklikeplugin_v030_released/)

**Installation**
```
https://archive.xfce.org/src/panel-plugins/xfce4-docklike-plugin/0.4/xfce4-docklike-plugin-0.4.0.tar.bz2
tar xf xfce4-docklike-plugin-0.4.0.tar.bz2
cd xfce4-docklike-plugin-0.4.0
```

**Pré-Requis:**
```
sudo pacman -S --noconfirm xfce4-dev-tools ;

Debian:
- make
- gcc
- intltool
- xorg-dev
- gio-2.0 (libglib2.0-dev)
- gtk2.0-examples
- gtk-3.0-examples
- libgtk-3-dev
- libwnck-3-0 / libwnck-3-dev
- libxfce4ui-2-dev
```

**Relancer le gestionnaire de fenêtre**
```
systemctl restart sddm ;
```
