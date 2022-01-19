### Présentation
```
Un Raid Logiciel qui est présent sur la machine.
Il faut installé le pilote Raid
```

### Pilote Raid
```
Pour installer le Pilote, il faut YAY qui lui à besoin:
 - Un compte USER
 - Dépendance
```

#### A. Compte USER
```
/usr/sbin/useradd \
  --home-dir /home/marc --base-dir /home/marc \
  --uid 1005 \
  --groups wheel,storage,power --no-user-group \
  --shell /bin/bash \
  --comment 'Drthrax' \
  --create-home marc;

(echo "admin"; echo "admin") | passwd marc;
(echo "root";  echo "admin") | passwd root;
```

#### B. Dépendances
```
pacman -S --noconfirm fakeroot go
```

#### C. Connexion au compte User
```
su - marc
```

#### D. Installation de YAY
```
cd /tmp ;
git clone https://aur.archlinux.org/yay.git ;
cd yay ;
makepkg -si --noconfirm ;
cd /tmp ;
```
