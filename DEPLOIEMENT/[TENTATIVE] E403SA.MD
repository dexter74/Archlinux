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
