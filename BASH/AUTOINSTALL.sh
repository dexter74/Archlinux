
#!/bin/sh
clear;
###################################################################################################################################################
case "$1" in 
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 0)
  # --------------------------------------------------------------------------------------------- #
  echo -n "Nom du disque-dur: ";
  read DISK;
  echo -n "Taille de la partition BOOT: ";
  read SIZE_BOOT;
  
  echo -n "Taille de la partition SYSTEM: ";
  read SIZE_SYST;
  
  echo -n "Taille de la partition HOME: ";
  read SIZE_HOME;
  
  echo -n "Nom du Volume Group: ";
  read LVM_NAMEVG;
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 1)
  echo "Choix 2"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 2)
  echo "Choix 3"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 4)
  echo "Choix 4"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 5)
  echo "Choix 5"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 6)
  echo "Choix 6"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 7)
  echo "Choix 7"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 8)
  echo "Choix 8"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 9)
  echo "Choix 9"
  ;;
  
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #
 *)
  echo "Merci de faire un choix entre 1-2"
  ;;
 # ---------------------------------------------------------------------------------------------------------------------------------------------- #

esac
###################################################################################################################################################
