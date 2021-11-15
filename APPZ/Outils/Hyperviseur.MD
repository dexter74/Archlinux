## Présentation

Pour mettre en place l'hyperviseur, il faut installer les paquets, démarrer les services liés et mettre en place un pont pour les VM est accès à internet.

[Création du pont](https://github.com/dexter74/Archlinux/blob/main/Documentation/R%C3%A9seau_Ponts.MD)


-----------------------------------------------------------------------------------------------------------------------------------------------
### I. Vérifier la prise en charge de la virtualisation
```
clear ;
LC_ALL=C lscpu | grep Virtualization ;
zgrep CONFIG_KVM /proc/config.gz ;
```

```
CONFIG_KVM_GUEST=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_XEN=y
CONFIG_KVM_MMU_AUDIT=y
```

### Activation des modules KVM:
```
modprobe vhost_net

modprobe kvm
modprobe kvm-amd
modprobe kvm-intel
echo "" > /etc/modules-load.d/kvm.conf ;
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### II. Installation de KVM


```
pacman -S --asexplicit --noconfirm qemu ;
pacman -S --asexplicit --noconfirm virt-manager ;
pacman -S --asexplicit --noconfirm vde2 ;
pacman -S --asexplicit --noconfirm dnsmasq ;
pacman -S --asexplicit --noconfirm bridge-utils ;
pacman -S --asexplicit --noconfirm openbsd-netcat ;
pacman -S --asexplicit ebtables ; # Conflit avec iptables-nft et iptables
```

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Configurer KVM

#### A. Edition du fichier libvirtd.conf
```
nano /etc/libvirt/libvirtd.conf
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
### X Activation du service LibVirtd
```
systemctl enable --now libvirtd ;
systemctl restart libvirtd ;
systemctl status libvirtd ;
```



### 

-----------------------------------------------------------------------------------------------------------------------------------------------
### X. Nested Virtualisation (SystemD)
```
echo "" > /etc/modules-load.d/kvm.conf ;
```
