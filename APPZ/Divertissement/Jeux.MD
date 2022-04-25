### Wine


Pour les applications avec un rendu HTML, il vous faut installer en plus wine_gecko.


**Installation de Wine** (Pacman)

[Wine](https://archlinux.org/packages/multilib/x86_64/wine/)

[WineTricks](https://archlinux.org/packages/multilib/x86_64/winetricks/)

```
pacman -S --noconfirm wine ;
pacman -S --noconfirm wine-staging-git ;
```


----------------------------------------------------------------------------------------------------
**Installation de Wine ** (Aur)
[Wine](https://aur.archlinux.org/packages/wine-git)

[Wine-Stable](https://aur.archlinux.org/packages/wine-stable/)

[Wine-Stagging](https://aur.archlinux.org/packages/wine-staging-git/)

[WineTricks](https://aur.archlinux.org/packages/winetricks-git/)

```
yay -S --noconfirm wine winetricks ;
https://aur.archlinux.org/packages/winetricks-git/
```
----------------------------------------------------------------------------------------------------

**Définir l'architecture de Wine**

```bash
WINEARCH=win32 winecfg
WINEARCH=win64 winecfg
```

**Environnement séparée:
```bash
WINEARCH=win32 WINEPREFIX=~/win32 winecfg 
WINEARCH=win64 WINEPREFIX=~/win64 winecfg
```

----------------------------------------------------------------------------------------------------

**ProtonUp-qt**
``` 
Permet de configurer ProtonDB, Wine et Lutris.
``` 
