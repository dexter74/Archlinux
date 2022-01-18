# Installation de Gnome-Shell et Gnome-Tweak-tool

**User**

````bash
su - marc
````

**Compilation**
````
sudo pacman -S --asexplicit --noconfirm cmake jq
git clone https://aur.archlinux.org/chrome-gnome-shell.git /tmp/chrome-gnome-shell;
cd /tmp/chrome-gnome-shell/;
(echo "o") | makepkg -si;
````


**Installation**
````bash
sudo pacman -U chrome-gnome-shell-10.1-5-any.pkg.tar.zst;
sudo pacman -S --asexplicit --noconfirm gnome-tweak-tool;
````


**[Flatpak](https://doc.ubuntu-fr.org/flatpak)**
````bash
sudo pacman -S --asexplicit --noconfirm flatpak;
````

**Chromium**
````bash
sudo pacman -S --asexplicit --noconfirm chromium;
````

**Relance de l'interface**
````bash
sudo systemctl restart sddm;
````


**Menu**
````
Aller dans Activités en haut à Gauche
puis ajouter: Extensions, Ajustements (tweak)
````

**Chromium** (Extension)
````
https://extensions.gnome.org/
Installer l'extension Gnome Extension pour le Navigateur en premier
Rafraichir la page https://extensions.gnome.org/
````

**Extension**
````
ArcMenu
Arch Linux Updates Indicator
Bluetooth Quick Connect
Containers
Dash to Dock
Dash to Panel
Disconnext Wifi
IdeaPad
Tray icons: Reloaded
User Themes

````

**Thème**
````
sudo pacman -S --asexplicit --noconfirm gtk-engine-murrine gnome-themes-extra sassc;
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git;
cd Graphite-gtk-theme/
./install.sh;
````
