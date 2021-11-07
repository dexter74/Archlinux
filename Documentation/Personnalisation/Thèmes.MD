[Guide](https://wiki.xfce.org/fr/howto/install_new_themes)

```
REMARQUE : Il est aussi possible que le thème contienne des fichiers *.svg , dans ce cas, la bibliothèque librsvg est recommandée pour une meilleure intégration du thème.
pacman -S --noconfirm librsvg ;
```


**ocs-urls**
```
pacman -S --noconfirm qt5-base qt5-svg qt5-declarative qt5-quickcontrols
yay    -S --noconfirm ocs-url ; # Outils pour télécharger thèmes 
```

**Dossiers**
```
/usr/share/themes
/usr/share/icons
/usr/share/plank/themes
```


**Gestionnaire de Fenêtre**
```
# Apple-Arc-OSX
cd /tmp ;
wget https://dl1.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE0NjgzMzAzNDEiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjA2YTdjNjFhZDQ5YjdhOWQyMGU1NWVkMWExOTQ4Nzg4NTVkNGZmMGU4ODMxODg3ZDJkYzBmMmE3NWU3ZWFkOGIzMjk2MDE0MTgyNzk3OWFjMmRhNGZlZGI0MWM0NTBhZTY1YmQ3YWY4NmJhZjNmYWNmOGExOWQ5ZDk2YjEyODIzIiwidCI6MTYzNjI1MzM4OCwic3RmcCI6ImZlNjUxMjQ1MWQxYmI5YmM5NmI1MzA5NDZjY2ZmY2NiIiwic3RpcCI6Ijg5Ljg3LjIyLjAifQ.prlhiPXQT9PbmArmi-G7x81ne50NqX933m4eUq0SqYc/Apple-Arc-OSX.zip ;
unzip Apple-Arc-OSX.zip ; mv Apple-Arc-OSX /usr/share/themes ;

# WhiteSur-dark
wget https://dl3.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE2MzQ4MDM5MjkiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImY5MDU3ZDMxMDQyNjg5NTg3ZjY2ODQyNDg1Njc0NzQ3NjViYTliNTkxMjhjNGNhZmJjNjRmMmIzMmMwMGU3ZWVmOTY5NzBlNDMxNzkzNWVkZjQzYjlkZjY5NzM5ZWEyYzNmMzc0Mzg4MGY2MzQ1NTRiY2FkMGNjMGUxMzA4NzFlIiwidCI6MTYzNjI1Mzc3Nywic3RmcCI6ImZlNjUxMjQ1MWQxYmI5YmM5NmI1MzA5NDZjY2ZmY2NiIiwic3RpcCI6Ijg5Ljg3LjIyLjAifQ.ylKwh6osSvnDfLYuledwUERpTDkTsP7D3tIcsv31Z_U/WhiteSur-dark.tar.xz
tar xvf WhiteSur-dark.tar.xz ; cp -r WhiteSur-dark /usr/share/themes ; mv WhiteSur-dark  /usr/share/plank/themes ; 

```



