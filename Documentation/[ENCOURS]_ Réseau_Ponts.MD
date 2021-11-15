## Documentation :

[NetDev](https://www.freedesktop.org/software/systemd/man/systemd.netdev.html)

[NetWork](https://www.freedesktop.org/software/systemd/man/systemd.network.html)



## I. Installer les paquets pour la gestion du pont
```
sudo pacman -S --asexplicit --noconfirm bridge-utils netctl ;
```
-------------------------------------------------------------------------------------------------------------------------------------------------
## II. Mise en place du Pont

```
BRIDGE_NAME=br0
NET_PHYS=eth0
NET_TYPE=ether
HOST=archlinux
NET_IP=192.168.1.108/24
NET_GW=192.168.1.1
NET_DNS1=192.168.1.40
NET_DNS2=192.168.1.1
NET_DOMAINE=lan
NET_MTU=1500
MAC_ADRESS=00:15:5d:38:01:06
HOST_ARCH=x86-64
KERNEL_VERSION=5.14.16-arch1-1

```

#### A. Purge de la configuration actuel
```bash
clear ;
rm -f /etc/systemd/network/* ;
```

#### B. Création du Pont
```bash
echo "[Match]
Host=$HOST
Virtualization=yes
Architecture=$HOST_ARCH
KernelVersion=$KERNEL_VERSION

[NetDev]
Description=Interface pont 0
Name=$BRIDGE_NAME
Kind=bridge
MTUBytes=$NET_MTU
MACAddress=$MAC_ADRESS" > /etc/systemd/network/50-$BRIDGE_NAME.netdev
```

#### B. Configurer le réseau du pont
```bash
echo "[Match]
Name=$BRIDGE_NAME

[Network]
Description=Configuration du pont
DHCP=no
Address=$NET_IP
Gateway=$NET_GW
DNS=$NET_DNS1
DNS=NET_DNS2
Domains=$NET_DOMAINE" > /etc/systemd/network/50-$BRIDGE_NAME.network
```

#### C. Reliée le pont avec l'interface Physique
```bash
echo "[Match]
Name=$NET_PHYS
Type=$NET_TYPE
MACAddress=$MAC_ADRESS


[Network]
Description=Lier la physique au pont
Bridge=$BRIDGE_NAME" > /etc/systemd/network/50-$BRIDGE_NAME-eth0.network
```

#### D. Service Linux

**Relance du service**
```bash
systemctl restart systemd-networkd ;
```

**Etat du service**
```bash
systemctl status systemd-networkd ;
```
-------------------------------------------------------------------------------------------------------------------------------------------------
## III. Vérication de la configuration

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

