
https://wiki.archlinux.org/title/desktop_environment
https://archlinux.org/packages/?sort=&q=-desktop&maintainer=&flagged=



**Gestionnaire de Fenêtre**
```
pacman -S --noconfirm sddm ; systemctl enable --now sddm ;
```


**Interface Interface**
```
pacman -s --noconfirm budgie-desktop budgie-extra budgie-desktop-view budgie-screensaver
pacman -s --noconfirm cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver 	cinnamon-session cinnamon-settings-daemon cinnamon-translations cjs muffin nemo
pacman -s --noconfirm Cutefish
pacman -s --noconfirm deepin deepin-desktop-base deepin-extra 
pacman -s --noconfirm element-desktop
pacman -s --noconfirm Enlightenment
pacman -s --noconfirm gnome gnome-remote-desktop
pacman -s --noconfirm kde1-kdebase-git
pacman -s --noconfirm liri-shell-git
pacman -s --noconfirm lumina-desktop
pacman -s --noconfirm lxde     ; # GTK 2
pacman -s --noconfirm lxde-gtk3; # GTK 3
pacman -s --noconfirm LXQt
pacman -s --noconfirm mate-desktop
pacman -s --noconfirm pantheon
pacman -s --noconfirm paperdeA
pacman -s --noconfirm phosh
pacman -s --noconfirm plasma-desktop
pacman -s --noconfirm sugar sugar-fructose
pacman -s --noconfirm ukui
pacman -s --noconfirm xfce4
# Equinox (ede)
```



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

#liri
#lumina
#paperde
#phosh
#kde1-kdebase-git
```

```
TOP       : cutefish, 
Normal    : cinnamon, 
BOFF      : gnome, lxde, XXX 
NULL      : openbox
Incomplet : budgie, deepin
Marche Pas: enlightenment, pantheon
```


```
echo "[Autologin]
User=root
Session=cutefish-xsession.desktop
[General]
Numlock=on
[Theme]
Current=elarun " > /etc/sddm.conf ; systemctl restart sddm
```

