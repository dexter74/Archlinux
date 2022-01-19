

**USER**
```
/usr/sbin/useradd \
  --home-dir /home/marc --base-dir /home/marc \
  --uid 1005 \
  --groups wheel,storage,power --no-user-group \
  --shell /bin/bash \
  --comment 'Drthrax' \
  --create-home marc;
(echo "admin"; echo "admin") | passwd marc;
(echo "root"; echo "root")  | passwd root;
```

```
su - marc
```


## YAY

#### A. Pré-Requis

```
pacman -Sy fakeroot
```


```
cd /tmp ;
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
cd /tmp ;
```
