
```
==> WARNING: Possibly missing firmware for module: isci 
==> WARNING: Possibly missing firmware for module: advansys (linux-firmware)
==> WARNING: Possibly missing firmware for module: aic94xx
==> WARNING: Possibly missing firmware for module: cxgb4
==> WARNING: Possibly missing firmware for module: csiostor
==> WARNING: Possibly missing firmware for module: qed
==> WARNING: Possibly missing firmware for module: qla1280
==> WARNING: Possibly missing firmware for module: cxgb3
==> WARNING: Possibly missing firmware for module: bfa
==> WARNING: Possibly missing firmware for module: qla2xxx
==> WARNING: Possibly missing firmware for module: wd719x
==> WARNING: Possibly missing firmware for module: xhci_pci
==> WARNING: Possibly missing firmware for module: ums_eneub6250
==> WARNING: Possibly missing firmware for module: softing_cs
```

**Root**
```bash
sudo pacman -S --noconfirm open-iscsi ;
```

**Marc**
```bash
su - marc ;
```

**Yaourt**
```bash
clear ;
cd /tmp ;
rm -r -f /tmp/* ;
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
```

**Mise à jour**
```bash
pacman -Sy ;
```

```bash
clear ;
yay -S --noconfirm aic94xx-firmware wd719x-firmware upd72020x-fw ;
```

----------------------------------------

**Montage des partitions via SystemD** ([ici](https://dev.to/adarshkkumar/mount-a-volume-using-systemd-1h2f)

```
blkid ;
/dev/sda1: UUID="cb0b5d86-1011-433d-ba1a-53fdce9c25b0" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="b03dd290-3135-8b43-a729-f6c2aaa67579"

/dev/sdb2: UUID="dovlXS-05Hq-LwxU-E4dT-2ZPs-N9WC-TsqF2c" TYPE="LVM2_member" PARTUUID="c3ca6f65-8de8-7346-a3d8-29687b67b31f"
/dev/sdb1: UUID="1AA2-3D9A" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="cad15573-3758-b049-9a39-53cea032890b"

/dev/sdc5: LABEL="Data-Save" BLOCK_SIZE="512" UUID="01D5A551344B1ED0" TYPE="ntfs" PARTUUID="5dd99c75-05"
/dev/sdc6: LABEL="Travaille" BLOCK_SIZE="512" UUID="01D5A55135F1A2E0" TYPE="ntfs" PARTUUID="5dd99c75-06"
/dev/sdc7: LABEL="Data" BLOCK_SIZE="512" UUID="01D5A550CF1193A0" TYPE="ntfs" PARTUUID="5dd99c75-07"
/dev/sdc8: LABEL="Data-Sup" BLOCK_SIZE="512" UUID="01D5A550D0996C20" TYPE="ntfs" PARTUUID="5dd99c75-08"

/dev/sdd1: UUID="ee2b4bfb-c7c6-46cc-9733-fd5e67c64c1e" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="aefc6397-8c27-ad4f-b51a-82330479a76d"

/dev/nvme0n1p1: UUID="96C1-3231" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="073ea728-8b47-4e65-81dd-ae2afebbb91b"
/dev/nvme0n1p2: PARTLABEL="Microsoft reserved partition" PARTUUID="ded07e40-6a99-498e-b251-229279e398e6"
/dev/nvme0n1p3: BLOCK_SIZE="512" UUID="923EC1EB3EC1C885" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="c0d28dcb-6964-4c0d-8ffc-6a5f3b4296ac"
/dev/nvme0n1p4: BLOCK_SIZE="512" UUID="828A01498A013AE5" TYPE="ntfs" PARTUUID="7f51bb21-2d76-47f0-952e-1d09bb0f1199"
```


```bash
mkdir -p /mnt/data-save /mnt/travaille /mnt/data /mnt/data-sup ;
```


```bash
systemctl edit --full --force mnt-data.save.mount ;
systemctl edit --full --force mnt-travaille.mount ;
systemctl edit --full --force mnt-data.mount ;
systemctl edit --full --force mnt-data-sup.mount ;
```

```
echo "
[Unit]
Description=Additional drive

[Mount]
What=/dev/sdc7
Where=/mnt/data
Type=ntfs
Options=defaults

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/mnt-data.mount ;
```

```
systemctl daemon-reload ;
systemctl restart mnt-data.mount ;
```
