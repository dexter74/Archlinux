**


**Installatuin de paquet**
```
pacstrap -i /mnt base linux linux-firmware linux-headers
pacstrap -i /mnt grub efibootmgr
pacstrap -i /mnt ntfs-3g exfat-utils dosfstools lvm2
pacstrap -i /mnt dhcpcd dhclient networkmanager iw wireless_tools
pacstrap -i /mnt xorg-server xorg-xinit xf86-video-vesa
pacstrap -i /mnt bash-completion base-devel binutils cronie fakeroot git gnome-keyring lha lsb-release mtools nano openssh os-prober p7zip pacman-contrib ntp reflector samba smbclient sudo unzip zip
```

**FSTAB**
```
genfstab -U /mnt >> /mnt/etc/fstab ;
```

**Chroot**
```
arch-chroot /mnt ;
```

**TImezone et Synchronisation***
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime ;
timedatectl set-ntp true ;
hwclock --systohc ;
```

**AJout d'un USER**
```
useradd -m -g users -G wheel,storage,power -s /bin/bash marc ;
```
**Changements des mot de passe :**
```
(echo "admin"; echo "admin") | passwd marc ;
(echo "root" ; echo "root")  | passwd root ;
```

**Clavier en FR**
```
loadkeys fr-pc ;
export LANG=fr_FR.UTF-8 ;

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
echo 'KEYMAP=fr'                        > /etc/vconsole.conf ;


locale-gen ;
```

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

**Activation des services**
```
systemctl enable NetworkManager ;
systemctl enable sshd ;
```

```
sed -i -e "s/\#\[multilib\]/[multilib\]/g" /etc/pacman.conf ;
sed -i -e "s/\# \%wheel ALL\=(ALL) ALL/\%wheel ALL\=(ALL) ALL/g" /etc/sudoers; 
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config ;
sed -i -e "s/\#COMPRESSION\=\"bzip2\"/COMPRESSION\=\"bzip2\"/g" /etc/mkinitcpio.conf ;
```


**Marc**
```
su - marc ;
rm -r -f *
git clone https://aur.archlinux.org/aic94xx-firmware.git ; # aic94xx
git clone https://aur.archlinux.org/wd719x-firmware.git  ; # wd719x
git clone https://aur.archlinux.org/upd72020x-fw.git     ; # xhci_pci
cd aic94xx-firmware ; makepkg -si ;cd .. ;
cd wd719x-firmware  ; makepkg -si ; cd .. ;
cd upd72020x-fw     ; makepkg -si ; cd .. ;
exit
```

**Prise en charge de SystemD et LVM2
```
sed -i -e "s/HOOKS\=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS\=(base systemd autodetect modconf block lvm2 filesystems keyboard fsck)/g" /etc/mkinitcpio.conf ;
mkinitcpio -p linux ;
```

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
```


**Quitter le Chroot**
```
exit
```

**Redémarrer le PC**
```
reboot
```
