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
./autogen.sh
make
sudo make install
```

**Pré-Requis:**
```
sudo pacman -S --noconfirm xfce4-dev-tools ;
```

**Relancer le gestionnaire de fenêtre**
```
systemctl restart sddm ;
```
