**Installation**
```
pacman -S --noconfirm plank ;
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
