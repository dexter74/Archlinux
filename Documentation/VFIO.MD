------------------------------------------------------------------------------------------------------------------------------
# I. Prise en charge du IOMMU (GRUB / SystemD-Boot)

### A. Grub
```bash
nano /etc/default/grub
 > GRUB_CMDLINE_LINUX_DEFAULT=""
 > amd_iommu=on iommu=pt
 > intel_iommu=on iommu=pt 
grub-mkconfig -o /boot/grub/grub.cfg
```

------------------------------------------------------------------------------------------------------------------------------
# II. Récupération des informations sur les Groupes IOMMU 
```bash
for g in `find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V`; do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
```

------------------------------------------------------------------------------------------------------------------------------
# [III. Installation des paquets](https://github.com/dexter74/Archlinux/blob/main/APPZ/Outils/Hyperviseur.MD)


------------------------------------------------------------------------------------------------------------------------------
#  IV. Démarrage de la Carte-Réseau
```bash
virsh net-start     default ;
virsh net-autostart default ;
```

### A. Caractéristique de la VM
```bash
Le Chipset          : Q35
Le Firmware         : UEFI
Modèle de CPU       : host-passthrough
Typologie du CPU    : -1
Périphérique SATA   : Virtio (Disque)
Périphérique NIC    : Virtio
Périphérique CDROM0 : /.../win10.iso
Périphérique CDROM1 : /.../Virtio-last.iso
```

### B. Explication sur l'installation de Windows
```bash
Installé Windows sans GPU.
Lors de l'installation de Windows, charger le pilote Virtio . (virtio-iso/amd64/win10)
Sous Windows, installer les pilotes manquant.
VFIO le GPU et vérifier la configuration
Ajouter le matériel (GPU, Audio, etc...)
Démarrer la VM
Le signale de sortie vidéo est sur le GPU. (Branche l'écran sur le GPU correspondant pour avoir l'image.
```

### C. Ajout d'un Hooks Libvirt
Les hooks Libvirt automatisent le processus d'exécution de tâches spécifiques lors du changement d'état de la machine virtuelle.


### D. Création des dossiers et des fichiers vide (permissions incluse)

Définir le nom de la VM (La VM devra porter le même nom)
```
KVM_NAME="Window10
```

```bash
mkdir -p //etc/libvirt/hooks
mkdir -p /etc/libvirt/hooks/qemu.d/$KVM_NAME/prepare/begin
mkdir -p /etc/libvirt/hooks/qemu.d/$KVM_NAME/release/end

touch /etc/libvirt/hooks/qemu
touch /etc/libvirt/hooks/kvm.conf
touch /etc/libvirt/hooks/qemu.d/$KVM_NAME/release/end/stop.sh
touch /etc/libvirt/hooks/qemu.d/$KVM_NAME/prepare/begin/start.sh

chmod +x /etc/libvirt/hooks/qemu
chmod +x /etc/libvirt/hooks/qemu.d/$KVM_NAME/prepare/begin/start.sh
chmod +x /etc/libvirt/hooks/qemu.d/$KVM_NAME/release/end/stop.sh
```

### E. qemu
```bash
#!/bin/bash

GUEST_NAME="$1"
HOOK_NAME="$2"
STATE_NAME="$3"
MISC="${@:4}"

# Répertoire de Base
BASEDIR="$(dirname $0)"

# Emplacement Hook
HOOKPATH="$BASEDIR/qemu.d/$GUEST_NAME/$HOOK_NAME/$STATE_NAME"

set -e # Si un script se termine avec une erreur, nous devrions également le faire.

# Vérifier s'il s'agit d'un fichier exécutable non vide
if [ -f "$HOOKPATH" ] && [ -s "$HOOKPATH"] && [ -x "$HOOKPATH" ]; then
    eval \"$HOOKPATH\" "$@"
elif [ -d "$HOOKPATH" ]; then
    while read file; do
        # check for null string
        if [ ! -z "$file" ]; then
          eval \"$file\" "$@"
        fi
    done <<< "$(find -L "$HOOKPATH" -maxdepth 1 -type f -executable -print;)"
fi
```

### F. Configurer les Hooks de Libvirt (kvm.conf)
Ce fichier de configuration permet de créer des variables lisibles par les scripts ci-dessous.


```bash
# Vram en Mo
VM_MEMORY=13312

# Adresse PCI du GPU (Vidéo, Audio, USB et Serial)
VIRSH_GPU_VIDEO=pci_0000_09_00_0
VIRSH_GPU_AUDIO=pci_0000_09_00_1
#VIRSH_USB=pci_0000_09_00_2
#VIRSH_SERIAL_BUS=pci_0000_09_00_3
```

La valeur VM_MEMORY est la quantité exacte de Mémoire-Vive qui servira pour la pagination.


------------------------------------------------------------------------------------------------------------------------------
# V. Création des scripts d'autmatisation

**Observation:**
```
- Il ne décharge pas le module Nouveau
- Il décharge le gestionnaire de fenêtre SDDM.
```

### A. **start.sh**
```bash
#!/bin/bash
################################################################################
# Utile pour lire la sortie lors du débogage
set -x
################################################################################
# Chargements des variables
source "/etc/libvirt/hooks/kvm.conf"
################################################################################
# Arrêt du gestionnaire de Fenêtres
systemctl stop sddm.service
################################################################################
# Dissocier les consoles VT
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
################################################################################
# Dissocier EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
################################################################################
# Patienter 5 sec
sleep 5
################################################################################
# Décharger tous les pilotes Nvidia
modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia_uvm
modprobe -r nvidia
################################################################################
# Dissocier le GPU du pilote d'affichage
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
virsh nodedev-detach $VIRSH_USB
virsh nodedev-detach $VIRSH_SERIAL_BUS
################################################################################
# Charger le module de noyau VFIO
modprobe vfio-pci
```

### B. **Stop**
```bash
#!/bin/bash
set -x
################################################################################
# Chargements des variables
source "/etc/libvirt/hooks/kvm.conf"
################################################################################
# Décharger le pilote de noyau VFIO-PCI
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio
################################################################################
# Reliez le GPU au pilote Nvidia 
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO
virsh nodedev-reattach $VIRSH_USB
virsh nodedev-reattach $VIRSH_SERIAL_BUS
################################################################################
# Reliez  la console VT au Système
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind
################################################################################
# Lier EFI-Framebuffer
nvidia-xconfig --query-gpu-info > /dev/null 2>&1
echo "efi-framebuffer.0"        > /sys/bus/platform/drivers/efi-framebuffer/bind
################################################################################
# Chargez tous les pilotes Nvidia
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe drm_kms_helper
modprobe drm
modprobe nvidia_uvm
modprobe nvidia
################################################################################
# Redémarrer le gestionnaire d'affichage
systemctl start sddm.service ;
```

```bash

```



```bash
```



```bash
```



```bash
```



```bash
```




------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```

------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```


------------------------------------------------------------------------------------------------------------------------------
#  
```bash
```






````
https://www.youtube.com/watch?v=CwEVj00SwYM
https://gitlab.com/Mageas/vfio-single-gup-passthrough
````
