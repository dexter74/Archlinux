**Installation du gestionnaire de fenêtre SDDM**
``` 
pacman -S --noconfirm sddm  ;
``` 

**Activation du service :**
```
systemctl enable --now sddm ;
```

**Relance du service**
```
systemctl restart sddm ;
```

**Etat du service**
```
systemctl status sddm ;
```

**Configuration de SSDM**
```
echo "[Autologin]
User=marc
Session=xfce.desktop

[General]
Numlock=on

[Theme]
Current=breeze" > /etc/sddm.conf ; systemctl restart sddm ;
```


**Dossier Utiles**
```
Liste des Bureaux disponibles : /usr/share/xsessions/
```
