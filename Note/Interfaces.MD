
https://wiki.archlinux.org/title/desktop_environment

https://archlinux.org/packages/?sort=&q=-desktop&maintainer=&flagged=



**Gestionnaire de Fenêtre**
```
pacman -S --noconfirm sddm ; systemctl enable --now sddm ;
```

**Redémarrage du service**
```
systemctl restart sddm ;
```

```
echo "[Autologin]
User=marc
Session=xfce.desktop

[General]
Numlock=on

[Theme]
Current=breeze" > /etc/sddm.conf
```



**Interface Interface**
```pacman -S --noconfirm budgie-desktop budgie-extra budgie-desktop-view budgie-screensaver
pacman -S --noconfirm cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver 	cinnamon-session cinnamon-settings-daemon cinnamon-translations cjs muffin nemo
pacman -S --noconfirm Cutefish
pacman -S --noconfirm deepin deepin-desktop-base deepin-extra 
pacman -S --noconfirm element-desktop
pacman -S --noconfirm Enlightenment
pacman -S --noconfirm gnome gnome-remote-desktop
pacman -S --noconfirm kde1-kdebase-git
pacman -S --noconfirm liri-shell-git
pacman -S --noconfirm lumina-desktop
pacman -S --noconfirm lxde     ; # GTK 2
pacman -S --noconfirm lxde-gtk3; # GTK 3
pacman -S --noconfirm LXQt
pacman -S --noconfirm mate-desktop
pacman -S --noconfirm pantheon
pacman -S --noconfirm paperdeA
pacman -S --noconfirm phosh
pacman -S --noconfirm plasma-desktop
pacman -S --noconfirm sugar sugar-fructose
pacman -S --noconfirm ukui
pacman -S --noconfirm xfce4
# Equinox (ede)
```

#liri
#lumina
#paperde
#phosh
#kde1-kdebase-git


**Configuration du gestionnaire de fenêtre**
```
ls /usr/share/xsessions/
ls /usr/share/sddm/themes/

element-desktop
lxde-gtk3
LXQt
mate-desktop
paperdeA
phosh
plasma-desktop
sugar sugar-fructose
ukui
Xfce

```
