## I. Récupérer les informations du réseau

[Guide](https://www.xmodulo.com/switch-from-networkmanager-to-systemd-networkd.html)

[Article 1](https://unix.stackexchange.com/questions/411936/configuring-a-bridge-interface-with-systemd-networkd)




**Paquet** (brctl)
```
sudo pacman -S --asexplicit --noconfirm bridge-utils netctl ;
```


**Commande**
```bash
ip link | grep -i "down\|up"
```
**Résultat:**
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
```

Ancien:
```
##################################################################
echo "[Match]
Name=eth0

[Network]
DHCP=ipv4" > /etc/systemd/network/20-dhcp.network
##################################################################
echo "[Match]
Name=eth0

[Network]
Address=192.168.1.109/24
Gateway=192.168.1.1
DNS=192.168.1.1
DNS=192.168.1.40" > /etc/systemd/network/10-static-eth0.network ;
##################################################################
systemctl restart systemd-networkd ;
systemctl status systemd-networkd ;
```




## II. Mise en place du Pont

#### A. Purge de la configuration actuel
```
rm -f /etc/systemd/network/* ;
```

#### B. Création du Pont
```
echo "[NetDev]
Name=br0
Kind=bridge
MACAddress=00:15:5d:38:01:06
" > /etc/systemd/network/50-br0.netdev
```

#### C. Reliée le pont avec l'interface Physique
```
echo "[Match]
MACAddress=00:15:5d:38:01:06
Name=eth*

[Network]
Bridge=br0" > /etc/systemd/network/50-network-interface.network
```

#### D. Configurer le réseau du pont
```
echo "[Match]
Name=br0

[Network]
DHCP=no
DNS=192.168.1.1
Address=192.168.1.109/24
Gateway=192.168.1.1
DNS=192.168.1.1" > /etc/systemd/network/50-br0.network
```

#### E. Vérification de la configuration :
```
```

#### F. Redémarrer le service NetworkD de SystemD.
```bash
systemctl restart systemd-networkd ;
systemctl status systemd-networkd ;
```

#### G. Vérification
```bash
systemctl status systemd-networkd ;
ip link | grep -i "down\|up"
```


