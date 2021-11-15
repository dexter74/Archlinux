## Présentation

Pour mettre en place l'hyperviseur, il faut installer les paquets, démarrer les services liés et mettre en place un pont pour les VM est accès à internet.

[Création du pont](https://github.com/dexter74/Archlinux/blob/main/Documentation/R%C3%A9seau_Ponts.MD)


### I. Vérification de la prise en charge de la Virtualisation, des modules KVM

**Check le CPU**
```
LC_ALL=C lscpu | grep Virtualization ;
```

**Modules Virtio**
```
zgrep CONFIG_KVM /proc/config.gz ; # Vérifier si le noyaux gère virtio
lsmod | grep virtio ; # Vérifier si le module est chargé
modprobe virtio     ; # Charger le module (temporaire)
modprobe -r virtio  ; # Décharger le module (Si besoin) 
```

### II. Activation des modules (SystemD)

```
echo "virtio_net" > /etc/modules-load.d/virtio-net.conf
```

