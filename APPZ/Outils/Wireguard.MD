[Guide](https://www.freedesktop.org/software/systemd/man/systemd.network.html)
[Info](https://github.com/systemd/systemd/blob/a2088fd025deb90839c909829e27eece40f7fce4/NEWS)
[topic](https://qastack.fr/server/753977/how-to-properly-permanent-enable-ip-forwarding-in-linux-with-systemd)


# Autoriser le Forward :
```
/sbin/sysctl -w net.ipv4.ip_forward=1 ; # Temporaire 
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/systcl.conf ; # Permanent
cat /proc/sys/net/ipv4/ip_forward ; 
```

```
/etc/systemd/network/99-wg0.netdev
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



```
/etc/systemd/network/99-wg0.network
[Match]
Name=wg0

[Link]
Unmanaged=yes

[Network]
Address = 192.168.2.2/24
```

```
chown root:systemd-network /etc/systemd/network/99-*.netdev
chmod 0640 /etc/systemd/network/99-*.netdev
```
