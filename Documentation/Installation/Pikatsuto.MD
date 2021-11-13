
```
==> WARNING: Possibly missing firmware for module: isci
==> WARNING: Possibly missing firmware for module: advansys
==> WARNING: Possibly missing firmware for module: aic94xx
==> WARNING: Possibly missing firmware for module: cxgb4
==> WARNING: Possibly missing firmware for module: csiostor
==> WARNING: Possibly missing firmware for module: qed
==> WARNING: Possibly missing firmware for module: qla1280
==> WARNING: Possibly missing firmware for module: cxgb3
==> WARNING: Possibly missing firmware for module: bfa
==> WARNING: Possibly missing firmware for module: qla2xxx
==> WARNING: Possibly missing firmware for module: wd719x
==> WARNING: Possibly missing firmware for module: xhci_pci
==> WARNING: Possibly missing firmware for module: ums_eneub6250
```


**Root**
```bash
sudo pacman -S --noconfirm open-iscsi ;
```

**Marc**
```bash
su - marc ;
```

**Yaourt**
```bash
clear ;
cd /tmp ;
rm -r -f /tmp/* ;
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
```

**Mise à jour**
```bash
pacman -Sy ;
```

```bash
clear ;
yay -S --noconfirm
```
