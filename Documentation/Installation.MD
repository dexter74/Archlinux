## Guide d'installation d'ArchLinux

### Etape 1: Boot sur Archlinux
```
passwd root ; # Si le PC à une connexion, passer en SSH sur le PC
```

**Déclaration des Variables d'environnements:**
```
DISK=/dev/sda
SIZE_BOOT=+512M
SIZE_SWAP=+4G
SIZE_SYST=+20G
SIZE_HOME=+7.2G
LVM_NAMEVG=VG0
```
--------------------------------------------------------------------------------------------------------------------------------------------

### **Etape 2: Disque-Dur**

Une partition Boot pour le démarrage et une partition LVM (Swap, Racine et Home)

| Partition 1 | Partition 2 | 
| ----------- | ----------- |
| BOOT        | LVM         |

**Partition GPT**
```
(echo "g"; echo "w") | fdisk ${DISK} ;
```

**Création des Partitions de base**
```
# cfdisk $DISK
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT"; echo "t"; echo "1" ; echo "w") | fdisk $DISK ;
(echo "n"; echo "2"; echo ""; echo ""          ; echo "t"; echo "2" ; echo "30"; echo "w") | fdisk $DISK ;
```

**LVM (Volume Physique)**
```
pvcreate ${DISK}2
pvdisplay
```
**LVM (Volume Groupe)**
```

vgcreate $LVM_NAMEVG ${DISK}2
vgdisplay
```

**LVM (Volume Logique)**
```
lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG
lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG
lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG
lvdisplay
```

**Démontage**
```
umount "/mnt" "/mnt/home" "/mnt/boot"
clear
swapoff "/dev/$LVM_NAMEVG/SWAP"
df -h | grep "/mnt"
swapon -s
```

**Suppression LVM**
```
lvremove /dev/$LVM_NAMEVG/SWAP
lvremove /dev/$LVM_NAMEVG/SYSTEM
lvremove /dev/$LVM_NAMEVG/HOME
vgremove VG0
pvremove ${DISK}2
```

**Formatage :**
```
mkfs.fat -F32 ${DISK}1
mkswap        /dev/$LVM_NAMEVG/SWAP
mkfs -t ext4  /dev/$LVM_NAMEVG/SYSTEM
mkfs -t ext4  /dev/$LVM_NAMEVG/HOME
```
--------------------------------------------------------------------------------------------------------------------------------------------
### **Etape 3: Montage des Partitions**
```
swapon /dev/$LVM_NAMEVG/SWAP && swapon -s
mkdir -p /mnt/boot && mount ${DISK}1 /mnt/boot
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home
mount /dev/$LVM_NAMEVG/SYSTEM /mnt
clear
df -h | grep "/mnt" 
swapon -s
```
--------------------------------------------------------------------------------------------------------------------------------------------
### **Etape 4 : Installation de Archlinux**

Pour installer les paquets sur le system (/mnt), il suffit de taper la commande `pacstrap -i /mnt` suivis de la liste des paquets.
> Les paquets "Noyaux et Modules", "Bootloader" sont indispensables.

#### Noyaux et Modules
| [base](https://archlinux.org/packages/core/any/base/)| [linux](https://archlinux.org/packages/core/x86_64/linux/) | [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) | [linux-headers](https://archlinux.org/packages/core/x86_64/linux-headers) |
| -----------------------------------------------------| ---------------------------------------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------------------------- |

[linux-lts](#) | [linux-lts-headers](#)


#### BootLoader 
| [grub](https://archlinux.org/packages/core/x86_64/grub/) | [efibootmgr](https://archlinux.org/packages/core/x86_64/efibootmgr/) | 
| -------------------------------------------------------- | -------------------------------------------------------------------- |

#### Support Partition
| [ntfs-3g](https://archlinux.org/packages/extra/x86_64/ntfs-3g/) | [exfat-utils](https://archlinux.org/packages/community/x86_64/exfat-utils/) | [dosfstools](https://archlinux.org/packages/core/x86_64/dosfstools/) |
| --------------------------------------------------------------- | --------------------------------------------------------------------------- | -------------------------------------------------------------------- |

#### Réseaux
| [dhcpcd](https://archlinux.org/packages/core/x86_64/dhcpcd/) | [dhclient](https://archlinux.org/packages/extra/x86_64/dhclient/) | 
| ------------------------------------------------------------ | ----------------------------------------------------------------- |

| [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) | [iw](https://archlinux.org/packages/core/x86_64/iw/) | [wireless_tools]() |
| ----------------------------------------------------------------------------- | ---------------------------------------------------- | ------------------ |

#### Serveur X
| [xorg-server]() | [xorg-xinit]() | [xorg-server-utils]() | [ xf86-video-vesa]() |
| --------------- | -------------- | --------------------- | -------------------- |

#### Son
| [alsa-utils](https://archlinux.org/packages/extra/x86_64/alsa-utils) | [pulseaudio](https://archlinux.org/packages/extra/x86_64/pulseaudio/) |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- |

#### Outils
[bash-completion]()

[base-devel]()

[binutils]()

[cronie]()

[fakeroot]()

[git]()

[gnome-keyring]()

[lha lsb-release]()

[mtools]()

[nano]()

[openssh]()

[os-prober](https://archlinux.org/packages/community/x86_64/os-prober/)

[p7zip]()

[pamac-aur]()

[pacman-contrib]()

[ntp]()

[reflector]()

[samba]()

[smbclient]()

[sudo]()

[unzip]()

[zip]()










--------------------------------------------------------------------------------------------------------------------------------------------
### **Etape 5 : Génération du FSTAB**
```
genfstab -U /mnt >> /mnt/etc/fstab ;
```
--------------------------------------------------------------------------------------------------------------------------------------------
### **Etape 6 : Chroot**
```
arch-chroot /mnt ;
```
--------------------------------------------------------------------------------------------------------------------------------------------
### **Etape 7 :**

**Mise à jour des dépôts**
```
pacman -Syy ;
```

#### **Fuseau Horaire**
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime ;
timedatectl set-ntp true ;
hwclock --systohc ;
```
**Ajout d'un utilisateur (Groupe Wheel)**
```
useradd -m -g users -G wheel,storage,power -s /bin/bash marc ;
```

**Changement des mots de passe :**
```
(echo "admin"; echo "admin") | passwd marc ;
(echo "root" ; echo "root")  | passwd root ;
```
#### **Clavier en Azerty**
```
# Clavier en Azerty ;
loadkeys fr-pc ;

# Session Courante
export LANG=fr_FR.UTF-8 ;

# Permanent
echo 'LANG=fr_FR.UTF-8'                 > /etc/locale.conf ; # Pas De guillemets pour cette Valeur
echo 'LC_CTYPE="fr_FR.UTF-8"'          >> /etc/locale.conf ;
echo 'LC_NUMERIC="fr_FR.UTF-8"'        >> /etc/locale.conf ;
echo 'LC_TIME="fr_FR.UTF-8"'           >> /etc/locale.conf ;
echo 'LC_COLLATE="fr_FR.UTF-8"'        >> /etc/locale.conf ;
echo 'LC_MONETARY="fr_FR.UTF-8"'       >> /etc/locale.conf ;
echo 'LC_MESSAGES='                    >> /etc/locale.conf ;
echo 'LC_PAPER="fr_FR.UTF-8"'          >> /etc/locale.conf ;
echo 'LC_NAME="fr_FR.UTF-8"'           >> /etc/locale.conf ;
echo 'LC_ADDRESS="fr_FR.UTF-8"'        >> /etc/locale.conf ;
echo 'LC_TELEPHONE="fr_FR.UTF-8"'      >> /etc/locale.conf ;
echo 'LC_MEASUREMENT="fr_FR.UTF-8"'    >> /etc/locale.conf ;
echo 'LC_IDENTIFICATION="fr_FR.UTF-8"' >> /etc/locale.conf ;
echo 'LC_ALL='                         >> /etc/locale.conf ;
echo 'LANGUAGE="fr_FR:en_US"'          >> /etc/locale.conf ;
locale-gen ;

```
**localectl**
```
Generation complete.
   System Locale: LANG=fr_FR.UTF-8
       VC Keymap: fr-latin9
      X11 Layout: n/a
```
#### **Nom de la Machine**
``` 
echo "archlinux" > /etc/hostname
```
```
echo "#IPV4
127.0.0.1       localhost
127.0.1.1       archlinux        archlinux
#127.0.1.1      archlinux.lan        archlinux
#IPV6 (OFF)
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts ;
```
#### **Configuration de la Carte-réseau**
```
A réserver
```
**Activation des Services :**
```
systemctl enable NetworkManager ;
systemctl enable sshd ;
```
**Boot via Grub**
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub ;
grub-mkconfig -o /boot/grub/grub.cfg ;
```
**Boot via SystemD**
```
# Récupérer la Valeur UUID de la racine du système
blkid | grep ext4
/dev/sda3: UUID="95e7bb3e-cbc8-434c-8496-5d9ea42aef45" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="c991bc13-be89-ca47-9b71-87afed0ad07f"

# Installation EFI
bootctl install
echo "default  arch.*" > /boot/loader/loader.conf

# BootLoader:
echo "title Arch Linux
linux /vmlinuz-linux

# ls /boot/*img
initrd /initramfs-linux.img
options root=UUID=95e7bb3e-cbc8-434c-8496-5d9ea42aef45 rw" > /boot/loader/entries/arch.conf
```
**bootctl list**
```
Boot Loader Entries:
        title: Arch Linux (default)
           id: arch.conf
       source: /boot/loader/entries/arch.conf
        linux: /vmlinuz-linux
       initrd: /initramfs-linux.img
      options: root=UUID=95e7bb3e-cbc8-434c-8496-5d9ea42aef45 rw
```


--------------
**Modification de Fichiers**
```
sed -i -e "s/\#\[multilib\]/[multilib\]/g" /etc/pacman.conf                                   ; # Activer x86
sed -i -e "s/\# \%wheel ALL\=(ALL) ALL/\%wheel ALL\=(ALL) ALL/g" /etc/sudoers                 ; # Sudoer le GRP
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config ; # Root autorisé (SSH)
sed -i -e "s/\#COMPRESSION\=\"bzip2\"/COMPRESSION\=\"bzip2\"/g" /etc/mkinitcpio.conf          ; # Compression du noyaux
```

mkinitcpio -p linux


```
Plusieurs Lignes identiques:
sed -i -e "s/\#Include \= \/etc\/pacman.d\/mirrorlist/Include \= \/etc\/pacman.d\/mirrorlist/g" /etc/pacman.conf ; # Activer x86
```

**Hyper-V (Firmware)**
```
WARNING: Possibly missing firmware for module: aic94xx, wd719x , xhci_pci
```
```
su marc ;
cd /home/marc ;

git clone https://aur.archlinux.org/aic94xx-firmware.git ; # aic94xx
git clone https://aur.archlinux.org/wd719x-firmware.git  ; # wd719x
git clone https://aur.archlinux.org/upd72020x-fw.git     ; # xhci_pci

cd aic94xx-firmware ;
makepkg -si ; cd .. ;

cd wd719x-firmware  ;
makepkg -si ; cd .. ;

cd upd72020x-fw     ;
makepkg -si ; cd .. ;
exit
```
**Erreur / Warning**
```
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_MESSAGES to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
```

**Quitter le CHROOT et reboot**
```
exit
reboot
```
**Démonter Disque :**
```
swapoff "/dev/sda2" && umount "/mnt" "/mnt/home" "/mnt/boot"
df -h | grep /mnt
```

**Tutorial**
```
https://www.youtube.com/watch?v=-zb8220uUiA
```
**Installation de l'interface**
```
(echo "o")          | pacman -Syy ntp cronie alsa-utils                                    ; # Inclus dans le Chroot !
systemctl enable cronie

(echo "o")          | pacman -S gst-plugins-{base,good,bad,ugly} gst-libav                 ; # Plugin GStreamer

(echo ""; echo "o") | pacman -S xorg-{server,xinit,apps} xf86-input-libinput xdg-user-dirs ; # X11
(echo ""; echo "o") | pacman -S xf86-video-intel    
```
 
```
https://wiki.archlinux.org/title/Hyper-V
https://dzone.com/articles/install-arch-linux-on-windows-10-hyper-v
https://gist.github.com/deoren/4d87ff5ddc831a22be433607341e5441
sudo pacman -S xf86-video-fbdev
# /etc/modprobe.d/blacklist.conf
blacklist hyperv_fb
Set-VMVideo -VMName namehere -HorizontalResolution:1920 -VerticalResolution:1080 -ResolutionType Single
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm
```
**Gestionnaire de Connexion**
```
(echo ""; echo "o") | pacman -Syu sddm
sudo localectl set-x11-keymap fr
systemctl restart sddm.service
systemctl enable sddm.service

# Lister les Bureaux: ls /usr/share/xsessions/
```

**SDDM**
```
# Dossier Thème :/usr/share/sddm/themes
# Par Défaut    : elarun, maldives, maya

echo "[Autologin]
User=marc
Session=cinnamon.desktop

[General]
Numlock=on
#EnableHiDPI=false

[Theme]

Current=elarun
" > /etc/sddm.conf
```
systemctl restart sddm


**Interface Graphique:**

**Cinnamon**
```
pacman -Sy cinnamon 
``` 
