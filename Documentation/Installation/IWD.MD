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

**Activer la demande de DHCP** (Alpha)
```
systemctl start systemd-networkd.service ;
systemctl start systemd-networkd-wait-online.service ;
```
