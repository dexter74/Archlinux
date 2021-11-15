## I. Récupérer les informations du réseau

[Guide](https://www.xmodulo.com/switch-from-networkmanager-to-systemd-networkd.html)

[Article 1](https://unix.stackexchange.com/questions/411936/configuring-a-bridge-interface-with-systemd-networkd)


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


-------------------------------------------------------------------------------------------------------------------------------------------------
## II. Mise en place du Pont

#### A. Purge de la configuration actuel
```
clear ;
rm -f /etc/systemd/network/* ;
```

#### B. Création du Pont
```
echo "[NetDev]
Name=br0
Kind=bridge
MACAddress=00:15:5d:38:01:06" > /etc/systemd/network/50-br0.netdev ;
```

#### C. Reliée le pont avec l'interface Physique
```
echo "[Match]
Name=eth*
MACAddress=00:15:5d:38:01:06

[Network]
Bridge=br0" > /etc/systemd/network/50-network-interface.network ;
```

#### D. Configurer le réseau du pont
```
echo "[Match]
Name=br0

[Network]
DHCP=no
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=192.168.1.40
DNS=192.168.1.1" > /etc/systemd/network/50-br0.network ;
```

#### E. Vérification de la configuration :
```
clear ;
echo "############################"
cat /etc/systemd/network/50-br0.netdev ;
echo "############################"
cat /etc/systemd/network/50-network-interface.network ;
echo "############################"
cat /etc/systemd/network/50-br0.network ;
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
-------------------------------------------------------------------------------------------------------------------------------------------------








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

