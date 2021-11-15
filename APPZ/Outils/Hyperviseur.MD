## Présentation

Pour mettre en place l'hyperviseur, il faut installer les paquets, démarrer les services liés et mettre en place un pont pour les VM est accès à internet.

[Création du pont](https://github.com/dexter74/Archlinux/blob/main/Documentation/R%C3%A9seau_Ponts.MD)

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Vérifier la prise en charge de la virtualisation
```
clear ;
LC_ALL=C lscpu | grep Virtualization ;
zgrep CONFIG_KVM /proc/config.gz ;
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Gestions des modules KVM (A peaufiné)

```
lsmod | grep 'kvm\|vhost_net'
modprobe vhost_net ;
modprobe kvm ;
modprobe kvm-amd ;
modprobe kvm-intel ;
echo "vhost_net
kvm" > /etc/modules-load.d/kvm.conf ;
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Installation de KVM
```
pacman -S --asexplicit --noconfirm qemu ;
pacman -S --asexplicit --noconfirm virt-manager ;
pacman -S --asexplicit --noconfirm vde2 ;
pacman -S --asexplicit --noconfirm dnsmasq ;
pacman -S --asexplicit --noconfirm bridge-utils ;
pacman -S --asexplicit --noconfirm openbsd-netcat ;
pacman -S --asexplicit ebtables ;
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Configurer KVM

#### A. Edition du fichier libvirtd.conf
```
nano /etc/libvirt/libvirtd.conf ;
```

#### B. Décommenter les lignes
```
unix_sock_group = "libvirt"
unix_sock_ro_perms = "0777"
```

#### C. Autoriser un utilisateur à lancer KVM
```
usermod -a -G libvirt marc ;
newgrp libvirt ;
```


-----------------------------------------------------------------------------------------------------------------------------------------------
### IV Activation du service LibVirtd
```
systemctl enable --now libvirtd ;
systemctl restart libvirtd ;
systemctl status libvirtd ;
```












-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Prise en charge réseau

[Guide](https://linuxconfig.org/how-to-use-bridged-networking-with-libvirt-and-kvm)

[Important](https://code.lardcave.net/2019/07/20/1/)


#### A. Lister les réseaux
```
sudo virsh net-list --all
```

#### B. Activation du réseau
```
virsh net-start default
virsh net-autostart default
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### X 
```
```




-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Nested Virtualisation (SystemD)
```
echo "" > /etc/modules-load.d/kvm.conf ;
```
