**Installation du paquet**
```
yay -S --noconfirm xrdp ; # Paquet de base
```

**xorgxrdp** :
```
gpg --keyserver keys.gnupg.net --recv-keys 61ECEABBF2BB40E3A35DF30A9F72CDBC01BF10EB ;
yay -S --noconfirm xorgxrdp ;
```

**Activation des services**
```
systemctl enable --now xrdp ;
systemctl enable --now  xrdp-sesman ;
```

**Vérification des services**
```
systemctl status xrdp ;
systemctl status xrdp-sesman ;
```

**Configuration du service XRDP et XRDP-SESMAN**
```
echo "exec xfce4-session" > ~/.xinitrc
```






