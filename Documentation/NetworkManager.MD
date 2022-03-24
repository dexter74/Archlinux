#### Information [Arch-WIKI](https://wiki.archlinux.org/title/NetworkManager_(Fran%C3%A7ais))
Un gestionnaire réseau actif .

N'activez pas **iwd.service** ou ne configurez pas manuellement iwd. NetworkManager le lancera et le gérera lui-même.`

---------------------------------------------------------------------------------------------------------------------------------------------------

#### 1. Installation NetworkManager avec iwd. (WIFI)
``` 
pacman -Sy --noconfirm gnome-keyring iwd networkmanager;
```

### 2. Définir NetworkManager comme gestionnaire réseau
``` 
systemctl disable --now iwd;
systemctl disable --now dhcpcd;
systemctl disable --now systemd-networkd;
systemctl enable --now NetworkManager;
``` 

**Vérifier:**
```
systemctl list-unit-files --stated=enabled
```

### 3. Utiliser iwd comme backend Wi-Fi
```
echo "[device]
wifi.backend=iwd" > /etc/NetworkManager/config.d/iwd.conf;
```

### 4. Relancer le service 
``` 
systemctl restart NetworkManager 
``` 

/var/lib/iwd/
