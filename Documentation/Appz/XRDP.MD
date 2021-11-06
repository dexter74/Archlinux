**Installation du paquet**
```
yay -S --noconfirm xrdp     ; # Paquet de base
yay -S --noconfirm xorgxrdp ; # Xorg drivers for xrdp
```

**Activation des services**
```
systemctl enable xrdp
systemctl enable xrdp-sesman
```
