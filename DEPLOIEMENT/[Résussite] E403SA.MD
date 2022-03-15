# E4034SA

**bootctl**
```
Features: ✓ Boot counting
          ✓ Menu timeout control
          ✓ One-shot menu timeout control
          ✓ Default entry control
          ✓ One-shot entry control
          ✓ Support for XBOOTLDR partition
          ✓ Support for passing random seed to OS
          ✓ Load drop-in drivers
          ✓ Boot loader sets ESP information
```

**Network**
```
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 7c:5c:f8:ff:5f:4b brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.9/24 metric 1024 brd 192.168.1.255 scope global dynamic wlan0
       valid_lft 86145sec preferred_lft 86145sec
    inet6 fe80::7e5c:f8ff:feff:5f4b/64 scope link
       valid_lft forever preferred_lft forever
```

------------------------------------------------------------------
#### A. Live-CD
```shell
.
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
echo "yes" | mkfs.fat -F32 /dev/mmcblk0p1;#EFI
echo "yes" | mkswap        /dev/mmcblk0p2;#SWAP
echo "yes" | mkfs -t ext4  /dev/mmcblk0p3;#SYSTEM
echo "yes" | mkfs -t ext4  /dev/mmcblk0p4;#HOME
```
#### F. Label des Volumes 
Indispensable pour la valeur qui va chercher UUID.
```shell
e2label /dev/mmcblk0p1 EFI;
e2label /dev/mmcblk0p2 SWAP;
e2label /dev/mmcblk0p3 SYSTEM;
e2label /dev/mmcblk0p4 HOME;
blkid | grep LABEL | cut -d "U" -f 1;
```
#### G. Monter les partitions (Réperter l'opération 2 fois)
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

#### 1. Installation des paquets (Base)
```shell
clear;
pacstrap /mnt base;
pacstrap /mnt base-devel;
pacstrap /mnt bash-completion;
pacstrap /mnt curl;
pacstrap /mnt dhclient;
pacstrap /mnt dhcpcd;
pacstrap /mnt dnsutils;
pacstrap /mnt fakeroot;
pacstrap /mnt git;
pacstrap /mnt go;
pacstrap /mnt intel-ucode;
pacstrap /mnt iwd;
pacstrap /mnt iw;
pacstrap /mnt linux;
pacstrap /mnt linux-firmware;
pacstrap /mnt logrotate;
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

#### 1. Installation des paquets (Supplémentaire)

**Gestionnaire de Connexion**
```shell
clear;
pacstrap /mnt sddm;
```

**XFCE4** (Pas testé)
```shell
clear;
pacstrap /mnt xfce4;
pacstrap /mnt xfce4-goodies;
pacstrap /mnt xfce4-dev-tools;
pacstrap /mnt gvfs;
pacstrap /mnt thunar-archive-plugin;
pacstrap /mnt thunar-media-tags-plugin;
pacstrap /mnt thunar-volman xfdesktop;
```

**Supplément** (Pas testé)
```shell
clear;
pacstrap /mnt pavucontrol; # Contrôleur de son
pacstrap /mnt pipewire;    # Son
                           #systemctl --user enable --now pipewire
```

```
# https://wiki.archlinux.fr/services
```

#### 2. FSTAB
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
clear;
UUID_SYSTEM=$(blkid | grep 'LABEL="SYSTEM" UUID=' | cut -d '"' -f 4);
echo "timeout 3
default  arch01.conf
editor no" > /boot/loader/loader.conf;


echo "title Arch Linux (Normal)
linux /vmlinuz-linux
initrd /initramfs-linux.img
initrd /intel-ucode.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch01.conf;


echo "title Arch Linux (Recovery)
linux /vmlinuz-linux
initrd /initramfs-linux-fallback.img
initrd /intel-ucode.img
options root=UUID=$UUID_SYSTEM rw" > /boot/loader/entries/arch02.conf;

bootctl update;
bootctl;
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

#### Yaourt (V2)
```shell
clear;
git clone https://aur.archlinux.org/yay.git /tmp/yay;
cd /tmp/yay && makepkg -si --noconfirm;
cd;
```

------------------------------------------------------------------
#### Récupération des information Système 
```shell
clear;
sudo lspci -nn -s $(lspci | grep Wireless | cut -c 1-7);
sudo lspci -n  -s $(lspci | grep Wireless | cut -c 1-7);
sudo lspci -v  -s $(lspci | grep Wireless | cut -c 1-7);
sudo lspci -vv -s $(lspci | grep Wireless | cut -c 1-7);
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
mkdir -p /root/scripts;
echo "####################################
clear;
systemctl \$1 systemd-resolved;
systemctl \$1 systemd-networkd;
systemctl \$1 systemd-timesyncd;
systemctl \$1 smb;
systemctl \$1 sddm;
systemctl \$1 sshd;
systemctl \$1 iwd;

# Expérimental:
# systemctl --user enable --now pipewire

####################################" > /root/scripts/services.sh;

echo "INTERFACE='wlan0'
SSID='ASUS_A8_5G'
KEY='Azerty74@123'
iwctl station \$INTERFACE connect \$SSID --passphrase \$KEY;" > /root/scripts/wifi.sh;


echo "journalctl -u systemd-resolved"  > /root/scripts/resolved.sh;
echo "journalctl -u systemd-networkd"  > /root/scripts/networkd.sh;
echo "journalctl -u systemd-timesyncd" > /root/scripts/timesyncd.sh;
echo "journalctl -u smb"               > /root/scripts/smb.sh;
echo "journalctl -u sddm"              > /root/scripts/sddm.sh;
echo "journalctl -u sshd"              > /root/scripts/sshd.sh;
echo "journalctl -u iwd"               > /root/scripts/iwd.sh;
```

**Réseau**
```
echo 'rm -f /etc/systemd/network/*

echo "[Match]
Name=$(ip link | grep wlan | cut -c 4-8)

[Network]
DHCP=ipv4" > /etc/systemd/network/2-$(ip link | grep wlan | cut -c 4-7).network;

clear;
cat /etc/systemd/network/2-$(ip link | grep wlan | cut -c 4-7).network;' > /root/scripts/wlan_dhcp.sh;
```

```
echo 'rm -f /etc/systemd/network/*

echo "[Match]
Name=$(ip link | grep wlan | cut -c 4-8)

[Network]
DHCP=no
Address=192.168.1.9/24
Gateway=192.168.1.1
DNS=192.168.1.1
DNS=192.168.1.31" > /etc/systemd/network/2-$(ip link | grep wlan | cut -c 4-7).network;

clear;
cat /etc/systemd/network/2-$(ip link | grep wlan | cut -c 4-7).network;' > /root/scripts/wlan_static.sh;
```

**Alternative** (Action sous le LiveCD hors CHROOT)
```shell
clear;
cp /etc/systemd/network/* /mnt/etc/systemd/network;
```

------------------------------------------------------------------
#### Post Démarrage

**Services**
```shell
clear;
#Gestion Service:
/root/scripts/services.sh start;
/root/scripts/services.sh enable;
/root/scripts/wlan_dhcp.sh;
/root/scripts/wlan_static.sh;
/root/scripts/wifi.sh;
```


------------------------------------------------------------------
#### Articles
```
https://fhackts.wordpress.com/2016/09/09/installing-archlinux-the-efisystemd-boot-way/?unapproved=970&moderation-hash=e8e626944f7a8bca05805782c535eaf4#comment-970
https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d
```
