[Guide](https://www.freedesktop.org/software/systemd/man/systemd.network.html)
[Info](https://github.com/systemd/systemd/blob/a2088fd025deb90839c909829e27eece40f7fce4/NEWS)
[topic](https://qastack.fr/server/753977/how-to-properly-permanent-enable-ip-forwarding-in-linux-with-systemd)
[GestionI nterface](https://man.archlinux.org/man/systemd.network.5) (ActivationPolicy=)

# Autoriser le Forward :
```
clear;
sudo /sbin/sysctl -w net.ipv4.ip_forward=1 ; # Temporaire

sudo echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/systcl.conf ; # Permanent
cat /proc/sys/net/ipv4/ip_forward ; 
```

**Configuration du Client** (nano /etc/systemd/network/99-wg0.netdev )
```
[NetDev]
Name=wg0
Kind=wireguard
Description=Tunnel wg0 Wireguard

[WireGuard]
ListenPort = XXXX
PrivateKey = XXXXXXXXXXXXXXXXX
DNS = 192.168.1.31
MTU = 1500

[WireGuardPeer]
PublicKey = XXXXXXXXXXXXXXXXX
PresharedKey = XXXXXXXXXXXXXXXXX
AllowedIPs = X192.168.1.0/24, 0.0.0.0/0
Endpoint = <mon_DNS>:51820
PersistentKeepalive = 25
```


**Interface wg0** (Administré par Systemd-NetworkD )
```
/etc/systemd/network/99-wg0.network
[Match]
Name=wg0

[Link]
# Interface Down par défaut
ActivationPolicy=manual

[Network]
Address = 192.168.2.2/24
```

**Permission**
```
chown root:systemd-network /etc/systemd/network/99-*.netdev
chmod 0640 /etc/systemd/network/99-*.netdev
```

**Démarrer interface**
```
ip link set wg0 up
```


**Expérimental**
```
systemctl edit wireguard.service --full --force
```


```
[Unit]
Description=Gestion de l'interface Wireguard
After=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/ip link set wg0 up
ExecStop=/usr/bin/ip link set wg0 down

[Install]
WantedBy=default.target

systemctl daemon-reload ;
systemctl enable  --now wireguard ;
systemctl disable --now wireguard ;
systemctl status wireguard ;
```


**Script Commutateur**

Ce script permet de switcher le VPN. (ON / OFF)
Il suffit de crée un raccourcis qui pointe vers le script.

````bash
echo '
###########################################
# Script pour commuter Wireguard (On/OFF) #
###########################################
#
# Nettoyage de la console
clear ;
#
# Déclarer une variable
WG_STATUS=$(systemctl status wireguard.service | grep "Active:" | cut -c14-50 | cut -d "(" -f 1)
#
# Si le service est UP   : exited
# Si le service est Down : dead
#
if [ $WG_STATUS == "inactive" ]
  then
    systemctl start wireguard.service 
    echo "Le service est actif"
  else
    systemctl stop wireguard.service
    echo "Le service est inactif"
fi ' > wireguard.sh ; chmod +x wireguard.sh ; sh wireguard.sh ;
````
