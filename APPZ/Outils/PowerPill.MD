rm -R /etc/pacman.d/gnupg/
rm -R /root/.gnupg/
gpg --refresh-keys
pacman-key --init && pacman-key --populate archlinux manjaro
pacman-key --refresh-keys


pacman -Sy
 
yay -S --noconfirm  python3-xcgf python3-memoizedb  python3-xcpf  pm2ml  powerpill
