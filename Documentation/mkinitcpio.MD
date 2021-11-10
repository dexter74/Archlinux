**Hooks**
```
mkinitcpio -L # pour avoir la liste
mkinitcpio -H <hook>
```


```
nano /etc/mkinitcpio.conf ; mkinitcpio -p linux

Tutorial : HOOKS=(base systemd autodetect modconf block lvm2 filesystems keyboard fsck)
Perso    : HOOKS=(base systemd autodetect modconf block lvm2 filesystems udev  resume fsck keyboard keymap sd-vconsole)

```

```
autodetect  : Permet la détection et le lancement des modules uniquement nécessaire au système. (Indispensable)
base        : Charge le système de base. (Indispensable)
block       : Permet le chargement des blocs pour le SATA (Indispensable > A voir)
btrfs       : Permet la prise en charge des volumes btfrs
consolefont : Permet de charger la police définit dans le fichier vconsole.conf. (Cosmétique)
dmraid      : Permet de charger les modules dmraid (????)
encrypt     : Permet la prise en charge du cryptage sur la Racine. (Inutiles)
filesystems : Ce hook ajoute des modules de système de fichiers à l'image.
fsck        : Permet une amélioration sur les options de fsck.
hostdata    : Iinstalle des fichiers de configuration spécifiques à l'hôte dans le fichier initramfs.
keyboard    : Permet la prise en charge du clavier, à placer après autodetect.
keymap      : Charge les keymaps spécifiés dans vconsole.conf au début de l'espace utilisateur. (Utiles)
lvm2        : Permet la prise en charge du LVM2
mdadm_udev  : Permet la prise en charge du raid, requière le module udev.
memdisk     : permet la détection des Disque Virtuel (memdisk)
modconf     : Permet l'installation de la configuration de modprobe. (/etc/modprobe.d)
resume      : Prise en charge de la reprise à partir du disque
sd-encrypt  : Permet à un périphérique racine crypté avec systemd initramfs.
sd-shutdown : Ajoute systemd-shutdown au fichier initramfs. C'est seulement
sd-vconsole : Ajoute le(s) keymap(s) et la police spécifiés dans vconsole.conf à l'image et les charge au début de l'espace utilisateur.
sleep       : Provoque l'interruption du processus d'initialisation pendant un intervalle de temps fixe
shutdown    : Copie le contenu de l'initramfs dans /run/initramfs pour le réutiliser à l'arrêt. Cela est nécessaire lorsque /usr est monté sur une partition séparée.
strip       : Localisera et supprimera les binaires de votre image avant l'archivage et la compression. En dernière position

systemd     : Installera une configuration de base de systemd dans votre initramfs et est destiné à remplacer les crochets 'base', 'usr', 'udev' et 'resume'.
            : Ajouter base pour vous assurer qu'un shell de secours existe sur votre initramfs.

udev        : Permettant un chargement dynamique des modules et une détection fiable du périphérique racine via des balises (par exemple, UUID ou LABEL).
usr         : Cela fournit un support pour le montage de /usr via un crochet à exécution tardive.

```
