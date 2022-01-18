**Installation de Docklite**

![screenshot](https://i.imgur.com/b4qDHCB.jpg)

**Changer User**
```
su - marc ;
```

**Installation**
```
git clone https://github.com/nsz32/docklike-plugin &&  cd docklike-plugin
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
