## I. Récupérer les informations du réseau
**Commande**
```bash
ip link | grep -i "down\|up"
```
**Résultat:**
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
```


## II. Mise en place du Pont

#### A. Création du Pont
```
echo "[NetDev]
Name=br0
Kind=bridge" > /etc/systemd/network/bridge-br0.netdev ;
```

#### B. Reliée le pont avec l'interface Physique
```
echo "[Match]
Name=eth0

[Network]
Bridge=br0" > /etc/systemd/network/bridge-br0-slave.network ;
```

#### C. Configurer le réseau du pont
```
echo "[Match]
Name=br0

[Network]
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=192.168.1.1
DNS=192.168.1.40" > /etc/systemd/network/bridge-br0.network ;
```

#### D. Redémarrer le service NetworkD de SystemD.
```bash
systemctl restart systemd-networkd ;
```

#### E. Vérification
```bash
systemctl status systemd-networkd ;
ip link | grep -i "down\|up"
```


