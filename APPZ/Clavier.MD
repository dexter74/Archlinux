Problème: Le Verrouillage numérique ne fonctionne que sur les caractères alphanumériques. (a-Z)
Correctif:
```
nano /usr/share/X11/xkb/symbols/fr
include "latin9"
include "mswindows-capslock"
``` 

```
echo 'partial alphanumeric_keys
xkb_symbols "basic" {
    key <AE01>	{ type= "FOUR_LEVEL_ALPHABETIC", [ ampersand,          1,          bar,   exclamdown ]	};
    key <AE02>	{ type= "FOUR_LEVEL_ALPHABETIC", [    eacute,          2,           at,    oneeighth ]	};
    key <AE03>	{ type= "FOUR_LEVEL_ALPHABETIC", [  quotedbl,          3,   numbersign,     sterling ]	};
    key <AE04>	{ type= "FOUR_LEVEL_ALPHABETIC", [apostrophe,          4,   onequarter,       dollar ]	};
    key <AE05>	{ type= "FOUR_LEVEL_ALPHABETIC", [ parenleft,          5,      onehalf, threeeighths ]	};
    key <AE06>	{ type= "FOUR_LEVEL_ALPHABETIC", [   section,          6,  asciicircum,  fiveeighths ]	};
    key <AE07>	{ type= "FOUR_LEVEL_ALPHABETIC", [    egrave,          7,    braceleft, seveneighths ]	};
    key <AE08>	{ type= "FOUR_LEVEL_ALPHABETIC", [    exclam,          8,  bracketleft,    trademark ]	};
    key <AE09>	{ type= "FOUR_LEVEL_ALPHABETIC", [  ccedilla,          9,    braceleft,    plusminus ]	};
    key <AE10>	{ type= "FOUR_LEVEL_ALPHABETIC", [    agrave,          0,   braceright,       degree ]	};
};' > /usr/share/X11/xkb/symbols/mswindows-capslock

```

Source: 

https://forum.ubuntu-fr.org/viewtopic.php?id=1468491

https://doc.ubuntu-fr.org/utiliser_verr_maj_pour_ecrire_des_chiffres
