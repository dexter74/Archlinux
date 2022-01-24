[Présentation](https://kde.org/plasma-desktop/)

**Update**
```
pacman -Sy;
```


**Minimal**
```bash
pacman -S plasma-desktop;
systemctl enable --now sddm;
systemctl restart sddm;
```



**Installer [KDE](https://wiki.archlinux.fr/KDE) :** (groupe plasma)
```
pacman -S --noconfirm plasma;
```

**Groupe Plasma**

[plasma](): 

[bluedevil](https://archlinux.org/packages/extra/x86_64/bluedevil/): Intégrez la technologie Bluetooth dans l’espace de travail et les applications KDE

[breeze](https://archlinux.org/packages/kde-unstable/x86_64/breeze/): Themes.

[breeze-gtk](https://archlinux.org/packages/extra/any/breeze-gtk/): Themes.

[discover](https://archlinux.org/packages/extra/x86_64/discover/): Interface graphique de gestion des ressources KDE et Plasma

[drkonqi](https://archlinux.org/packages/extra/x86_64/drkonqi/): Le gestionnaire de crash KDE

[kactivitymanagerd](https://archlinux.org/packages/extra/x86_64/kactivitymanagerd/): Service système pour gérer les activités des utilisateurs et suivre les modèles d’utilisation

[kde-cli-tools](https://archlinux.org/packages/extra/x86_64/kde-cli-tools/): 

[kde-gtk-config](https://archlinux.org/packages/extra/x86_64/kde-gtk-config/): 

[kdecoration](https://archlinux.org/packages/extra/x86_64/kdecoration/): 

[kdeplasma-addons](https://archlinux.org/packages/extra/x86_64/kdeplasma-addons/): 

[kgamma5](https://archlinux.org/packages/extra/x86_64/kgamma5/): 

[khotkeys](https://archlinux.org/packages/extra/x86_64/khotkeys/): 

[kinfocenter](https://archlinux.org/packages/extra/x86_64/kinfocenter/): Information sur le PC.

[kmenuedit](https://archlinux.org/packages/extra/x86_64/kmenuedit/): Editeur Menu KDE.

[kscreen](https://archlinux.org/packages/extra/x86_64/kscreen/): Logiciel de gestion d’écran KDE.

[kscreenlocker](https://archlinux.org/packages/extra/x86_64/kscreenlocker/): Bibliothèque et composants pour une architecture d’écran de verrouillage sécurisée.

[ksshaskpass](https://archlinux.org/packages/extra/x86_64/ksshaskpass/): ssh-add helper qui utilise kwallet et kpassworddialog.

[ksystemstats](https://archlinux.org/packages/extra/x86_64/ksystemstats/): Un démon de surveillance du système basé sur un plugin.

[kwallet-pam](https://archlinux.org/packages/extra/x86_64/kwallet-pam/): Intégration DE KWallet PAM.

[kwayland-integration](https://archlinux.org/packages/extra/x86_64/kwayland-integration/): Fournit des plugins d’intégration pour divers frameworks KDE pour le système de fenêtrage wayland.

[kwayland-server](https://archlinux.org/packages/extra/x86_64/kwayland-server/): Composants serveur Wayland basés sur des frameworks KDE.

[kwin](https://archlinux.org/packages/extra/x86_64/kwin/): Un gestionnaire de fenêtres composite facile à utiliser, mais flexible.

[kwrited](https://archlinux.org/packages/extra/x86_64/kwrited/): Démon KDE écoutant les murs et écrivant des messages.

[layer-shell-qt](https://archlinux.org/packages/extra/x86_64/layer-shell-qt/): Composant Qt pour permettre aux applications d’utiliser le protocole Wayland wl-layer-shell.

[libkscreen](https://archlinux.org/packages/extra/x86_64/libkscreen/): 

[libksysguard](https://archlinux.org/packages/extra/x86_64/libksysguard/): Bibliothèque pour récupérer des informations sur l’état actuel du matériel informatique

[milou](https://archlinux.org/packages/extra/x86_64/milou/): Une application de recherche dédiée construite sur Baloo

[oxygen](https://archlinux.org/packages/extra/x86_64/oxygen/): Style KDE Oxygène

[plasma-browser-integration](https://archlinux.org/packages/extra/x86_64/plasma-browser-integration/): Composants nécessaires à l’intégration des navigateurs dans Plasma Desktop

[plasma-desktop](https://archlinux.org/packages/extra/x86_64/plasma-desktop/): Bureau plasma KDE

[plasma-disks](https://archlinux.org/packages/extra/x86_64/plasma-disks/): Surveille les périphériques compatibles S.M.A.R.T. en cas de défaillance imminente

[plasma-firewall](): 

[plasma-integration](): 

[plasma-nm](): 

[plasma-pa](): 

[plasma-sdk](): 

[plasma-systemmonitor](): 

[plasma-thunderbolt](): 

[plasma-vault](): 

[plasma-workspace](): 

[plasma-workspace-wallpapers](): 

[polkit-kde-agent](): 

[powerdevil](): 

[sddm-kcm](): 

[systemsettings](): 

[xdg-desktop-portal-kde](): 



**Extras**
```
pacman -S --noconfirm plasma-meta;
pacman -S --noconfirm kde-applications;
pacman -S --noconfirm kde-applications-meta;
```

**Supports**
```
Les Applications Qt5 > installé qtcurve-qt5 | qtcurve-kde 
Les Applications Qt4 > installé qtcurve-qt4
```
