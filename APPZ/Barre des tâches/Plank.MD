**Installation**
```
pacman -S --noconfirm plank ;
```

**Correctif de bug :**
```
Démarrer > Paramètres > Peaufinage des fenêtres > Onglet compositeur >  - Décochez "affichez les ombres sous les fenêtres dock"
xfwm4-tweaks-settings
sed -i 's/<property name\="show_dock_shadow" type\="bool" value="true"\/>/<property name\="show_dock_shadow" type\="bool" value="flase"\/>/' .config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
```


**AutoStart**
```
mkdir -p ~/.config/autostart ;
cp /usr/share/applications/plank.desktop ~/.config/autostart/ 
sudo chmod +x ~/.config/autostart/plank.desktop ;
rm ~/.config/autostart/plank.desktop ;
```



**Settings**
```
plank --preferences ;
```


**Thèmes**
```
wget -c <liens> -O /tmp/1.zip    ; unzip   /tmp/1.zip    -d /usr/share/plank/themes ;
wget -c <liens> -O /tmp/1.tar.gz ; tar xvf /tmp/1.tar.gz -C /usr/share/plank/themes ;
```
