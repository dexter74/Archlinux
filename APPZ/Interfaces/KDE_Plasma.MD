#### [Présentation](https://kde.org/plasma-desktop/)

-------------------------------------------------------------------------------------------------------------------------------------
#### Installation Complète ([Plasma](https://wiki.archlinux.fr/KDE) | 1,4 Go) 
```
clear;
pacman -S plasma;
systemctl enable --now sddm;
systemctl restart sddm;
```

-------------------------------------------------------------------------------------------------------------------------------------
### Installation Sélectif:

```
#GUI
pacman -S bluedevil discover kde-cli-tools kde-gtk-config kdeplasma-addons

systemctl enable --now sddm;
systemctl restart sddm;
```

-------------------------------------------------------------------------------------------------------------------------------------


[bluedevil](https://archlinux.org/packages/extra/x86_64/bluedevil/): Intégrez la technologie Bluetooth dans l’espace de travail et les applications KDE

[breeze](https://archlinux.org/packages/kde-unstable/x86_64/breeze/): Themes.

[breeze-gtk](https://archlinux.org/packages/extra/any/breeze-gtk/): Themes.

[discover](https://archlinux.org/packages/extra/x86_64/discover/): Interface graphique de gestion des ressources KDE et Plasma

[drkonqi](https://archlinux.org/packages/extra/x86_64/drkonqi/): Le gestionnaire de crash KDE

[kactivitymanagerd](https://archlinux.org/packages/extra/x86_64/kactivitymanagerd/): Service système pour gérer les activités des utilisateurs et suivre les modèles d’utilisation

[kde-cli-tools](https://archlinux.org/packages/extra/x86_64/kde-cli-tools/): Outils basés sur KDE Frameworks 5 pour mieux interagir avec le système

[kde-gtk-config](https://archlinux.org/packages/extra/x86_64/kde-gtk-config/): Configurateur GTK2 et GTK3 pour KDE

[kdecoration](https://archlinux.org/packages/extra/x86_64/kdecoration/): Bibliothèque basée sur un plugin pour créer des décorations de fenêtre

[kdeplasma-addons](https://archlinux.org/packages/extra/x86_64/kdeplasma-addons/): Toutes sortes d’addons pour améliorer votre expérience Plasma

[kgamma5](https://archlinux.org/packages/extra/x86_64/kgamma5/): Ajustez les paramètres gamma de votre moniteur

[khotkeys](https://archlinux.org/packages/extra/x86_64/khotkeys/): Déclencher des actions lorsque certaines touches sont enfoncées

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

[libkscreen](https://archlinux.org/packages/extra/x86_64/libkscreen/): Logiciel de gestion d’écran KDE

[libksysguard](https://archlinux.org/packages/extra/x86_64/libksysguard/): Bibliothèque pour récupérer des informations sur l’état actuel du matériel informatique

[milou](https://archlinux.org/packages/extra/x86_64/milou/): Une application de recherche dédiée construite sur Baloo

[oxygen](https://archlinux.org/packages/extra/x86_64/oxygen/): Style KDE Oxygène


[plasma-browser-integration](https://archlinux.org/packages/extra/x86_64/plasma-browser-integration/): Composants nécessaires à l’intégration des navigateurs dans Plasma Desktop

[plasma-desktop](https://archlinux.org/packages/extra/x86_64/plasma-desktop/): Bureau plasma KDE

[plasma-disks](https://archlinux.org/packages/extra/x86_64/plasma-disks/): Surveille les périphériques compatibles S.M.A.R.T. en cas de défaillance imminente

[plasma-firewall](https://archlinux.org/packages/extra/x86_64/plasma-firewall/): Panneau de configuration pour le pare-feu de votre système

[plasma-integration](https://archlinux.org/packages/extra/x86_64/plasma-integration/): Plugins d’intégration Qt Platform Theme pour les espaces de travail Plasma

[plasma-nm](https://archlinux.org/packages/extra/x86_64/plasma-nm/): Applet plasma écrite en QML pour la gestion des connexions réseau.

[plasma-pa](https://archlinux.org/packages/extra/x86_64/plasma-pa/): Applet plasma pour la gestion du volume audio à l’aide de PulseAudio ([Pirewire](https://www.reddit.com/r/kde/comments/nj8c97/plasma_audio_applet_for_pipewire/))

[plasma-sdk](https://archlinux.org/packages/extra/x86_64/plasma-sdk): Applications utiles pour le développement de plasma.

[plasma-systemmonitor](https://archlinux.org/packages/extra/x86_64/plasma-systemmonitor): Une interface pour la surveillance des capteurs du système, des informations de processus et d’autres ressources système.

[plasma-thunderbolt](https://archlinux.org/packages/extra/x86_64/plasma-thunderbolt): Intégration plasma pour le contrôle des appareils Thunderbolt.

[plasma-vault](https://archlinux.org/packages/extra/x86_64/plasma-vault): Applet plasma et services pour la création de coffres-forts chiffrés

[plasma-workspace](https://archlinux.org/packages/extra/x86_64/plasma-workspace): Espace de travail plasma KDE

[plasma-workspace-wallpapers](https://archlinux.org/packages/extra/x86_64/plasma-workspace-wallpapers): Fonds d’écran supplémentaires pour l’espace de travail Plasma

[polkit-kde-agent](https://archlinux.org/packages/extra/x86_64/polkit-kde-agent): Démon fournissant une interface utilisateur d’authentification polkit pour KDE

[powerdevil](https://archlinux.org/packages/extra/x86_64/powerdevil): Gère les paramètres de consommation d’énergie d’une coque plasma

[sddm-kcm](https://archlinux.org/packages/extra/x86_64/sddm-kcm): Module de configuration KDE pour SDDM

[systemsettings](https://archlinux.org/packages/extra/x86_64/systemsettings): Gestionnaire de système KDE pour le matériel, les logiciels et les espaces de travail

[xdg-desktop-portal-kde](https://archlinux.org/packages/extra/x86_64/xdg-desktop-portal-): Une implémentation backend pour xdg-desktop-portal à l’aide de Qt/KF5

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
