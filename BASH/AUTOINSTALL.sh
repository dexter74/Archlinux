
#!/bin/sh
clear;

set ETAT=

###################################################################################################################################################
# Fonctions #
#############
DISK(){
  # Afficher les Disques-dur:
  fdisk -l | grep "^/dev"  | cut -d " " -f 1 ;
  echo -n "Nom du disque-dur: "              ; read DISK       ;
  echo -n "Taille de la partition BOOT: "    ; read SIZE_BOOT  ;
  echo -n "Taille de la partition SYSTEM: "  ; read SIZE_SYST  ;
  echo -n "Taille de la partition HOME: "    ; read SIZE_HOME  ;
  echo -n "Nom du Volume Group: "            ; read LVM_NAMEVG ;
}

###################################################################################################################################################

if [ ETAT = 0 ] 
 then
  echo "OK"
 elif
  echo "ECHEC"
 else
  echo "Le script est KO"
fi
