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
```
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
KVM_NAME="Windows10"
```

```bash
mkdir -p /etc/libvirt/hooks
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
Ce fichier est à adapter.


```bash
# Vram en Mo
VM_MEMORY=13312

# Adresse PCI du GPU (Vidéo, Audio, USB et Serial)
VIRSH_GPU_VIDEO=pci_0000_09_00_0
VIRSH_GPU_AUDIO=pci_0000_09_00_1
VIRSH_USB=pci_0000_09_00_2
VIRSH_SERIAL_BUS=pci_0000_09_00_3
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


**/etc/libvirt/qemu.conf**
```xml
# Utilisateur qui lancera Qemu
user = "root"

# Groupe: (kvm par défaut)
# group = "root"

cgroup_device_acl = [
    "/dev/input/by-id/usb-SEMICO_USB_Keyboard-event-kbd",
    "/dev/input/by-id/usb-Full-Speed_Mouse_Full-Speed_Mouse-event-mouse",
    "/dev/null", "/dev/full", "/dev/zero",
    "/dev/random", "/dev/urandom",
    "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
    "/dev/rtc","/dev/hpet", "/dev/sev"
]
```







------------------------------------------------------------------------------------------------------------------------------
# VI. Récupération des Events ID du matériel. (Clavier et la Souris)
Pour pouvoir attribuer le Clavier, souris il faut pour celà récupérer les Event ID du matériel.

### A. Lister le matériel
```bash
ls /dev/input/by-id
ls /dev/input/by-id | grep "event-mouse\|Keyboard-event"
```


### B. Ecouter le matériel
Pour écouter le matériel, il suffit de faire un cat <chemin vers l'event ID> puis de faire de l'activité sur le matériel concernés. (Prendre les event id contenenant le mot "event")

Si c'est bon le terminal affichera un contenu.

Exemple: 
- La souris  : il suffit de la bouger
- Le clavier : il suffit de taper

```bash
cat "/dev/input/by-id/..."
```

------------------------------------------------------------------------------------------------------------------------------
# VII. Configuration de la VM (XML)


### A. Activation de l'édtion XML
Virt-manager > Edit > Préférence > "Enable Edit XML"

### B. Edition de la VM - Partie I (XML)

**Ligne de code à remplacer** (1ère ligne)
```xml
<domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
```

**Code à ajouter dans la zone <devices>..... </devices>**
```xml
  <input type='mouse' bus='virtio'/>
  <input type='keyboard' bus='virtio'/>
```

### C. Edition de la VM - Partie II (XML)
Cette partie est à adapter selon votre configuration.

Exemple
```
- Le clavier à comme Event-ID : usb-Full-Speed_Mouse_Full-Speed_Mouse-event-mouse 
- La souris  à comme Event-ID : usb-SEMICO_USB_Keyboard-event-kbd
```

**Code à ajouter après:** </domain>
```xml
  <qemu:commandline>
    <qemu:arg value='-object'/>
    <qemu:arg value='input-linux,id=mouse1,evdev=/dev/input/by-id/usb-Full-Speed_Mouse_Full-Speed_Mouse-event-mouse'/>
    <qemu:arg value='-object'/>
    <qemu:arg value='input-linux,id=kbd1,evdev=/dev/input/by-id/usb-SEMICO_USB_Keyboard-event-kbd,grab_all=on,repeat=on'/>
  </qemu:commandline>
```

### D. Edition de la VM - Partie III (XML)

Observation:
```
- L'audio de la VM peut être acheminé vers l'hôte. Vous avez besoin de Pulseaudio (ou Pipewire avec pipewire-pulse). 
- Le code semnble être pour PulseAudio.
```

**Code à ajouter dans la section <qemu:commandline> ....... </qemu:commandline>
```xml
    <qemu:arg value="-device"/>
    <qemu:arg value="ich9-intel-hda,bus=pcie.0,addr=0x1b"/>
    <qemu:arg value="-device"/>
    <qemu:arg value="hda-micro,audiodev=hda"/>
    <qemu:arg value="-audiodev"/>
    <qemu:arg value="pa,id=hda,server=/run/user/1000/pulse/native"/>
```

### E. Détection de virtualisation de pilote de carte vidéo :
```xml
...
<features>
  ...
  <hyperv>
    ...
    <vendor_id state='on' value='buttplug'/>
    ...
  </hyperv>
  ...
</features>
...
```

```xml

...
<features>
  ...
  <kvm>
    <hidden state='on'/>
  </kvm>
  <ioapic driver="kvm"/>
  ...
</features>
...
```




------------------------------------------------------------------------------------------------------------------------------
#  IX. Configuration du CPU
```bash
lscpu | grep -i "nom de modèle" ;
lscpu | grep -i "cœur" ;
lscpu | grep -i "numa" ;
lscpu -e | cut -c1-20  ;
```
La colonne CPU sont les Thread
La colonne CORE sont les Thread.


```
Nom de modèle      : AMD Ryzen 5 3600 6-Core Processor
Thread(s) par cœur           : 2
Cœur(s) par socket           : 6
Nœud(s) NUMA                 : 1
Nœud NUMA 0 de processeur(s) : 0-11

CPU NODE SOCKET CORE
  0    0      0    0
  1    0      0    1
  2    0      0    2
  3    0      0    3
  4    0      0    4
  5    0      0    5
  6    0      0    0
  7    0      0    1
  8    0      0    2
  9    0      0    3
 10    0      0    4
 11    0      0    5
```

### Ajout du code XML après </feature>

| Core |   Thread  |
| ---- | --------- |
|  0   |   0, 6    |
|  1   |   1, 7    |
|  2   |   2, 8    |
|  3   |   3, 9    |
|  4   |   4, 10   |
|  5   |   5, 11   |

```
Core 0: Réserver à l'hôte
Core 1: Réserver à la VM
Core 2: Réserver à la VM
Core 3: Réserver à la VM
Core 4: Réserver à la VM
Core 5: Réserver à la VM

Soit un totale de 5 Core pour la VM soit 10 Thread. (2 threads / core)
La valeur Vcpu seront les références CPU dans la VM. (0-9 => 10 Core)
La valeur cpuset sont les correspondances Thread avec le CPU.
```

```xml
  <vcpu placement="static">10</vcpu>
  <iothreads>1</iothreads>
  <cputune>
    <vcpupin vcpu="0" cpuset="1"/>
    <vcpupin vcpu="1" cpuset="7"/>
    <vcpupin vcpu="2" cpuset="2"/>
    <vcpupin vcpu="3" cpuset="8"/>
    <vcpupin vcpu="4" cpuset="3"/>
    <vcpupin vcpu="5" cpuset="9"/>
    <vcpupin vcpu="6" cpuset="4"/>
    <vcpupin vcpu="7" cpuset="10"/>
    <vcpupin vcpu="8" cpuset="5"/>
    <vcpupin vcpu="9" cpuset="11"/>
    <emulatorpin cpuset="0,6"/>
    <iothreadpin iothread="1" cpuset="0,6"/>
  </cputune>
```

**Remplacer la section CPU (<cpu> ... </cpu>)**
La valeur cores sont le nombre de core attribué à la VM.
La valeur Thread est le nombre par core . (2 Thread / core > 5 core x 2 = 10 thread)
```xml
  <cpu mode="host-passthrough" check="none" migratable="on">
    <topology sockets="1" dies="1" cores="5" threads="2"/>
    <cache mode="passthrough"/>
    <feature policy="require" name="topoext"/>
  </cpu>
```

**Hyper-V Enlightenments**
Les éclaircissements Hyper-V aident la VM invitée à gérer les tâches de virtualisation.


------------------------------------------------------------------------------------------------------------------------------
#  
```xml
...
  <qemu:commandline>
   <qemu:arg value="-rtc"/>
    <qemu:arg value="base=localtime"/>
    <qemu:arg value="-cpu"/>
    <qemu:arg value="host,host-cache-info=on,kvm=off,l3-cache=on,kvm-hint-dedicated=on,migratable=no,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=buttplug,+invtsc,+topoext"/>
  </qemu:commandline>
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
