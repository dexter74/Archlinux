## Documentation :

[NetDev](https://www.freedesktop.org/software/systemd/man/systemd.netdev.html)

[NetWork](https://www.freedesktop.org/software/systemd/man/systemd.network.html)



## I. Récupérer les informations du réseau

**Paquet** (brctl)
```
sudo pacman -S --asexplicit --noconfirm bridge-utils netctl ;
```

**Commande**
```bash
clear ;
echo "###################################################################"
echo "Etat des Bridges:"
brctl show ;
echo "###################################################################"
echo "Etat de la gestion des interfaces:"
networkctl ;
echo "########################################################################################################################"
echo "Informations sur les interfaces:"
ip link | grep -i "down\|up" ;
echo "########################################################################################################################"
echo "IP Route:"
ip route ;
echo "#################################################################"
```


-------------------------------------------------------------------------------------------------------------------------------------------------
## II. Mise en place du Pont

#### A. Purge de la configuration actuel
```bash
clear ;
rm -f /etc/systemd/network/* ;
```

#### B. Création du Pont
```bash
echo "[Match]
Host=archlinux
Virtualization=yes
Architecture=x86-64
KernelVersion=5.14.16-arch1-1

[NetDev]
Description=Interface pont 0
Name=br0
Kind=bridge
MTUBytes=1500
MACAddress=00:15:5d:38:01:06" > /etc/systemd/network/50-br0.netdev
```

#### B. Configurer le réseau du pont
```bash
echo "[Match]
Name=br0

[Network]
Description=Configuration du pont
DHCP=no
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=192.168.1.40
DNS=192.168.1.1
Domains=lan" > /etc/systemd/network/50-br0.network
```

#### C. Reliée le pont avec l'interface Physique
```bash
echo "[Match]
Name=eth0
Type=ether
MACAddress=00:15:5d:38:01:06

[Network]
Description=Lier la physique au pont
Bridge=br0" > /etc/systemd/network/50-br0-eth0.network
```



**Résultat finale:**
```
###################################################################
Etat des Bridges
bridge name     bridge id               STP enabled     interfaces
br0             8000.00155d380106       no              eth0
###################################################################
Etat de la gestion des interfaces
IDX LINK TYPE     OPERATIONAL SETUP
  1 lo   loopback carrier     unmanaged
  2 eth0 ether    enslaved    configured
  3 br0  bridge   routable    configured

3 links listed.
########################################################################################################################
Informations sur les interfaces:
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
3: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
########################################################################################################################
IP Route
default via 192.168.1.1 dev br0 proto static
192.168.1.0/24 dev br0 proto kernel scope link src 192.168.1.109
#################################################################
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

