**Installation du paquet**
```
pacman -S --noconfirm xrdp     ; # Paquet de base
```

**Désactiver la vérification PGP**
```
nano /etc/pacman.conf
SigLevel = never
sed -i -e "s/\#SigLevel \= Optional TrustAll/\SigLevel \= Never/g" /etc/pacman.conf ;
```


```
su - marc ;
cd /tmp
git clone https://aur.archlinux.org/xorgxrdp.git
cd xorgxrdp ;
makepkg -si --noconfirm ;


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

