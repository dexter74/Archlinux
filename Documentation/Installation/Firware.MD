

**Installation de YAY**
```
cd /tmp ;
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
cd /tmp ;
```

**Vmware**
````
# ==> WARNING: Possibly missing firmware for module: qed
# ==> WARNING: Possibly missing firmware for module: aic94xx
# ==> WARNING: Possibly missing firmware for module: cxgb4
# ==> WARNING: Possibly missing firmware for module: csiostor
# ==> WARNING: Possibly missing firmware for module: cxgb3
# ==> WARNING: Possibly missing firmware for module: wd719x
# ==> WARNING: Possibly missing firmware for module: bfa
# ==> WARNING: Possibly missing firmware for module: advansys
# ==> WARNING: Possibly missing firmware for module: qla2xxx
# ==> WARNING: Possibly missing firmware for module: isci
# ==> WARNING: Possibly missing firmware for module: qla1280
# ==> WARNING: Possibly missing firmware for module: xhci_pci
# ==> WARNING: Possibly missing firmware for module: ums_eneub6250


yay -S --noconfirm qed
yay -S --noconfirm aic94xx
yay -S --noconfirm cxgb4
yay -S --noconfirm csiostor
yay -S --noconfirm cxgb3
yay -S --noconfirm wd719x
yay -S --noconfirm bfa
yay -S --noconfirm advansys
yay -S --noconfirm isci
yay -S --noconfirm qla1280
yay -S --noconfirm xhci_pci
yay -S --noconfirm ums_eneub6250
```

