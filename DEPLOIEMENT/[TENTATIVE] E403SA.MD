#### Articles
```
https://fhackts.wordpress.com/2016/09/09/installing-archlinux-the-efisystemd-boot-way/?unapproved=970&moderation-hash=e8e626944f7a8bca05805782c535eaf4#comment-970
https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d
```

------------------------------------------------------------------
#### Live-CD
```shell
loadkeys fr-pc;
iwctl station list;
iwctl station wlan0 connect MONRESEAUWIFI --passphrase MONMDP;
iwctl station wlan0 show;
passwd root;
systemctl start sshd;
```

#### Démontage des partitions
```shell
clear;
umount -R -f /mnt /mnt/*;
swapoff -a -v;
```

#### Partitionnements

```
Partition 1: Boot (EFI)
Partition 2: SWAP
Partition 3: SYSTEM
Partition 4: HOME
```

```shell
(echo "g"; echo "p"; echo "w") | fdisk /dev/mmcblk0;
(echo "n"; echo "1"; echo ""; echo "+512M"  ; echo "t"; echo "1"; echo "w";)             | fdisk /dev/mmcblk0;#EFI
(echo "n"; echo "2"; echo ""; echo "+4G"    ; echo "t"; echo "2"; echo "19"; echo "w";)  | fdisk /dev/mmcblk0;#SWAP
(echo "n"; echo "3"; echo ""; echo "+30G"   ; echo "t"; echo "3"; echo "20"; echo "w";)  | fdisk /dev/mmcblk0;#SYSTEM
(echo "n"; echo "4"; echo ""; echo "+81.5G" ; echo "t"; echo "4"; echo "28"; echo "w";)  | fdisk /dev/mmcblk0;#HOME
(echo "p")| fdisk /dev/mmcblk0;
```

#### Formatage des partitions
```shell
echo "yes" | mkfs.fat -F32 /dev/mmcblk0p1;
echo "yes" | mkswap        /dev/mmcblk0p2;
echo "yes" | mkfs -t ext4  /dev/mmcblk0p3;
echo "yes" | mkfs -t ext4  /dev/mmcblk0p4;
```

#### Label des Volumes 
Indispensable pour la valeur qui va chercher UUID.
```shell
e2label /dev/mmcblk0p1 EFI;
e2label /dev/mmcblk0p2 SWAP;
e2label /dev/mmcblk0p3 SYSTEM;
e2label /dev/mmcblk0p4 HOME;
```

#### Monter les partitions
```shell
mkdir  /mnt/home /mnt/boot
mount  /dev/mmcblk0p1 /mnt/boot
mount  /dev/mmcblk0p3 /mnt
mount  /dev/mmcblk0p4 /mnt/home
swapon /dev/mmcblk0p2
df -h
```

#### Purge du Stockage
```shell
clear;
rm -r -f /mnt/;
du -h -d 0 /mnt;
cd /mnt;
```

------------------------------------------------------------------
#### [FIX] Mise à jour des Clés PGP
```shell
pacman -Sy --noconfirm archlinux-keyring;
```
------------------------------------------------------------------
#### Installation des paquets
```shell
clear;
pacstrap /mnt base;
pacstrap /mnt intel-ucode;
pacstrap /mnt linux;
pacstrap /mnt linux-firmware;
pacstrap /mnt ntfs-3g;
pacstrap /mnt dhclient
pacstrap /mnt iwd;
pacstrap /mnt iw;
pacstrap /mnt base-devel;
pacstrap /mnt bash-completi;on;
pacstrap /mnt curl;
pacstrap /mnt git;
pacstrap /mnt go; 
pacstrap /mnt lsb-release;
pacstrap /mnt man;
pacstrap /mnt nano;
pacstrap /mnt neofetch;
pacstrap /mnt ntp;
pacstrap /mnt openssh;
pacstrap /mnt p7zip;
pacstrap /mnt samba;
pacstrap /mnt smbclient;
pacstrap /mnt sudo;
pacstrap /mnt unzip;
pacstrap /mnt wget;
pacstrap /mnt zip;
pacstrap /mnt xorg-server;
pacstrap /mnt xf86-video-vesa;
pacstrap /mnt xorg-xinit;
du -h -d 0 /mnt;
```
------------------------------------------------------------------
#### Configuration Réseau
```shell
clear;
cp /etc/systemd/network/* /mnt/etc/systemd/network
```
------------------------------------------------------------------
#### FSTAB
```shell
clear;
genfstab -U /mnt >> /mnt/etc/fstab;
```
------------------------------------------------------------------
#### Passage en Chroot
```shell
clear;
arch-chroot /mnt;
```
------------------------------------------------------------------
#### BootLoader (Install)
```shell
clear;
bootctl --path=/boot install;
```
------------------------------------------------------------------
#### Bootloader (Intel)
```shell
UUID_SYSTEM=$(blkid | grep 'LABEL="SYSTEM" UUID=' | cut -d '"' -f 4);

echo "default  arch.*" > /boot/loader/loader.conf;

echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
initrd /intel-ucode.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch.conf;

echo "title Arch Linux (fallback initramfs)
linux /vmlinuz-linux
initrd /initramfs-linux-fallback.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch.conf;
# bootctl update;
# bootctl;
```
------------------------------------------------------------------
#### Fuseau Horaire

```shell
clear;
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime;
sed -i -e "s/\#NTP\=/\NTP\=fr.pool.ntp.org/g" /etc/systemd/timesyncd.conf;
timedatectl set-ntp true;
hwclock --systohc;
echo "export EDITOR='/usr/bin/nano'" > ~/.bashrc;
```

------------------------------------------------------------------
#### Clavier et Langue
```shell
clear;
loadkeys fr-pc;
export LANG=fr_FR.UTF-8;
echo 'LANG=fr_FR.UTF-8'                 > /etc/locale.conf;
echo 'LC_CTYPE="fr_FR.UTF-8"'          >> /etc/locale.conf;
echo 'LC_NUMERIC="fr_FR.UTF-8"'        >> /etc/locale.conf;
echo 'LC_TIME="fr_FR.UTF-8"'           >> /etc/locale.conf;
echo 'LC_COLLATE="fr_FR.UTF-8"'        >> /etc/locale.conf;	
echo 'LC_MONETARY="fr_FR.UTF-8"'       >> /etc/locale.conf;
echo 'LC_MESSAGES='                    >> /etc/locale.conf;
echo 'LC_PAPER="fr_FR.UTF-8"'          >> /etc/locale.conf;
echo 'LC_NAME="fr_FR.UTF-8"'           >> /etc/locale.conf;
echo 'LC_ADDRESS="fr_FR.UTF-8"'        >> /etc/locale.conf;
echo 'LC_TELEPHONE="fr_FR.UTF-8"'      >> /etc/locale.conf;
echo 'LC_MEASUREMENT="fr_FR.UTF-8"'    >> /etc/locale.conf;
echo 'LC_IDENTIFICATION="fr_FR.UTF-8"' >> /etc/locale.conf;
echo 'LC_ALL='                         >> /etc/locale.conf;
echo 'LANGUAGE="fr_FR"'                >> /etc/locale.conf;
echo 'KEYMAP=fr-latin9'                 > /etc/vconsole.conf;
echo 'FONT=eurlatgr'                   >> /etc/vconsole.conf;
echo 'fr_FR.UTF-8 UTF-8'                > /etc/locale.gen;
locale-gen;
```
------------------------------------------------------------------
#### Configuration Host et Hostname
```shell
clear;
NAME=Arch
DOM=LAN

echo "$NAME" > /etc/hostname;
echo "################################################
#IPV4
127.0.0.1       localhost
127.0.1.1       $NAME        $NAME
#127.0.1.1      $NAME.$DOM        $NAME
#IPV6 (OFF)
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
################################################" > /etc/hosts;
```

------------------------------------------------------------------
#### Utilisateurs
```shell
clear;
/usr/sbin/useradd \
  --home-dir /home/marc \
  --base-dir /home/marc \
  --uid 1005 \
  --groups wheel,storage,power \
  --no-user-group \
  --shell /bin/bash \
  --comment 'Compte Drthrax74' \
  --create-home marc;
```

------------------------------------------------------------------
#### Changement Mot de passe
```shell
clear;
(echo "root:root")  | chpasswd;
(echo "marc:admin") | chpasswd;
```

------------------------------------------------------------------
#### Modification des fichiers de Configuration
```shell
clear;

# Groupe Wheel:
sed -i -e "s/\# \%wheel ALL\=(ALL\:ALL) NOPASSWD\: ALL/\%wheel ALL\=(ALL\:ALL) NOPASSWD\: ALL/g" /etc/sudoers;

# MultiLib:
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf;

# Root en SSH:
sed -i -e "s/\#PermitRootLogin prohibit\-password/PermitRootLogin Yes/g" /etc/ssh/sshd_config;
```

------------------------------------------------------------------
#### 
```shell
clear;

```


------------------------------------------------------------------
#### 
```shell
clear;

```


------------------------------------------------------------------
#### 
```shell
clear;

```


------------------------------------------------------------------
#### 
```shell
clear;

```


------------------------------------------------------------------
#### 
```shell
clear;

```


------------------------------------------------------------------
#### 
```shell
clear;

```

