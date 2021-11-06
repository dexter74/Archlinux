**Installation du paquet**
```
yay -S --noconfirm xrdp     ; # Paquet de base
yay -S --noconfirm xorgxrdp ; # Xorg drivers for xrdp
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

