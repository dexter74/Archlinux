
**Information**

```bash
systemctl   : contrôle systemd et gère les unités.
journalctl  : consultation du journal de systemd.
loginctl    : contrôle des sessions utilisateurs (systemd-logind).

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

[Erreur dans le chargement](https://wiki.archlinux.fr/systemd)

**display-manager.service**
```
ln -s '/usr/lib/systemd/system/sdd.service' '/etc/systemd/system/display-manager.service'
systemctl enable --now display-manager.service ;
```


syslog.service
