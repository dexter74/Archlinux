**Installation**
```
pacman -S --noconfirm plank ;
```

**Correctif de bug :**
```
Démarrer > Paramètres > Peaufinage des fenêtres
Onglet compositeur
 - Décochez "affichez les ombres sous les fenêtres dock"
```

**AutoStart**
```
mkdir -p ~/.config/autostart
cp /usr/share/applications/plank.desktop ~/.config/autostart/
sudo chmod +x ~/.config/autostart/plank.desktop
rm ~/.config/autostart/plank.desktop
```



**Settings**
```
plank --preferences
```


**Thèmes**
```
wget -c <liens> -O /tmp/1.zip ; unzip /tmp/1.zip -d /usr/share/plank/themes ;
```
