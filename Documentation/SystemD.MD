**Home**
```bash
systemctl enable systemd-homed-activate
```


**Service et Daemon Réseau**
A vérifier: Quel Service réseau doit être activer ? (iwd, wpa_supplicant, systemd-networkd

NetworkD:
```bash
echo "[Match]
Name=wlan0

[Network]
DHCP=Yes" > /etc/systemd/network/20-dhcp.network ;
```

```bash
systemctl status systemd-networkd ;
systemctl status iwd ;
systemctl status wpa_supplicant ;
```

**Synchronisation de l'heure** ([Conflit](https://www.linuxtricks.fr/wiki/systemd-le-ntp-avec-systemd-timesyncd))

La configuration se fait dans /etc/systemd/timesyncd.conf ;

```
systemctl disable ntpd ;
systemctl enable systemd-timesyncd ;
```

**Résolveur DNS**
```
systemctl enable systemd-resolved ;
```



**Service Utilisateur**
```
ls -la /usr/lib/systemd/user | cut -c44-100 ;
systemctl --user --all | grep dead | grep ".service" | cut -c1-50 ;
systemctl --user enable --now
```

**Information**
```bash
systemctl   : contrôle systemd et gère les unités.
journalctl  : consultation du journal de systemd.
loginctl    : contrôle des sessions utilisateurs (systemd-logind).


systemctl --global enable --now 

systemctl --version
systemctl reboot
systemctl poweroff
systemctl suspend
systemctl hibernate

systemctl unmask

systemctl list-units --all ; # Une unité = Un service
systemctl start <unit>
systemctl stop <unit>
systemctl restart <unit>
systemctl reload <unit>
systemctl status <unit>
systemctl enable <unit>
systemctl disable <unit>
systemctl list-dependencies
systemctl restart avahi-daemon
systemctl status /home
systemctl status /dev/sda2
```


-------------------------------------------------------------------------------------------------
[Erreur dans le chargement](https://wiki.archlinux.fr/systemd)

**display-manager.service**
```
ln -s '/usr/lib/systemd/system/sdd.service' '/etc/systemd/system/display-manager.service' ;
systemctl enable --now display-manager.service ;
```



**Service en Erreur / Non Activ** (A regarder)
```
systemctl -t service -a --full | grep error ;
systemctl -t service -a --full | grep dead ;
```

-------------------------------------------------------------------------------------------------
**Editer un service**
```
systemctl --user edit <nom du service>.service --full ;
```

**[Service des Users](https://wiki.archlinux.fr/Systemd/utilisateur)**
```
/usr/lib/systemd/user/ pour les unités fournis par des paquets.
/etc/systemd/user/ pour les unités systèmes installés par l'administrateur du système.
~/.config/systemd/user/ pour les unités de l'utilisateur.
```



**[Création de service Utilisateur](https://doc.ubuntu-fr.org/creer_un_service_avec_systemd)** ([Syntax](https://www.linuxtricks.fr/wiki/systemd-creer-des-services-timers-unites) | [Timers](https://www.linuxtricks.fr/wiki/systemd-creer-des-services-timers-unites))
```
systemctl --user edit <nom du service>.service --full --force ;
```
-------------------------------------------------------------------------------------------------
**Type de services systemd**
```
Un service de type simple (type par défaut) lance un processus principal
n service de type forking, lance un processus père qui créera un processus fils dans le cadre de son démarrage.
```

```
systemctl disable --now NetworkManager ;
systemctl enable --now systemd-networkd ;
systemctl enable --now systemd-resolved ;
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf ;
```

[Configurer le réseau EASY](https://www.xmodulo.com/switch-from-networkmanager-to-systemd-networkd.html)

[Systemd-Lancement Conteneur](https://www.linuxtricks.fr/wiki/wiki.php?title=systemd-demarrer-une-distribution-comme-un-conteneur)

[Services et serveurs](https://www.linuxtricks.fr/wiki/services-et-serveurs) (Apache, dnsmasq, jal2fail ...)

[NetworkManager](https://doc.fedora-fr.org/wiki/Le_service_network)

[nmcli](https://sysreseau.net/networkmanager-nmcli-nmtui/)

[VFIO](https://hackmd.io/@edingroot/SkGD3Q7Wv#B-Enable-the-IOMMU-for-systemd-boot-Proxmox-on-UEFI)

[Systemd-Option](https://github.com/systemdaemon/systemd/blob/master/src/linux/Documentation/x86/x86_64/boot-options.txt)
