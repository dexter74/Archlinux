Problème: Le Verrouillage numérique ne fonctionne que sur les caractères alphanumériques. (a-Z)
Correctif:
```
echo "keycode 0x42 =  Shift_Lock   NoSymbol   Shift_Lock" > .xmodmap-shiftlock
``` 
Ajouter le script au démarrage de la session.


Source: https://forum.ubuntu-fr.org/viewtopic.php?id=1468491
