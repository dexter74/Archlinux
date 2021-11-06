
**Information**

```bash
systemctl   : contrôle systemd et gère les unités.
journalctl  : consultation du journal de systemd.
loginctl    : contrôle des sessions utilisateurs (systemd-logind).

systemctl --version
systemctl reboot
systemctl poweroff
systemctl suspend
systemctl hibernate

systemctl list-units --all ; # Une unité = Un service
systemctl start <unit>
systemctl stop <unit>
systemctl restart <unit>
systemctl reload <unit>
systemctl status <unit>
systemctl enable <unit>
systemctl disable <unit>
systemctl list-dependencies [<unit>]
systemctl restart avahi-daemon.service
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

**systemd-timesyncd.service**
```
La configuration se fait dans /etc/systemd/timesyncd.conf
systemctl enable --now systemd-timesyncd.service ;
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

[Systemd-LancementConteneur](https://www.linuxtricks.fr/wiki/wiki.php?title=systemd-demarrer-une-distribution-comme-un-conteneur)

[Services et serveurs](https://www.linuxtricks.fr/wiki/services-et-serveurs) (Apache, dnsmasq, jal2fail ...)

[NetworkManager](https://doc.fedora-fr.org/wiki/Le_service_network)

[nmcli](https://sysreseau.net/networkmanager-nmcli-nmtui/)

[VFIO](https://hackmd.io/@edingroot/SkGD3Q7Wv#B-Enable-the-IOMMU-for-systemd-boot-Proxmox-on-UEFI)
