Log en couleur:
```
pacman -S --asexplicit --noconfirm ccze 
```

tail -f /var/log/syslog | ccze
tail -100 /var/log/syslog | ccze -A

