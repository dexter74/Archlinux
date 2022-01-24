```
rm -r /etc/pacman.d/gnupg;
pacman-key --init;
pacman-key --populate archlinux; 
pacman-key --updatedb;
pacman-key --refresh-keys;
```
