#### Installation de Cinnamon
```bash
# pacman-key --populate;
pacman -Sy --noconfirm cinnamon;
systemctl enable --now sddm;
systemctl restart sddm;
```

```bash
pacman -S --noconfirm cinnamon-translations;
pacman -S --noconfirm gnome-{terminal,screenshot,calculator};
pacman -S --noconfirm gnome-extra;
pacman -S --noconfirm eog;
pacman -S --noconfirm evince;
pacman -S --noconfirm file-roller;
pacman -S --noconfirm gedit;
pacman -S --noconfirm lightdm-gtk-greeter;
pacman -S --noconfirm rhythmbox;
pacman -S --noconfirm shotwell;
pacman -S --noconfirm system-config-printer;

```
