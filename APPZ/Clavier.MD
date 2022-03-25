Problème: Le Verrouillage numérique ne fonctionne que sur les caractères alphanumériques. (a-Z)
Correctif:
```
#Chercher Ligne:
grep -n 'include "latin"'  /usr/share/X11/xkb/symbols/fr;

#Insertion à la ligne 4.  
sed -i '4i include "mswindows-capslock"' /usr/share/X11/xkb/symbols/fr;

#Combinaison de touche
echo 'partial alphanumeric_keys
xkb_symbols "basic" {
    //          Unmodified                             Shift           AltGr             Shift+AltGr
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
    key <AE11>  { type= "FOUR_LEVEL_ALPHABETIC", [ parenright,    degree,  bracketright,    notequal ]  }; //Latin9
    key <AE12>  { type= "FOUR_LEVEL_ALPHABETIC", [      equal,      plus,  braceright,     plusminus ]  }; //Latin9
};' > /usr/share/X11/xkb/symbols/mswindows-capslock;
#Vérification: (4: include "mswindows-capslock")
grep -n mswindows-capslock /usr/share/X11/xkb/symbols/fr;
```


Source: [Forum Ubuntu](https://forum.ubuntu-fr.org/viewtopic.php?id=1468491) | [Doc.Ubuntu](https://doc.ubuntu-fr.org/utiliser_verr_maj_pour_ecrire_des_chiffres)
