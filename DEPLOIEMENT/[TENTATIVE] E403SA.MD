------------------------------------------------------------------
#### Articles
```
https://fhackts.wordpress.com/2016/09/09/installing-archlinux-the-efisystemd-boot-way/?unapproved=970&moderation-hash=e8e626944f7a8bca05805782c535eaf4#comment-970
https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d
```
------------------------------------------------------------------
#### A. Live-CD
```shell
loadkeys fr-pc;
iwctl station list;
iwctl station wlan0 connect MONRESEAUWIFI --passphrase MONMDP;
iwctl station wlan0 show;
passwd root;
systemctl start sshd;
```
#### B. Démontage des partitions
```shell
clear;
umount -R -f /mnt /mnt/*;
swapoff -a -v;
```
#### D. Partitionnements

```shell
(echo "g"; echo "p"; echo "w") | fdisk /dev/mmcblk0;
(echo "n"; echo "1"; echo ""; echo "+512M"  ; echo "t"; echo "1"; echo "w";)             | fdisk /dev/mmcblk0;#EFI
(echo "n"; echo "2"; echo ""; echo "+4G"    ; echo "t"; echo "2"; echo "19"; echo "w";)  | fdisk /dev/mmcblk0;#SWAP
(echo "n"; echo "3"; echo ""; echo "+30G"   ; echo "t"; echo "3"; echo "20"; echo "w";)  | fdisk /dev/mmcblk0;#SYSTEM
(echo "n"; echo "4"; echo ""; echo "+81.5G" ; echo "t"; echo "4"; echo "28"; echo "w";)  | fdisk /dev/mmcblk0;#HOME
(echo "p")| fdisk /dev/mmcblk0;
```
#### E. Formatage des partitions
```shell
echo "yes" | mkfs.fat -F32 /dev/mmcblk0p1;
echo "yes" | mkswap        /dev/mmcblk0p2;
echo "yes" | mkfs -t ext4  /dev/mmcblk0p3;
echo "yes" | mkfs -t ext4  /dev/mmcblk0p4;
```
#### F. Label des Volumes 
Indispensable pour la valeur qui va chercher UUID.
```shell
e2label /dev/mmcblk0p1 EFI;
e2label /dev/mmcblk0p2 SWAP;
e2label /dev/mmcblk0p3 SYSTEM;
e2label /dev/mmcblk0p4 HOME;
```
#### G. Monter les partitions
```shell
mkdir -p /mnt/home /mnt/boot
mount  /dev/mmcblk0p1 /mnt/boot
mount  /dev/mmcblk0p3 /mnt
mount  /dev/mmcblk0p4 /mnt/home
swapon /dev/mmcblk0p2
df -h | grep /mnt
```

#### H. [FIX] Mise à jour des Clés PGP
```shell
pacman -Sy --noconfirm archlinux-keyring;
```

-----------------------------------------------------------------------------------
#### 0. Purge du Stockage
```shell
clear;
rm -r -f /mnt/;
du -h -d 0 /mnt;
cd /mnt;
```

#### 1. Installation des paquets
```shell
clear;
pacstrap /mnt base;
pacstrap /mnt base-devel;
pacstrap /mnt bash-completion;
pacstrap /mnt curl;
pacstrap /mnt dhclient;
pacstrap /mnt dhcpcd;
pacstrap /mnt fakeroot;
pacstrap /mnt git;
pacstrap /mnt go;
pacstrap /mnt intel-ucode;
pacstrap /mnt iwd;
pacstrap /mnt iw;
pacstrap /mnt linux;
pacstrap /mnt linux-firmware;
pacstrap /mnt lsb-release;
pacstrap /mnt man;
pacstrap /mnt nano;
pacstrap /mnt neofetch;
pacstrap /mnt ntfs-3g;
pacstrap /mnt ntp;
pacstrap /mnt openssh;
pacstrap /mnt p7zip;
pacstrap /mnt samba;
pacstrap /mnt smbclient;
pacstrap /mnt sudo;
pacstrap /mnt unzip;
pacstrap /mnt wget;
pacstrap /mnt xorg-server;
pacstrap /mnt xf86-video-vesa;
pacstrap /mnt xorg-xinit;
pacstrap /mnt zip;
du -h -d 0 /mnt;
```
#### 2. Configuration Réseau
```shell
clear;
mkdir -p mnt/etc/systemd/network;
cp /etc/systemd/network/* /mnt/etc/systemd/network;
```
#### 3. FSTAB
```shell
clear;
genfstab -U /mnt >> /mnt/etc/fstab;
```
------------------------------------------------------------------
#### 4. Passage en Chroot
```shell
clear;
arch-chroot /mnt;
```
------------------------------------------------------------------
#### 5. BootLoader (Install)
```shell
clear;
bootctl --path=/boot install;
```
------------------------------------------------------------------
#### 6. Bootloader (Intel)
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
#### 7. Fuseau Horaire

```shell
clear;
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime;
sed -i -e "s/\#NTP\=/\NTP\=fr.pool.ntp.org/g" /etc/systemd/timesyncd.conf;
timedatectl set-ntp true;
hwclock --systohc;
echo "export EDITOR='/usr/bin/nano'" > ~/.bashrc;
```

------------------------------------------------------------------
#### 8. Clavier et Langue
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
#### 9. Configuration Host et Hostname
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
#### 10. Utilisateurs
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
#### 11. Changement Mot de passe
```shell
clear;
(echo "root:root")  | chpasswd;
(echo "marc:admin") | chpasswd;
```

------------------------------------------------------------------
#### 12. Modification des fichiers de Configuration
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
#### 13. Pasage à Marc
```shell
clear;
su - marc;
```

#### Yaourt
```shell
clear;
cd /tmp;
git clone https://aur.archlinux.org/yay.git;
cd yay ;
makepkg -si --noconfirm;
```

------------------------------------------------------------------
#### Pilotes
```shell
clear;
# mkinitcpio -p linux;
# yay -S --noconfirm aic94xx-firmware;
# yay -S --noconfirm upd72020x-fw;
# yay -S --noconfirm wd719x-firmware;
```
------------------------------------------------------------------
#### Passage à Root
```shell
clear;
exit;
```





------------------------------------------------------------------
#### Script First-Boot:
```shell
clear;

echo "systemctl $1 {systemd-resolved,systemd-networkd,systemd-timesyncd,iwd};" > services.sh;
echo "INTERFACE='wlan0'
SSID='ASUS_A8_5G'
KEY='Azerty74@123'
iwctl station $INTERFACE connect $SSID --passphrase $KEY;" > wifi.sh;

echo "journalctl -u systemd-resolved"  > systemd-resolved.sh;
echo "journalctl -u systemd-networkd"  > systemd-networkd.sh;
echo "journalctl -u systemd-timesyncd" > systemd-timesyncd.sh;
echo "journalctl -u iwd"               > systemd-iwd.sh;
```



------------------------------------------------------------------
#### Post Démarrage
```shell
clear;
sh services.sh enable;
sh services.sh start;
```


