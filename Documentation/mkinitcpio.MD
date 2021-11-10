**Hooks**
```
mkinitcpio -L # pour avoir la liste
mkinitcpio -H <hook>
```



```
nano /etc/mkinitcpio.conf

HOOKS=(base systemd autodetect modconf block lvm2 filesystems keyboard fsck)


autodetect  : Permet la détection et le lancement des modules uniquement nécessaire au système. (Indispensable)
base        : Charge le système de base. (Indispensable)
block       : Permet le chargement des blocs pour le SATA (Indispensable > A voir)
btrfs       : Permet la prise en charge des volumes btfrs
consolefont : Permet de charger la police définit dans le fichier vconsole.conf. (Cosmétique)
dmraid      : Permet de charger les modules dmraid (????)
encrypt     : Permet la prise en charge du cryptage sur la Racine. (Inutiles)
filesystems : Ce hook ajoute des modules de système de fichiers à l'image.
fsck        : Permet une amélioration sur les options de fsck.
hostdata    : Ce hook installe des fichiers de configuration spécifiques à l'hôte dans le fichier initramfs.
keyboard    : Permet la prise en charge du clavier, à placer après autodetect.
keymap      : Charge les keymaps spécifiés dans vconsole.conf au début de l'espace utilisateur. (Utiles)
lvm2        : Permet la prise en charge du LVM2
mdadm_udev  : Permet la prise en charge du raid, requière le module udev.
memdisk     : permet la détection des Disque Virtuel (memdisk)
modconf     : Permet l'installation de la configuration de modprobe. (/etc/modprobe.d)
resume      : Prise en charge de la reprise à partir du disque
sd-encrypt  : Permet à un périphérique racine crypté avec systemd initramfs.
sd-shutdown : Ajoute systemd-shutdown au fichier initramfs. C'est seulement
sd-vconsole : Ce hook ajoute le(s) keymap(s) et la police spécifiés dans vconsole.conf à l'image et les charge au début de l'espace utilisateur.
sleep       :
shutdown    :   
strip       :
systemd     :
udev        :
usr         :

```
