**Log en couleur**
```bash
pacman -S --asexplicit --noconfirm ccze 
```

```
tail -f /var/log/syslog | ccze grc
tail -100 /var/log/syslog | ccze -A
```

