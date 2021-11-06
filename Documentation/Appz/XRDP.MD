**Installation du paquet**
```
yay -S --noconfirm xrdp     ; # Paquet de base
```

**xorgxrdp** :
```
gpg --keyserver keys.gnupg.net --recv-keys 61ECEABBF2BB40E3A35DF30A9F72CDBC01BF10EB ;
yay -S --noconfirm xorgxrdp ; # Paquet de base

```




**Configuration du service XRDP et XRDP-SESMAN**
```
```







**Activation des services**
```
systemctl enable xrdp        ;
systemctl enable xrdp-sesman ;
```

**Vérification des services**
```
systemctl status xrdp        ;
systemctl status xrdp-sesman ;
```

