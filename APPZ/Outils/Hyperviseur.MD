
**Installer Qemu**
```bash
sudo pacman -S --asexplicit --noconfirm qemu ;
```


**Installer Virt-Manager**
```bash
sudo pacman -S --asexplicit --noconfirm libvirt edk2-ovmf virt-manager ;
```

**Utiles**
```bash
sudo pacman -S --asexplicit --noconfirm dnsmasq ebtables usbutils ;
```

**Commandes:**
```bash
virt-manager
```

Note:
- Virt-Manager à ses interfaces Down sur les ponts.
- Il faut crée le pont à la main via systemd

