# Installation de Gnome-Shell et Gnome-Tweak-tool

**Dépendance**
````bash
clear;
sudo pacman -S --asexplicit --noconfirm cmake jq
````

**User**
````bash
su - marc
````

**Compilation**
````
clear;
git clone https://aur.archlinux.org/chrome-gnome-shell.git /tmp/chrome-gnome-shell;
cd /tmp/chrome-gnome-shell/;
(echo "o") | makepkg -si;
````


**Installation**
````bash
clear;
sudo pacman -U chrome-gnome-shell-10.1-5-any.pkg.tar.zst;
sudo pacman -S --asexplicit --noconfirm gnome-tweak-tool;
````
