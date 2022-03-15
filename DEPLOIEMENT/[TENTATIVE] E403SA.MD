#### Articles
```
https://fhackts.wordpress.com/2016/09/09/installing-archlinux-the-efisystemd-boot-way/?unapproved=970&moderation-hash=e8e626944f7a8bca05805782c535eaf4#comment-970
https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d
```

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

#### [FIX] Mise à jour des Clés PGP
```shell
pacman -Sy --noconfirm archlinux-keyring;
```

#### Purge du Stockage
```shell
clear;
rm -r -f /mnt/;
du -h -d 0 /mnt;
cd /mnt;
```

#### Installation des paquets
```shell
clear;
pacstrap /mnt base base-devel bash-completion curl dhclient git go intel-ucode iw iwd lsb-release man nano neofetch ntfs-3g ntp openssh p7zip samba smbclient sudo unzip wget zip;
pacstrap /mnt xorg-server xorg-xinit xf86-video-vesa;
pacstrap /mnt linux;
pacstrap /mnt linux-firmware;
du -h -d 0 /mnt;
```

#### 
```shell
```

#### 
```shell
```

#### 
```shell
```

#### 
```shell
```

#### 
```shell
```
