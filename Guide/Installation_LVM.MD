#### Information sur le Guide
Installation sur une disque-dur avec 2 partitions.
Le guide est fonctionnel .


--------------------------------------------------------------------------------
**Disque**
```
Partitions!
 |-> EFI
 |-> LVM
     |-> SWAP
     |-> SYSTEM
     |-> HOME
 ```

--------------------------------------------------------------------------------
**Déclarations des valeurs**
```
DISK=/dev/sda
SIZE_BOOT=+512M
SIZE_SWAP=+4G
SIZE_SYST=+20G
SIZE_HOME=+7.2G
LVM_NAMEVG=VG0
```

--------------------------------------------------------------------------------
**Démontage des partitions** (Si besoin)
```
umount -R /mnt /mnt/* ;
swapoff ${DISK}2 ;
wipefs -a ${DISK} ;
```

**Vérification du montage**
```
clear ; 
df -h | grep "/mnt" ;
swapon -s ;
```

**Suppression du LVM**
```
echo "yes" | lvremove /dev/$LVM_NAMEVG/SWAP ;
echo "yes" | lvremove /dev/$LVM_NAMEVG/SYSTEM ;
echo "yes" | lvremove /dev/$LVM_NAMEVG/HOME ;
echo "yes" | vgremove $LVM_NAMEVG ;
echo "yes" | pvremove ${DISK}2 ;
```

**Vérification LVM**
```
clear ; lvdisplay ; vgdisplay ; pvdisplay ;
```
**Wype le Disque-dur**
```
dd if=/dev/zero of=${DISK}  bs=512  count=1 ;
```

--------------------------------------------------------------------------------
**Création des partitions**
```
clear ;
(echo "g"; echo "w") | fdisk ${DISK} ;
```
Partition 1:
```
(echo "n"; echo "1"; echo ""; echo "$SIZE_BOOT" ; echo "t"; echo "1" ; echo "w")  | fdisk $DISK ;
```
Partition 2:
```
(echo "n"; echo "2"; echo ""; echo "" ; echo "t"; echo "2" ; echo "30"; echo "w") | fdisk $DISK ;
```

Lister les partitions
```
(echo "p") | fdisk $DISK | grep $DISK ;
```

Correctif:
```
partprobe ${DISK}2 ;
```

--------------------------------------------------------------------------------
**Création du Volume Physique**
```
clear ; 
pvcreate ${DISK}2;
```

**Création du Volume Groupe**
```
clear ; vgcreate $LVM_NAMEVG ${DISK}2
```
**Création des Volumes Logiques**
```
clear ;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG
```

--------------------------------------------------------------------------------
**Vérification LVM**
```
clear ;
echo "###########################################"
echo "# Volume Physique" ;
pvdisplay | grep "VG Name" ;
echo "" ;
echo "# Volume Groupe" ;
vgdisplay | grep "VG Name" ;
echo "" ;
echo "Volume Logique"
lvdisplay | grep "LV Name" ;
echo "" ;
echo "Path des Volumes Logiques"
lvdisplay | grep "LV Path" ;
echo "###########################################"
```

--------------------------------------------------------------------------------
**Formatage des partitions**
```
clear ;
echo "yes" | mkfs.fat -F32 ${DISK}1
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP
echo "yes" | mkfs -t ext4  /dev/$LVM_NAMEVG/SYSTEM
echo "yes" | mkfs -t ext4  /dev/$LVM_NAMEVG/HOME
```

--------------------------------------------------------------------------------
**Montage des partitions**

SWAP:
```
clear ; 
swapon /dev/$LVM_NAMEVG/SWAP && swapon -s :
```
EFI:
```
mkdir -p /mnt/boot && mount ${DISK}1 /mnt/boot ;
```
SYSTEM:
```
mount /dev/$LVM_NAMEVG/SYSTEM /mnt ;
```
Home:
```
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home ;
```
**Vérification du montage**
```
clear ; 
df -h | grep "/mnt" ;
swapon -s ;
```

--------------------------------------------------------------------------------
**Installation de paquet**

Noyaux et Modules
```
pacstrap -i /mnt --noconfirm base linux linux-firmware linux-headers ;
```

EFI et Grub
```
pacstrap -i /mnt --noconfirm grub efibootmgr ;
```

Prise en chargedes types de partitions
```
pacstrap -i /mnt --noconfirm ntfs-3g exfat-utils dosfstools lvm2 ;
```

Utilitaires Réseau
```
pacstrap -i /mnt --noconfirm dhcpcd dhclient networkmanager iw wireless_tools ;
```

X11
```
pacstrap -i /mnt --noconfirm xorg-server xorg-xinit xf86-video-vesa ;
```

Utilitaires
```
pacstrap -i /mnt --noconfirm bash-completion base-devel binutils cronie fakeroot git gnome-keyring lha lsb-release mtools nano openssh os-prober p7zip pacman-contrib ntp reflector samba smbclient sudo unzip zip ;
```

**FSTAB**
```
genfstab -U /mnt >> /mnt/etc/fstab ;
```



--------------------------------------------------------------------------------
**Chroot**
```
arch-chroot /mnt ;
```

--------------------------------------------------------------------------------
**TImezone et Synchronisation***
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime ;
timedatectl set-ntp true ;
hwclock --systohc ;
```

--------------------------------------------------------------------------------
**AJout d'un USER**
```
useradd -m -g users -G wheel,storage,power -s /bin/bash marc ;
```

**Changements des mot de passe :**
```
(echo "admin"; echo "admin") | passwd marc ;
(echo "root" ; echo "root")  | passwd root ;
```

--------------------------------------------------------------------------------
**Clavier en FR**
```
loadkeys fr-pc ;
export LANG=fr_FR.UTF-8 ;

echo 'LANG=fr_FR.UTF-8'                 > /etc/locale.conf ;
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
echo 'KEYMAP=fr'                        > /etc/vconsole.conf ;
echo 'fr_FR.UTF-8 UTF-8'                > /etc/locale.gen
locale-gen ;
```

--------------------------------------------------------------------------------
**Hostname et Host**
```
echo "archlinux" > /etc/hostname
echo "#IPV4
127.0.0.1       localhost
127.0.1.1       archlinux        archlinux
#127.0.1.1      archlinux.lan        archlinux
#IPV6 (OFF)
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts ;
```

--------------------------------------------------------------------------------
**Activation des services**
```
systemctl enable NetworkManager ;
systemctl enable sshd ;
systemctl enable ntpd ;

```

--------------------------------------------------------------------------------
**Modification de fichiers**
```
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf ;
sed -i -e "s/\# \%wheel ALL\=(ALL) ALL/\%wheel ALL\=(ALL) ALL/g" /etc/sudoers ;
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config ;
sed -i -e "s/\#COMPRESSION\=\"bzip2\"/COMPRESSION\=\"bzip2\"/g" /etc/mkinitcpio.conf ;
```

--------------------------------------------------------------------------------
**Marc**
```
su - marc ;
```

--------------------------------------------------------------------------------
**Firmware**
```
rm -r -f *
git clone https://aur.archlinux.org/aic94xx-firmware.git ; # aic94xx
git clone https://aur.archlinux.org/wd719x-firmware.git  ; # wd719x
git clone https://aur.archlinux.org/upd72020x-fw.git     ; # xhci_pci
cd aic94xx-firmware ; makepkg -si ;cd .. ;
cd wd719x-firmware  ; makepkg -si ; cd .. ;
cd upd72020x-fw     ; makepkg -si ; cd .. ;
```
```
exit
```

--------------------------------------------------------------------------------
**Prise en charge de SystemD et LVM2**
```
sed -i -e "s/HOOKS\=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems keyboard fsck)/g" /etc/mkinitcpio.conf ;
mkinitcpio -p linux ;
```



--------------------------------------------------------------------------------
**Bootloader**
```
# Récupérer la Valeur UUID de la racine du système
UUID_SYSTEM=$(blkid | grep "SYSTEM: UUID=" | cut -d '"' -f 2)

# Installation EFI
bootctl install
echo "default  arch.*" > /boot/loader/loader.conf

# BootLoader:
echo "title Arch Linux
linux /vmlinuz-linux

# ls /boot/*img
initrd /initramfs-linux.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch.conf
clear ;
bootctl list
```

--------------------------------------------------------------------------------
**Quitter le Chroot**
```
exit
```
--------------------------------------------------------------------------------
**Redémarrer le PC**
```
reboot
```
