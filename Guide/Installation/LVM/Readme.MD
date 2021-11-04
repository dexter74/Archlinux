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
SIZE_HOME=+7G
LVM_NAMEVG=VG0
```

--------------------------------------------------------------------------------
**Démontage des partitions** (Si besoin)
```
umount -R /mnt /mnt/* ;
swapoff ${DISK}2 ;
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

Appliquer les changements de partition sans reboot
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
clear ; vgcreate $LVM_NAMEVG ${DISK}2 ;
```
**Création des Volumes Logiques**
```
clear ;
echo "yes" | lvcreate -n SWAP   -L $SIZE_SWAP $LVM_NAMEVG ;
echo "yes" | lvcreate -n SYSTEM -L $SIZE_SYST $LVM_NAMEVG ;
echo "yes" | lvcreate -n HOME   -L $SIZE_HOME $LVM_NAMEVG ;
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
echo "yes" | mkfs.fat -F32 ${DISK}1 ;
echo "yes" | mkswap /dev/$LVM_NAMEVG/SWAP ;
echo "yes" | mkfs -t ext4  /dev/$LVM_NAMEVG/SYSTEM ;
echo "yes" | mkfs -t ext4  /dev/$LVM_NAMEVG/HOME ;
```

--------------------------------------------------------------------------------
**Montage des partitions**

SWAP:
```
clear ; 
swapon /dev/$LVM_NAMEVG/SWAP && swapon -s ;
```

SYSTEM:
```
mount /dev/$LVM_NAMEVG/SYSTEM /mnt ;
```
Home:
```
mkdir -p /mnt/home && mount /dev/$LVM_NAMEVG/HOME /mnt/home ;
```
EFI:
```
mkdir -p /mnt/boot && mount ${DISK}1 /mnt/boot ;
```


A TESTER :
``` 
mkdir -p /mnt/efi && mount ${DISK}1 /mnt/boot/efi ;
```




**Vérification du montage**
```
clear ; df -h | grep "/mnt" ; swapon -s ;
```

--------------------------------------------------------------------------------
**Installation de paquet**

Noyaux et Modules
```
pacstrap -i /mnt --noconfirm base linux ;
```
EFI 
```
pacstrap -i /mnt --noconfirm efibootmgr ;
```

Grub
```
pacstrap -i /mnt --noconfirm grub ;
```

Firmware (750 Mo)
```
pacstrap -i /mnt --noconfirm linux-firmware ;
```

Optionnel
```
pacstrap -i /mnt --noconfirm linux-headers ;
```

Prise en charge des types de partitions
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
pacstrap -i /mnt --noconfirm bash-completion base-devel binutils cronie curl fakeroot git gnome-keyring lha lsb-release mtools nano openssh os-prober p7zip pacman-contrib neofetch ntp reflector samba smbclient sudo unzip zip wget ;
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
sed -i -e "s/\#NTP\=/\NTP\=fr.pool.ntp.org/g" /etc/systemd/timesyncd.conf ;
timedatectl set-ntp true ;
hwclock --systohc ;
```

**[Plannificateur de tâche](https://www.linuxtricks.fr/wiki/cron-et-crontab-le-planificateur-de-taches)**
```
EDITOR=nano crontab -e ;
```

--------------------------------------------------------------------------------
**AJout d'un USER**
```
/usr/sbin/useradd \
  --home-dir /home/marc --base-dir /home/marc \
  --uid 1005 \
  --groups wheel,storage,power --no-user-group \
  --shell /bin/bash \
  --comment 'Drthrax' \
  --create-home marc ;
```

Archive:
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
echo 'fr_FR.UTF-8 UTF-8'                > /etc/locale.gen ;
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
systemctl enable cronie ;
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
**Mise à jour des paquets**
```
pacman -Syy ;
```

--------------------------------------------------------------------------------
**Marc**
```
su - marc ;
```

--------------------------------------------------------------------------------
**Firmware**
```
cd /tmp ;
git clone https://aur.archlinux.org/aic94xx-firmware.git ; # aic94xx
git clone https://aur.archlinux.org/wd719x-firmware.git  ; # wd719x
git clone https://aur.archlinux.org/upd72020x-fw.git     ; # xhci_pci
cd aic94xx-firmware ; makepkg -si ; cd /tmp ;
cd wd719x-firmware  ; makepkg -si ; cd /tmp ;
cd upd72020x-fw     ; makepkg -si ; cd /tmp ;
```

--------------------------------------------------------------------------------
**Yaourt**
```
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si ;
```

**NANO par défaut**
```
echo "export EDITOR='/usr/bin/nano'" > ~/.bashrc ;
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
**Dbus** 
```
systemctl status dbus.service
Created symlink /etc/systemd/system/dbus-org.freedesktop.home1.service → /usr/lib/systemd/system/systemd-homed.service.
Created symlink /etc/systemd/system/multi-user.target.wants/systemd-homed.service → /usr/lib/systemd/system/systemd-homed.service.
Created symlink /etc/systemd/system/systemd-homed.service.wants/systemd-homed-activate.service → /usr/lib/systemd/system/systemd-homed-activate.service.
Created symlink /etc/systemd/system/sockets.target.wants/systemd-userdbd.socket → /usr/lib/systemd/system/systemd-userdbd.socket.
Created symlink /etc/systemd/system/dbus-org.freedesktop.resolve1.service → /usr/lib/systemd/system/systemd-resolved.service.
Created symlink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service → /usr/lib/systemd/system/systemd-resolved.service.
```
```
systemctl enable systemd-homed.service ;
systemctl enable systemd-resolved.service ;
# pacman -S --noconfirm pam pambase ;
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
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch.conf ;
clear ;

bootctl list ;
```
--------------------------------------------------------------------------------
**Quitter le Chroot**
```
exit
```




--------------------------------------------------------------------------------
**Démontage des partitions** (Si besoin)
```
umount -R /mnt /mnt/* ;
swapoff ${DISK}2 ;
```

--------------------------------------------------------------------------------
**Redémarrer le PC**
```
reboot
```
--------------------------------------------------------------------------------
**Vérification du bon fonctionnement**
```
systemctl --failed --fail --all   ;
systemctl status * | grep -i fail ;
```


--------------------------------------------------------------------------------
**Gestionnaire de fenêtre**
```
#systemctl enable --now avahi-daemon.service ;
pacman -S --noconfirm sddm ; systemctl enable --now sddm ;
```

--------------------------------------------------------------------------------
**Installation d'une Interface Graphique**
```
pacman -S --noconfirm openbox ;
```


```
pacman -S --noconfirm cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver 	cinnamon-session cinnamon-settings-daemon cinnamon-translations cjs muffin nemo ;
pacman -S --noconfirm cutefish ;
pacman -S --noconfirm deepin deepin-desktop-base deepin-extra ;
pacman -S --noconfirm element-desktop ;
pacman -S --noconfirm enlightenment ;
pacman -S --noconfirm gnome gnome-remote-desktop ;
pacman -S --noconfirm kde1-kdebase-git ;
pacman -S --noconfirm liri-shell-git ;
pacman -S --noconfirm lumina-desktop ;
pacman -S --noconfirm lxde     ; # GTK 2
pacman -S --noconfirm lxde-gtk3; # GTK 3
pacman -S --noconfirm lxqt ;
pacman -S --noconfirm mate-desktop ;
pacman -S --noconfirm pantheon ;
pacman -S --noconfirm paperdea ;
pacman -S --noconfirm phosh ;
pacman -S --noconfirm plasma-desktop ;
pacman -S --noconfirm sugar sugar-fructose ;
pacman -S --noconfirm ukui ;
pacman -S --noconfirm xfce4 ;
```

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
**Configuration du Gestionnaire de fenêtre**

La première étape est de lister les interfaces.
```
ls /usr/share/xsessions/
```
```
echo "[Autologin]
User=marc
Session=openbox.desktop

[General]
Numlock=on
#EnableHiDPI=false

[Theme]
Current=breeze" > /etc/sddm.conf ; systemctl restart sddm ;
```

**X11 en FR**
```
localectl set-x11-keymap fr ;
```


-------------------------------------------------------------------------------------------------------------------------------------------------------

## Note:
```
lvm2-activation.service > https://man7.org/linux/man-pages/man8/lvm2-activation-generator.8.html

systemctl set-default graphical.target ;
```
