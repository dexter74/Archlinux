**Activation du service Services**
```bash
systemctl enable --now iwd.service ;
systemctl status --now iwd.service ;
```

**Se connecter à IWD**
```
iwctl
```
**Lister le matériel Wi-FI**
```
device list
```


**Scanner les réseaux Wi-FI**
```
station wlan0 scan ;
```


**Résultat du Scan des réseaux WI-FI**
```
station wlan0 get-networks ;
```

**Se connecter au Réseau Wi-FI**
```
station device connect ASUS_A8_5G ;
```

**Se connecter directement**
```
iwctl --passphrase Azerty74@1213 station wlan0 connect ASUS_A8_5G ;
```

**Information sur la connexion au réseau**
```
station wlan0 show ;
```

**Demander une IP**
```
dhclient wlan0 ; ip add | grep -i wlan0 | grep -i UP ;
```


-------------------------------------------
[linuxtricks]()https://www.linuxtricks.fr/wiki/systemd-le-reseau-avec-systemd-networkd
[askubuntu](https://askubuntu.com/questions/891694/systemd-networkd-daemon-does-not-start-the-dhcp-client)

**Activer la demande de DHCP** (Alpha)
```
systemctl disable --now NetworkManager.service ;
systemctl enable --now systemd-networkd.service ;
```

```
# /etc/systemd/network/20-dhcp.network

[Match]
Name=wlan0

[Network]
DHCP=Yes
```
