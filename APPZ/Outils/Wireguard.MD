[Guide](https://www.freedesktop.org/software/systemd/man/systemd.network.html)
[Info](https://github.com/systemd/systemd/blob/a2088fd025deb90839c909829e27eece40f7fce4/NEWS)
[topic](https://qastack.fr/server/753977/how-to-properly-permanent-enable-ip-forwarding-in-linux-with-systemd)
[GestionInterface](https://man.archlinux.org/man/systemd.network.5) (ActivationPolicy=)

# Autoriser le Forward :
```
/sbin/sysctl -w net.ipv4.ip_forward=1 ; # Temporaire 
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/systcl.conf ; # Permanent
cat /proc/sys/net/ipv4/ip_forward ; 
```


**Configuration du Client** ( /etc/systemd/network/99-wg0.netdev )
```
[NetDev]
Name=wg0
Kind=wireguard
Description=WireGuard tunnel wg0


[WireGuard]
ListenPort = 51820
PrivateKey = wEwo7cQxT7/UwNyKyy3qQg6diTW77EvZXs6ybANaZW8=
DNS = 192.168.2.1
MTU = 1500

[WireGuardPeer]
PublicKey = AG8X3EtG4xlXoguRMemBWY4iBQFVXqpopH6yvtXqyBo=
PresharedKey = E6sqksGKeCbVWGiwOOdMUUPWY++zcmQyryNeMoJka5E=
AllowedIPs = 192.168.1.0/24, 192.168.2.0/24
Endpoint = drthrax74.ddns.net:51820
PersistentKeepalive = 25
```


**Création de l'interface wg0** (Administré par Systemd-NetworkD )
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

systemctl edit wireguard.service --full --force

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
clear ;
WG_STATUS=$(systemctl status wireguard.service | grep "Active:" | cut -c22-27)

# Start = exited
# down  = dead

if [ $WG_STATUS == "exited" ]
 then
  # Service est UP
  echo "Arrêt du service"
  systemctl stop wireguard.service  
 else
  # Service est DOWN
  echo "Démarrage du service"
  systemctl start wireguard.service
fi' > test.sh; sudo sh test.sh


````
