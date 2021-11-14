
**Installer Qemu**
```bash
sudo pacman -S qemu ;
```


**Installer Virt-Manager**
```bash
sudo pacman -S libvirt edk2-ovmf virt-manager ;
```

**Utiles**
```bash
sudo pacman -S dnsmasq ebtables usbutils ;
```

**Commandes:**
```bash
virt-manager
```

**Configuration du Réseau**
```
cd /etc/systemd/network/  ;
rm /etc/systemd/network/* ;

################
# IP Dynamique #
################
echo "[Match]
Name=eth0

[Network]
DHCP=ipv4" > 20-dhcp.network

###############
# IP Statique #
###############
echo "[Match]
Name=eth0

[Network]
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=192.168.1.1
DNS=192.168.1.40" > 10-static-eth0.network ;

systemctl restart systemd-networkd ;
systemctl status systemd-networkd  ;
systemctl status systemd-resolved  ;



##############################
# Configuration en mode Pont #
##############################

# Création du Pont
echo "[NetDev]
Name=br0
Kind=bridge" > /etc/systemd/network/bridge-br0.netdev

# Reliée le pont
echo "[Match]
Name=eth0

[Network]
Bridge=br0" > /etc/systemd/network/bridge-br0-slave.network

# Configurer le pont
echo "[Match]
Name=br0

[Network]
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=192.168.1.1
DNS=192.168.1.40" > /etc/systemd/network/bridge-br0.network
```

