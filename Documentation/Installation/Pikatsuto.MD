### Présentation
```
Disk 0: Windows
Disk 1: ArcLinux
Disk 2: VM
Disk 3: Data (Raid Matériel)
Il faut installer le Pilote Raid en premier. (User, Dépendance / YAY)
```

```YAML
nvme0n1p: NTFS (Windows)
 > nvme0n1p1 = EFI System
 > nvme0n1p2 = Microsoft ReservedPartition
 > nvme0n1p3 = Basic Data Partition (Windows)
 > nvme0n1p4 = Windows Recovery

SDA:
 - 512M Boot
 -   4G SWAP
 - 225G LVM2 (35G Sys | 180G Home)

SDB: VM

SDC: NTFS (Data)
```

------------------------------------------------------------------------------------------

### Pilote Raid
```
Pour installer le Pilote, il faut YAY qui lui à besoin:
 - Un compte USER
 - Dépendance
```

#### A. Compte USER
```
/usr/sbin/useradd \
  --home-dir /home/marc --base-dir /home/marc \
  --uid 1005 \
  --groups wheel,storage,power --no-user-group \
  --shell /bin/bash \
  --comment 'Drthrax' \
  --create-home marc;

(echo "admin"; echo "admin") | passwd marc;
(echo "root";  echo "admin") | passwd root;
```

#### B. Dépendances
```
pacman -S --noconfirm fakeroot go;
```

#### C. Connexion au compte User
```
su - marc
```

#### D. Installation de YAY
```
cd /tmp ;
git clone https://aur.archlinux.org/yay.git;
cd yay ;
makepkg -si --noconfirm;
cd /tmp ;
```

#### E. Pilote Raid ([ici](https://aur.archlinux.org/packages/rcraid-dkms/))
```
yay -S --noconfirm rcraid-dkms;
```

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

#### X. Note de Travaille

```
https://github.com/thopiekar/rcraid-dkms
```
