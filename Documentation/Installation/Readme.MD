#### Information sur le Guide
Installation sur une disque-dur avec 2 partitions.
Le guide est fonctionnel .

**LiveCD**
```
loadkeys fr-pc ;
iwctl --passphrase <Clé WPA> station wlan0 connect ASUS_A8_5G ;
```

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
#DISK=/dev/mmcblk0
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
echo "yes" | pvremove ${DISK}2  ;
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
partprobe ${DISK}2  ; # sdXy
```


--------------------------------------------------------------------------------
**Création du Volume Physique**
```
clear ; 
pvcreate ${DISK}2 ;
```

**Création du Volume Groupe**
```
clear ; vgcreate $LVM_NAMEVG ${DISK}2  ;
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
echo "yes" | mkfs.fat -F32 ${DISK}1  ; # Disk

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

EFI / MBR
```
mkdir -p /mnt/boot && mount ${DISK}1  /mnt/boot ;
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

Prise en charge des types de partitions
```
pacstrap -i /mnt --noconfirm ntfs-3g exfat-utils dosfstools lvm2 ;
```

X11
```
pacstrap -i /mnt --noconfirm xorg-server xorg-xinit xf86-video-vesa ;
```

Utilitaires Réseaux
```
pacstrap -i /mnt --noconfirm dhcpcd dhclient networkmanager iw wireless_tools ;
pacstrap -i /mnt --noconfirm wpa_supplicant netctl ;
```

Utilitaires
```
pacstrap -i /mnt --noconfirm bash-completion base-devel binutils cronie curl dialog fakeroot git gnome-keyring lha lsb-release mtools nano openssh os-prober p7zip pacman-contrib neofetch ntp reflector samba smbclient sudo unzip zip wget ;
```

Son: (A peaufiné)
```
pacstrap -i /mnt --noconfirm pavucontrol pipewire-pulse ;

# pacstrap -i /mnt --noconfirm alsa-utils ;
# pacstrap -i /mnt --noconfirm pulseaudio-alsa ;
```


Optionnel
```
pacstrap -i /mnt --noconfirm linux-headers ;
```
--------------------------------------------------------------------------------
**Installation du MicroCode :**
MicroCode AMD: 
``` 
pacstrap -i /mnt --noconfirm amd-ucode  ;
```

MicroCode Intel:
``` 
pacstrap -i /mnt --noconfirm intel-ucode ;
``` 
--------------------------------------------------------------------------------
**FSTAB**
```
genfstab -U /mnt >> /mnt/etc/fstab ;
```
--------------------------------------------------------------------------------


















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
**Modification de fichiers**
```
# sed -i -e "s/\# \%wheel ALL\=(ALL) ALL/\%wheel ALL\=(ALL) ALL/g" /etc/sudoers ;
sed -i -e "s/\# \%wheel ALL\=(ALL) NOPASSWD\: ALL/\%wheel ALL\=(ALL)  NOPASSWD\: ALL/g" /etc/sudoers ;

sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf ;
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config ;
sed -i -e "s/\#COMPRESSION\=\"bzip2\"/COMPRESSION\=\"bzip2\"/g" /etc/mkinitcpio.conf ;
```
--------------------------------------------------------------------------------
**Mise à jour des paquets**
```
pacman -Syy ;
```
--------------------------------------------------------------------------------
**Wi-Fi**
```
yay -S --noconfirm iwd ;
``` 
**NANO par défaut**
```
echo "export EDITOR='/usr/bin/nano'" > ~/.bashrc ;
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
--------------------------------------------------------------------------------
**Changements des mot de passe :**
```
(echo "admin"; echo "admin") | passwd marc ;
(echo "root" ; echo "root")  | passwd root ;
```
--------------------------------------------------------------------------------
**Marc**
```
su - marc ;
```
--------------------------------------------------------------------------------
**Yaourt**
```
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
```

--------------------------------------------------------------------------------
**Firmware** (Hyper-V)
```
cd /tmp ;
git clone https://aur.archlinux.org/aic94xx-firmware.git ; # aic94xx
git clone https://aur.archlinux.org/wd719x-firmware.git  ; # wd719x
git clone https://aur.archlinux.org/upd72020x-fw.git     ; # xhci_pci
cd aic94xx-firmware ; makepkg -si --noconfirm ; cd /tmp ;
cd wd719x-firmware  ; makepkg -si --noconfirm ; cd /tmp ;
cd upd72020x-fw     ; makepkg -si --noconfirm ; cd /tmp ;
exit ;
```




--------------------------------------------------------------------------------
**Prise en charge de SystemD et LVM2**
```
sed -i -e "s/HOOKS\=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems keyboard fsck)/g" /etc/mkinitcpio.conf ;
mkinitcpio -p linux ;
```
--------------------------------------------------------------------------------
**Activation des services**
```
systemctl enable NetworkManager ;
systemctl enable sshd ;
systemctl enable cronie ;
systemctl enable ntpd ;
systemctl enable iwd ;
```

--------------------------------------------------------------------------------
**Bootloader** (AMD)
```

# Récupérer la Valeur UUID de la racine du système
UUID_SYSTEM=$(blkid | grep "SYSTEM: UUID=" | cut -d '"' -f 2)

# Installation EFI
bootctl install
echo "default  arch.*" > /boot/loader/loader.conf

# BootLoader: (ls /boot/*img)
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
initrd /amd-ucode.img
options root=UUID=$UUID_SYSTEM rw quiet vga=current splash" > /boot/loader/entries/arch.conf ;

clear ;
bootctl random-seed ;
bootctl list ;
```


**Bootloader** (Intel)
```
# Récupérer la Valeur UUID de la racine du système
UUID_SYSTEM=$(blkid | grep "SYSTEM: UUID=" | cut -d '"' -f 2)

# Installation EFI
bootctl install
echo "default  arch.*" > /boot/loader/loader.conf

# BootLoader: (ls /boot/*img)
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
initrd /intel-ucode.img
options root=UUID=$UUID_SYSTEM rw quiet vga=current splash" > /boot/loader/entries/arch.conf ;
clear ;
bootctl random-seed ;
bootctl list ;
# bootctl systemd-efi-options XXXXX
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
**X11 en FR**
```
su - marc ;
localectl set-x11-keymap fr ;
```





--------------------------------------------------------------------------------
**Installation d'une Interface Graphique**
```
yay -S --noconfirm kde1-kdebase-git ;
```

```
pacman -S --noconfirm cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver 	cinnamon-session cinnamon-settings-daemon cinnamon-translations cjs muffin nemo ;
pacman -S --noconfirm cutefish ;
pacman -S --noconfirm deepin deepin-desktop-base deepin-extra ;
pacman -S --noconfirm element-desktop ;
pacman -S --noconfirm enlightenment ;
pacman -S --noconfirm gnome gnome-remote-desktop ;
pacman -S --noconfirm liri-shell-git ;
pacman -S --noconfirm lumina-desktop ;
pacman -S --noconfirm lxde     ; # GTK 2
pacman -S --noconfirm lxde-gtk3; # GTK 3
pacman -S --noconfirm lxqt ;
pacman -S --noconfirm mate-desktop ;
pacman -S --noconfirm openbox obconf	menumaker ;
pacman -S --noconfirm pantheon ;
pacman -S --noconfirm paperdea ;
pacman -S --noconfirm phosh ;
pacman -S --noconfirm plasma-desktop ;
pacman -S --noconfirm sugar sugar-fructose ;
pacman -S --noconfirm ukui ;
pacman -S --noconfirm xfce4 ; # xfce4-panel
```

--------------------------------------------------------------------------------
**Configuration du Gestionnaire de fenêtre**
La première étape est de lister les interfaces.
```
ls /usr/share/xsessions/
```
```
echo "[Autologin]
User=marc
Session=plasma-kde.desktop

[General]
Numlock=on
#EnableHiDPI=false

[Theme]
Current=breeze" > /etc/sddm.conf ; systemctl restart sddm ;
```

--------------------------------------------------------------------------------
**Gestionnaire de fenêtre**
```
#systemctl enable --now avahi-daemon.service ;
pacman -S --noconfirm sddm ; systemctl enable --now sddm ;
```

Amélioration à faire:
[Définir le timeZone par SystemD](https://www.xmodulo.com/change-timezone-linux.html)






**BUG:**
```
sudo rm /etc/resolv.conf ;
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf ;
```



**Facultatif**
```
# DHCP=
# > YES  Supporte IPV4 et IPV6 
# > IPV4 Supporte IPV4 uniquement
# > IPV6 Supporte IPV6 uniquement
echo "[Match]
Name=eth0

[Network]
#DHCP=ipv4
Address=192.168.1.108/24
Gateway=192.168.1.1
DNS=8.8.8.8" > /etc/systemd/network/20-dhcp.network ;

pacman -S --noconfirm resolvconf  ; # Indispensables
systemctl disable NetworkManager  ; #
systemctl enable systemd-networkd ; #
systemctl enable systemd-resolved ; #
systemctl enable systemd-homed.service ;
systemctl enable systemd-resolved.service ;
# pacman -S --noconfirm pam pambase ;
```









-------------------------------------------------------------------------------------------------------------------------------------------------------
## Note:
```
lvm2-activation.service > https://man7.org/linux/man-pages/man8/lvm2-activation-generator.8.html
systemctl set-default graphical.target ;
lxappearance-obconf	lxappearance-obconf-gtk3 obconf-qt ;
https://github.com/coimbrap/archlinux
```
